.586p
.MODEL FLAT, C
.CODE
PUBLIC C first
first PROC C numbers: dword, numbersSize: dword, res: dword, xmin: dword, product_res: dword

push esi
push edi

mov edx,1h
mov edi, product_res
mov [edi], edx

fild dword ptr [edi]

mov edx, numbers 
mov ecx, numbersSize
mov esi, res 


for_:
	fild dword ptr [edx]
	fmul
	mov eax, [edx] ; �������� � eax ��������� �������
	sub eax, xmin ; ������� ��� ������
	mov ebx, [esi + 4*eax]
	inc ebx ; ����������� �������� �� ������� �� 1
	mov [esi + 4*eax], ebx ; �������� � �������. ������
	add edx, 4 ; ��������� � ��.��������
	loop for_ ; ���� ecx != 0

	fst qword ptr [edi]

pop edi
pop esi
ret
first ENDP
END  