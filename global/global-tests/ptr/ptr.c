#include <stdio.h>

typedef struct test {
	int a;
	long b;
	long long c;
	int d;
} Test_t;

static Test_t test_array[] = {{0x123, 0x123456789, 0x1234567812345678, 0x456}, {1, 2, 3, 4}};

int main()
{
	void *test64 = (void *) 0x1234567812345678;
	printf("test64 = 0x%llx / %lld \n", test64, test64);
       
	void *test96 = (void *) 0x123456781234567812345678;
	printf("test96 = 0x%llx / %lld \n", test96, test96);
        
	void *test128 = (void *) 0x12345678123456781234567812345678;
	printf("test128 = 0x%llx / %lld \n", test128, test128);

	for (int i = 0; i < 2; i++) {
		printf("at index %d:\n", i);
		printf("-> a = %x:\n", test_array[i].a);
		printf("-> b = %lx:\n", test_array[i].b);
		printf("-> c = %llx:\n", test_array[i].c);
		printf("-> d = %x:\n", test_array[i].d);
	}

	return 0;
}
