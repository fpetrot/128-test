#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdnew.h>

int main(int argc, char **argv)
{
	const size_t nelems = 8;
	const size_t elemsize = 128;
	char *alloc[nelems];

	for (size_t i = 0; i < nelems; i++) {
		if (alloc[i] = malloc(elemsize)) {
			memset(alloc[i], 0, elemsize);
		}
		print_uart(alloc[i]);
	}

	for (size_t i = 0; i < nelems; i++) {
		free(alloc[i]);
	}
}
