.586
.MODEL FLAT, C
.CODE
PUBLIC C mod2
mod2 PROC C res1:dword, intervals:dword, nint:dword, res2:dword, xmin: dword

push esi
push edi

mov esi,res2
mov edi,intervals
mov ecx,xmin ; ��� ��� � ��� ��� ���� ������������� �� ��������� ����������, �� ����� � ������ �������
mov eax,0 ; eax - ������ ����� � ������� ��������� ���������� res1


Cicle:
mov ebx,0 ; ������ �������� ��������� � ������� ����� ������ ����������

Poisk_int:
cmp ecx, [edi+4*ebx] ; ���������� ������� ����� � ����� �������� ���������
jl Obrabotka ; ���� ����� ������ ������� �������, �� ���������� � ���������

Incs: ;���� ����� ������ ������� ����� �������, �� ��������� � ��������� �������
	inc ebx
	jmp Poisk_int

Obrabotka:
	dec ebx ; ��� ��� ������� ebx - ������ ������� ���������, � ������� ������ �����, �� ��������� ������ �� 1
	push edi
	push ecx
	mov edi,res1
	mov edx, [edi+4*eax] ; �������� ���������� ������ ������� �����
	mov ecx,[esi+4*ebx] ; �������� ������� ���-�� ��������� � ��������
	add ecx,edx ; ��������� ����� �� ���� ���������� �����
	mov [esi+4*ebx],ecx ; ��������� ����� � �������������� �������
	pop ecx
	pop edi
	inc eax ; ���������� ������ � ������� ��������� ���������� res1
	inc ecx ; ����������� ������� ��������������� �����
	push eax
	mov eax,nint
	cmp ecx,[edi+eax*4] ; ���������� ������� ��������������� ����� � xmax
	pop eax
	jl Cicle
	
pop edi
pop esi

ret
mod2 ENDP
END