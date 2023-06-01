#include <stdio.h>
#include <stdint.h>

int main()
{
	uint32_t a = 12000;
	uint32_t b = 345;
	printf("12345 = %d\n", 12345);
	printf("12000 + 345 = %d\n", a + b);
	printf("12000 - 345 = %d\n", a - b);
	a = 156;
	b = 25;
	printf("156 * 25 = %d\n", a * b);
	printf("156 / 25 = %d\n", a / b);
	printf("156 modulo 25 = %d\n", a % b);
}
