; ��������� �������� ������� ��������� ���������� IntelX86
EOL EQU '$'
ind EQU 2
n1 EQU 500
n2 EQU -50

; ���� ���������
AStack SEGMENT STACK
 DW 12 DUP(?)
AStack ENDS
; ������ ���������
DATA SEGMENT
; ��������� �������� ������
mem1 DW 0
mem2 DW 0
mem3 DW 0
vec1 DB 12,11,10,9,5,6,7,8
vec2 DB -40,-50,40,50,-20,-30,20,30
matr DB 5,6,7,8,-8,-7,-6,-5,1,2,3,4,-4,-3,-2,-1
DATA ENDS

; ��� ���������
CODE SEGMENT
 ASSUME CS:CODE, DS:DATA, SS:AStack

; �������� ���������
Main PROC FAR
 push DS
 sub AX,AX
 push AX
 mov AX,DATA
 mov DS,AX

; �������� ������� ��������� �� ������ ��������
; ����������� ���������
 mov ax,n1
 mov cx,ax
 mov bl,EOL
 mov bh,n2
; ������ ���������
 mov mem2,n2
 mov bx,OFFSET vec1
 mov mem1,ax
; ��������� ���������
 mov al,[bx]
									;mov mem3,[bx]
; ������������ ���������
mov al,[bx]+3
 mov cx,3[bx]

; ��������� ���������
 mov di,ind
 mov al,vec2[di]
									;mov cx,vec2[di]
; ��������� � ������������ � ���������������
 mov bx,3
 mov al,matr[bx][di]
									;mov cx,matr[bx][di]
									;mov ax,matr[bx*4][di]

mov bp,sp
										;mov ax,matr[bp+bx]
										;mov ax,matr[bp+di+si]
; ������������� �������� �����
 push mem1
 push mem2
 mov bp,sp
 mov dx,[bp]+2
 ret 2
Main ENDP
CODE ENDS
 END Main
