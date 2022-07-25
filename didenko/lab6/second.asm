.586p
.MODEL FLAT, C
.CODE
PUBLIC C second
second PROC C mod_numbers: dword, numbersSize: dword, xmin: dword, intervals: dword, intervalsSize: dword, result: dword

push esi
push edi
push ebp

mov edi, mod_numbers  
mov esi, intervals  
mov ecx, intervalsSize  


for_intervals:  ; ��������� �������� �� ����������
	mov eax, [esi]   
	sub eax, xmin
	mov [esi], eax
	add esi, 4
	loop for_intervals

mov esi, intervals
mov eax, [esi]
mov ecx, intervalsSize
mov ebx, 0 ; ������� ��� result

for_loop:
	push ecx  
	mov ecx, eax ; � eax - ��������� �������� ����� ����������
	push esi  
	mov esi, result ; � esi ������������ ���������

    for_array:
		cmp ecx, 0 
		je end_for
        mov eax, [edi]
        add [esi + 4 * ebx], eax
        add edi, 4
        loop for_array; ���� �������� �� ����� 0 (�.� ���� �� ������� ���� ��������)

end_for:
    inc ebx ; ����������� ������� ��� result
    pop esi 
	mov eax, [esi] ; ���������� ������� ��������
	add esi, 4
	sub eax, [esi] 
	neg eax  ; �������� ��������� �������� ����� ����������
	pop ecx
	loop for_loop

mov esi, result
mov ecx, intervalsSize
mov eax, 0 ; ����� ����� � result

fin_for: 
	add eax, [esi]
	add esi, 4
	loop fin_for

mov esi, result
sub eax, numbersSize 
neg eax ; �������� ����� ���������� �������������� �����

add [esi + 4 * ebx], eax ; �������� ��� ����� � result

pop ebp
pop edi
pop esi

ret
second ENDP
END  