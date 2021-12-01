#include <iostream>
#include <windows.h>

int main() {
	SetConsoleCP(1251);
	SetConsoleOutputCP(1251);
	std::cout << "������� ����, ������ 0382" << std::endl <<
		"������� 3: ������������ �������� ������ ������ �� ������� � ��������� ���� ������� ������" << std::endl;
	char inp[80];
	char res[80] = {80 * '\0'};
	std::cin.getline(inp, 80);

	__asm {
		mov edi, 0
		lea esi, inp // ��������� ����� ������ ������� � ��������� ������� ��������� - esi

		start:
		mov ah, [esi] // ������ ���� - �������� �������, ��������� � �������
			// �������� �������� �������� ���������� �� ������
		cmp ah, 0 // ���� �����  ������
		je end

		cmp ah, 192
		jae firstCondForRus

		cmp ah, 97
		jae firstCondForEngTwo

		cmp ah, 65
		jae firstCondForEngOne

		jmp result

		firstCondForRus :
		cmp ah, 255
		jbe secondCond
		jmp result

		firstCondForEngTwo:
		cmp ah, 122
		jbe SecondCond
		jmp result

		firstCondForEngOne :
		cmp ah, 90
		jbe SecondCond
		jmp result

		secondCond :
		mov res[edi], ah
		inc edi
		
		result :
		inc esi
		jmp start
		end :
	}

	std::cout << std::endl << std::endl;
	std::cout << "���������:" << std::endl;
	puts(res);
	std::cout << std::endl << std::endl;

	return 0;
}