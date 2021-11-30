#include <iostream>
#include <fstream>
#include <random>

extern "C" void FUNC(int* array, int array_size, int* left_boarders, int intervals_size, int* result_array);
int main() {
	setlocale(0, "");
	
	int array_size;
	std::cout << "������� ����� ������������ �����: ";
	std::cin >> array_size;
	int xMin, xMax;
	std::cout << "������� ����������� ��������: ";
	std::cin >> xMin;
	std::cout << "������� ������������ ��������: ";
	std::cin >> xMax;
	if (xMax < xMin) {
		std::cout << "������� ������� ������������ � ����������� ��������";
		return 0;
	}
	int intervals_size;
	std::cout << "������� ���������� ����������: ";
	std::cin >> intervals_size;
	if (intervals_size <= 0 or intervals_size > 24) {
		std::cout << "������� ������� ���������� ����������";
		return 0;
	}
	if (intervals_size >= std::abs(xMax - xMin) ) {
		std::cout << "������� ������� ���������� ����������.\n���������� ���������� ������ ���� ������ ����� ��������� ��������� ��������.";
		return 0;
	}
	

	int* left_boarders = new int[intervals_size];
	std::cout << "������� ����� �������: ";
	for (int i = 0; i < intervals_size; i++)
		std::cin >> left_boarders[i];

	for (int i = 0; i < intervals_size - 1; i++) {
		for (int j = i + 1; j < intervals_size; j++) {
			if (left_boarders[j] < left_boarders[i]) {
				std::swap(left_boarders[j], left_boarders[i]);
			}
		}
	}
	if (intervals_size > 0 and left_boarders[0]<xMin){
		std::cout << "��������� ����� ������� ���������� ������ ������������ ���������� ��������";
		return 0;
	}

	std::random_device rd;
	std::mt19937 gen(rd());
	std::normal_distribution<> dis((xMin+xMax)/2, std::abs(xMax-xMin)/4); //https://www.mvorganizing.org/how-do-you-find-standard-deviation-with-max-and-min/
	int* array = new int[array_size];
	for (int i = 0; i < array_size; i++) array[i] = std::round(dis(gen));
	
	std::ofstream file("out.txt");
	file << "��������������� �����: ";
	for (int i = 0; i < array_size; i++) file << array[i] << ' ';
	file << '\n';

	std::cout << "��������������� �����: ";
	for (int i = 0; i < array_size; i++) std::cout << array[i] << ' ';
	std::cout << '\n';

	int* result_array = new int[intervals_size];
	for (int i = 0; i < intervals_size; i++)
		result_array[i] = 0;

	FUNC(array, array_size, left_boarders, intervals_size, result_array);

	std::cout << "����� ��������� \t����� ������� ��������� \t���������� ����� � ���������" << '\n';
	file << "����� ��������� \t����� ������� ��������� \t���������� ����� � ���������" << '\n';
	for (int i = 0; i < intervals_size; i++) {
		std::cout << "\t" << i + 1 << "\t\t\t" << left_boarders[i] << "\t\t\t" << result_array[i] << '\n';
		file << "\t" << i + 1 << "\t\t\t" << left_boarders[i] << "\t\t\t" << result_array[i] << '\n';
	}
	file.close();
	system("pause");
	return 0;
}