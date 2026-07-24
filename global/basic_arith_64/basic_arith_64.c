#include <stdio.h>
#include <stdint.h>

#if __riscv_xlen == 128
#define PF64 "ld"
#else
#define PF64 "lld"
#endif

int main()
{
	uint64_t a = 1200000000;
	uint64_t b = 340000005;
	printf("1200000000 + 340000005 = %"PF64"\n", a + b);
	printf("1200000000 - 340000005 = %"PF64"\n", a - b);
	a = 156000;
	b = 25678;
	printf("156000 * 25678 = %"PF64"\n", a * b);
	printf("156000 / 25678 = %"PF64"\n", a / b);
	printf("15600 modulo 25678 = %"PF64"\n", a % b);
}
