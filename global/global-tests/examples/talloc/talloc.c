#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char **argv)
{
	const size_t nelems = 8;
	const size_t elemsize = 128;
	char **alloc = malloc(sizeof(char*)*nelems);

	for (size_t i = 0; i < nelems; i++) {
        alloc[i] = malloc(elemsize);
		if (alloc[i] != NULL) {
			memset(alloc[i], 0, elemsize);
            //memeset sans effet
            //alloc[i]=0;
		}
		printf("malloc[%d]=0x%x\n", i, alloc[i]);
	}

	for (size_t i = 0; i < nelems; i++) {
		free(alloc[i]);
	}
    free(alloc);
}