.586
.MODEL FLAT, C
.CODE

PUBLIC C module
module PROC C res1:dword, GrInt: dword, res3: dword, x_max: dword, x_min: dword, n: dword

push esi
push edi

mov esi, GrInt
mov edi, res3
mov ecx, n

lp:
    mov eax, [esi] ; ����� ������� ���������
    mov ebx, [esi + 4] ; ������ �������

    cmp eax, x_min ; ���� eax >= x_min
    jge l2
    mov eax, 0 ; �����, eax = 0, ������ ������� res2

    sub ebx, x_min ; ���� ����� ��������� = 0
    jle l4
    jmp l5

    l2:
        sub ebx, eax ; ���������� ��������� � ���������
        cmp ebx, 0 ; ���� ����� ��������� = 0
        je l4
        sub eax, x_min ; ������ ������� �������� �� �������� ��������� � ������� res1

    l5:
        push esi 
        push ecx

        mov ecx, ebx ; ���������� ��������� �� res1 �� ������� ����� ������
        mov esi, res1 ; ������
        mov ebx, 0 ; ������� ����� ���������� ���������

    lp2: ; ����, ������� �������� ���������, �������� � ��������
       push ecx
       push eax

       mov ecx, [esi + 4*eax] ; ���������� �����
       add eax, x_min ; �����

       lp3:
          
          sub ebx, eax
          loop lp3

       pop eax
       pop ecx

       inc eax
       loop lp2

    pop ecx


    cmp ecx, 1 ; ���� ������������ �� ��������� �������, �� ���������� ����� � ������ ���������
    jne l3
    push ecx
    push eax

    mov ecx, [esi + 4*eax] ; ���������� �����
    add eax, x_min ; �����

    lp4:
          
       sub ebx, eax
       loop lp4

    pop eax
    pop ecx

    l3:

        mov [edi], ebx ; ���������� ���������
        pop esi
        jmp l1

    l4:
        mov [edi], ebx ; ���������� 0, ���� �������� ������

    l1:
        add edi, 4 ; ��������� � ����. ��������� ��������
        add esi, 4
    
    loop lp
   

pop edi
pop esi

ret
module ENDP
END
