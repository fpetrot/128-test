#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include "malloc128.h"

#define INT_TYPE __int128_t 
// test 128 bits memory functions
void print_array(INT_TYPE* tab, int len){
	for(int i=0; i<len; i++){
		printf("tab 0x%016lx%016lx\n", int128_gethi(tab[i]), int128_getlo(tab[i]));
	}
}

int main()
{
	int len = 5;
	int size = sizeof(INT_TYPE);
	INT_TYPE* tab;
	// test malloc
	printf("testing malloc...\n");
	tab = malloc(size*len);
	if (!tab){
		printf("malloc failed\n");
		return 1;
	}

	INT_TYPE int_max = size <=8 ? INT32_MAX : INT64_MAX;
	for (int i=0; i<len; i++){
		tab[i] = int_max + 20 * i;
	}

        print_array(tab, len);

	// test calloc
	printf("testing calloc...\n");
	INT_TYPE* tab2 = calloc(len, size);
	print_array(tab2, len);

	// test memcpy
	printf("testing memcpy...\n");
	memcpy(tab2, tab, size*len);
	print_array(tab2, len);

	//test memcmp
	printf("testing memcmp...\n");
	if (!memcmp(tab, tab2, size*len)) printf("memcmp ok\n");

	// test memset
	printf("testing memset...\n");
	memset(tab2, 0xAB, size*len);
	printf("tab 0x%016lx%016lx\n", int128_gethi(tab2[0]), int128_getlo(tab2[0]));

	// test_free
	free(tab);
	free(tab2);

	// test malloc failure
	INT_TYPE* tab_fail = malloc(int_max);
	if (!tab_fail){
		printf("ok malloc fails for big value\n");
		return 0;
	}
	return 1;

}
