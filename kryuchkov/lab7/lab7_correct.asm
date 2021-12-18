AStack  SEGMENT STACK
    DB 1024 DUP(?)
AStack  ENDS

DATA    SEGMENT
    A dd 12345678d	;�������
	Result dd 0	; ��������� �������
	Remainder dw 0	;�������
	res_str db 12 dup (0)
    
    hr	dw	0
    lr	dw	0
DATA    ENDS


CODE    SEGMENT
    ASSUME CS:CODE, DS:data, SS:AStack

start PROC NEAR
	; ������������ ds
	mov ax, data
	mov ds,ax


    call numb_to_string ; �� ��� � Result ��������� � ������ res_str
    ; cx - length
    push cx
    push si
    call print
    

    call str_to_num
    pop si
    pop cx
    
    mov si, offset res_str

    call numb_to_string ; �� ��� � Result ��������� � ������ res_str
    mov si, offset res_str
    call print2
    

    mov ax, 4c00h	; ����� � DOS
	int 21h
start endp 

numb_to_string proc NEAR

    lea si, res_str
	mov cx,0

	; ��������
	mov bx,10

	mov ax, word ptr [A+2]
    mov word ptr [Result+2], ax
	mov ax, word ptr [A]
    mov word ptr [Result], ax


    again:
	; ����� ������� �����
	xor dx,dx	
	mov ax, word ptr [Result+2]
	div bx		

	mov word ptr [Result+2], ax	; ��������� ��������� �� ������� �������� �����
				; � dx ������� �� �������

	; ����� ������� �����
	mov ax,word ptr [Result]
	div bx 
	
	mov word ptr [Result], ax	; ��������� ��������� �� ������� �������� �����
	mov word ptr [Remainder], dx	; ��������� ������� �� �������

	; ��������� ����� � ������ � ��������� 	
	and dx, 0FFh	
	add dx, '0'
	mov [si],dl
	inc si		; �������� ���������� ������� � ������
	inc cx		; ������� ��������

	
	; ���� ������� �� ������� �� ����� 0, �� ��������� ��������
	mov ax, word ptr [Result]
	cmp ax,0
	jnz again
	mov ax, word ptr [Result+2]
	cmp ax,0
	jnz again

    ret 
	; ������ ������ � �������� �������
	; � cx - ����� ������		
numb_to_string ENDP

str_to_num PROC NEAR
; hr lr
; ax - �����
; hr = hr * 10
; lr = lr * 10, dx
; lr = lr + ax
; hr = hr + dx
	lea si, res_str	
	mov bx,10
	xor dx,dx
again_r:
	xor ah,ah
	mov al, [si]
	cmp al,0
	jz exit


	sub ax, '0'	; ax - �����
	
	; hr = hr * 10		                                           
	push ax
	push dx
	mov ax,hr
	mov dx,0
	mul bx
	mov hr,ax
	pop dx
	pop ax

	; lr = lr * 10, dx
	push ax
	mov ax,lr
	mov dx,0
	mul bx
	mov lr,ax
	pop ax

	; lr = lr + ax
	add ax, lr
	mov lr,ax
	

	; hr = hr + dx
	mov ax,hr
	add ax,dx
	mov hr,ax


	inc si
	jmp again_r	
    exit:
        mov ax, hr
        mov dx, lr
        mov word ptr [A+2], ax
        mov word ptr [A], dx
        ret
       

	; ������ ������ � �������� �������
	; � cx - ����� ������	
str_to_num endp

print proc NEAR
print_s:
	mov dl,[si-1]
	mov ah,02h
	int 21h
	dec si
	loop print_s
    ret
print endp

print2 proc NEAR
print_s2:
	mov dl,[si]
	mov ah,02h
	int 21h
	inc si
	loop print_s2
    ret
print2 endp
	
CODE ENDS
     END start 