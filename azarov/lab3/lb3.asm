AStack SEGMENT STACK         ;��-�� ��ਡ�� �������஢���� ᥣ���⮢ STACK - ����㧪�  AStack � ॣ���� 
	DW 12 DUP('!')			 ;SS �㤥� �믮����� ��⮬���᪨ �� ��砫� �믮������ �ணࠬ��
AStack ENDS

DATA SEGMENT
    a Dw -5
    b Dw 2
    i Dw -2
    k Dw 1
    i1 Dw 0
    i2 Dw 0
    res Dw 0
DATA ENDS

CODE SEGMENT
    ASSUME CS:CODE, DS:DATA, SS:AStack
	
Main PROC FAR
    push  DS       ;\  ���࠭���� ���� ��砫� PSP � �⥪�
    sub   AX,AX    ; > ��� ��᫥���饣� ����⠭������� ��
    push  AX       ;/  ������� ret, �������饩 ��楤���.
    mov   AX,DATA             ; ����㧪� ᥣ���⭮��
    mov   DS,AX               ; ॣ���� ������.
		  
	
	
f12:
;if a > b	
    mov   ax, i ;ax = i
	shl   ax, 1 ;ax = 2i	
	
	mov   bx, a		
	cmp   bx, b 
	JLE else_f12 ;�᫨ a>=b ᪠箪

then_f12:
	mov i1, 15
	sub  i1, ax	
	
	mov i2, -3
	shl   ax, 1 ;ax = 4i
	sub i2, ax
	jmp end_f2
	
else_f12:
	add   ax, i ;ax = 3i
	mov   i1, ax
	add   i1, 4
	
	mov   i2, -10
	shl   ax, 1 ;ax = 6i
	add   i2, ax
end_f2:



regulate:
;if i1 >= i2	
	mov   ax, i1
	mov   bx, i2		
	cmp   ax, bx 
	JL    swap ;  �᫨ i1<i2 ᪠箪
	JGE   end_reg ;�᫨ i1>=i2 ᪠箪
swap:
	mov   bx, i1
	mov   ax, i2
end_reg:
;⥯��� ax>bx 		
	

f3:	
;if k==0		
	cmp   k, 0h
	JNE else_f3 ; �᫨ k!=0 ᪠箪
	
then_f3:
	mov res, bx
	jmp end_f3
	
else_f3:
	mov res, ax
end_f3:	

	ret

Main ENDP
CODE ENDS
    END Main		  