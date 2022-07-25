#include <iostream>
#include <stdio.h>

using namespace std;

//���������� char ���������� ��� ������������� � __asm
char strIn[81];
char strOut[161];

int main()
{
	FILE* outFile;
	// �������� ���������� ����� � �������� �����������
	fopen_s(&outFile, "strOut.txt", "w");

	cout << "Author: " << endl <<"The program for converting decimal digits to octal" << endl;

	fgets(strIn, 81, stdin);// ���������� 80 �������� � �������
	strIn[strlen(strIn) - 1] = '\0';
	__asm {
		push ds
		pop es
		mov esi, offset strIn
		mov edi, offset strOut

		str1 :
			lodsb//��������� � al �� esi
			
			cmp al, '8'
				jne lb1
				mov ax, '01'
				stosw  // ax � edi
				jmp final
			lb1 :

			cmp al, '9'
				jne lb2
				mov ax, '11'
				stosw  // ax � edi
				jmp final
			lb2 :

			stosb//������ � ������ �� ������ edi ��������� ������ ���� �� �����

			final:
		//���� �� ������
		mov  ecx, '\0'
		cmp  ecx, [esi]
		je   strEnd
		jmp  str1

		strEnd :
	};
	cout << strOut;
	//������ ���������� ������ � ����
	fwrite(strOut, sizeof(char), strlen(strOut), outFile);

	return 0;
}