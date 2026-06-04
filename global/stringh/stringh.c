#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>

#define INT_TYPE __int128_t 
int main()
{
	char hello[] = "Hello World";
	int len = strlen(hello);
	printf("len of %s is %d\n", hello, len);
	
	//test strcmp
	printf("testing strcmp...\n");
	char hello2[] = "Hello World";
	char hello3[] = "hello world";
	if (!strcmp(hello, hello2)) printf("strcmp when equals ok\n");
	if (strcmp(hello, hello3)) printf("strcmp when not equals ok\n");

        // test strcpy
	printf("testing strcpy...\n");
	char hello4[32];
	strcpy(hello4, hello);
	if (!strcmp(hello, hello4)) printf("strcpy is ok\n");
	
	// test strcat
	printf("testing strcat...\n");
	strcat(hello4, hello);
	printf("strcat result: %s\n", hello4);

	return 0;

}
