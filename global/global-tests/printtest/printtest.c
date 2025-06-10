#include <stdio.h>
#include <stdlib.h>


#define TYPE int



void extern_print(){
	//17lettres
	printf("kkkkkkkkkkkkkkkkk");
}

void extern_print_with_args(TYPE** k){
	//17lettres + arg
	printf("kkkkkkkkkkkkkkkkk");
}

void extern_print_with_args_less(TYPE** k){
	//16lettres + arg
	printf("kkkkkkkkkkkkkkkk");
}

void extern_print_loop(TYPE** k){
	int i = 0;
	for (i = 0; i < 100; i++) {
		printf("k");
	}
}

void extern_long_calc(TYPE** k){
	//calcul long
	int i = 0;
	int j = 0;
	for (i = 0; i < 500000000; i++) {
		j++;
		j = j * 2 / 2;
	}
}


int main (int argc, char **argv){

	
	int mode = 1;


	TYPE len = 5;
	TYPE** k = malloc(sizeof(TYPE*)*len);
	for (TYPE i = 0; i < len; i++)
	{
		k[i] = malloc(sizeof(TYPE));
		*k[i] = i;
	}

	switch (mode) {
		case 0:
			extern_print();
			break;
		case 1:
			extern_print_with_args(k);
			break;

		case 2:
			extern_print_with_args_less(k);
			break;
		case 3:
			extern_print_loop(k);
			break;
		default:
			extern_long_calc(k);
			break;
	}	


	for(int i = 0; i < len; i++)
	{
		printf("k[%d]=%d\n", i, *k[i]);
	}

	for (size_t i = 0; i < len; i++)
	{
		if (k[i] != NULL)
			free(k[i]);
	}
	free(k);

	printf("hello from main after freeing\n");
	
}
