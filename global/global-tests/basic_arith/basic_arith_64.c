#include <stdio.h>
#include <stdint.h>

int main()
{
	uint64_t a = 1200000000;
	uint64_t b = 340000005;
	printf("1200000000 + 340000005 = %ld\n", a + b);
	printf("1200000000 - 340000005 = %ld\n", a - b);
	a = 156000;
	b = 25678;
	printf("156000 * 25678 = %ld\n", a * b);
	printf("156000 / 25678 = %ld\n", a / b);
	printf("15600 modulo 25678 = %ld\n", a % b);
}
