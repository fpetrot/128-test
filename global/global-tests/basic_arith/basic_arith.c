#include <stdio.h>
#include <stdint.h>

int main()
{
	__uint128_t a = 1200000000123;
	__uint128_t b = 340000005678;
	printf("1200000000123 + 340000005678 = %lld\n", a + b);
	printf("1200000000123 - 340000005678 = %lld\n", a - b);
	a = 156000;
	b = 25678;
	printf("156000 * 25678 = %lld\n", a * b);
	printf("156000 / 25678 = %lld\n", a / b);
	printf("15600 modulo 25678 = %lld\n", a % b);
}
