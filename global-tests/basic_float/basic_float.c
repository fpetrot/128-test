#include <stdio.h>
#include <stdint.h>

int main()
{
	float a = 1.5;
	float r = a + 6.5;
	//printf("1.5 + 6.5 = %f\n", r);
	printf("1.5 + 6.5 = %e\n", (double) r);
	printf("1.5 + 6.5 = %x\n", (uint32_t) r);
}
