#include <stdio.h>

int main()
{
	long long test64 = 0x1234567812345678;
	printf("test64 = 0x%llx / %lld \n", test64, test64);
       
	long long test96 = 0x123456781234567812345678;
	printf("test96 = 0x%llx / %lld \n", test96, test96);
        
	long long test128 = 0x12345678123456781234567812345678;
	printf("test128 = 0x%llx / %lld \n", test128, test128);

	return 0;
}
