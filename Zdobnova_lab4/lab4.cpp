#include <iostream>
#include <fstream>

int main() {
	char inp[80];
	char res[80];
	std::cin.getline(inp, 80);
	__asm {
		mov edi, 0;
		mov esi, 0;

		Processing:
			mov al, inp[edi]
			cmp al, 'a' //����������, ����� �� ������ ���� ���. ������
			JL Check_num //���������, ����� ��
			cmp al, 'z' //����������, ����� �� ������ ���� ���. ������
			JG Res  //�� ���. �����, ���������� ������ � ���������
			sub al, 32 //���. �����, ������ ������� �������
			JMP Res //���������� � ���������

		Check_num:
			cmp al, 48 //���������, ������ �� ������� '0'
			JL Res  //���, ���������� � ���������
			cmp al, 57  //���������, ������ �� ������ '9'
			JG Res
			mov ah, 105 //����� ��� ���������� ��������
			sub ah, al
			mov al, ah
			JMP Res


		Res:
			mov res[esi], al
			cmp al, 0
			JE End
			inc edi
			inc esi
			JMP Processing

		End:
	}
	std::cout << res;
	std::ofstream fout("fout.txt");
	fout << res;
	fout.close();
	return 0;
}