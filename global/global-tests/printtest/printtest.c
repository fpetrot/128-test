#include <stdio.h>
#include <stdlib.h>
#include <stdnew.h>

#define TYPE int



void extern_print()
{
	// 17lettres
	print_uart("kkkkkkkkkkkkkkkkk");
}

void extern_use_k(TYPE **k)
{
	k[0][0] = 42; // Example usage of k
}

void extern_print_with_args(TYPE **k)
{
	// 17lettres + arg
	print_uart("kkkkkkkkkkkkkkkkk\n");
}

void extern_print_with_args_1D(TYPE *k)
{
	// 17lettres + arg
	print_uart("kkkkkkkkkkkkkkkkk");
}

void extern_print_with_args_less(TYPE **k)
{
	// 16lettres + arg
	print_uart("kkkkkkkkkkkkkkkk");
}

void extern_print_with_args_less_1D(TYPE *k)
{
	// 16lettres + arg
	print_uart("kkkkkkkkkkkkkkkk");
}

void extern_print_loop(TYPE **k)
{
	int i = 0;
	for (i = 0; i < 17; i++)
	{
		print_uart("k");
	}
}

void extern_print_loop_1D(TYPE *k)
{
	int i = 0;
	printf("t address in func: %p\n", (void *)k);

	for (i = 0; i < 16; i++)
	{
		//print_uart("k");
		printf("%d ", k[i]); // Example usage of k
	}
}

void extern_long_calc(TYPE **k)
{
	// calcul long
	int i = 0;
	int j = 0;
	for (i = 0; i < 500000000; i++)
	{
		j++;
		j = j * 2 / 2;
	}
}

void extern_long_calc_1D(TYPE *k)
{
	// calcul long
	int i = 0;
	int j = 0;
	for (i = 0; i < 500000000; i++)
	{
		j++;
		j = j * 2 / 2;
	}
}

int main(int argc, char **argv)
{

	int mode = 1;
	int memory_mode = 0;

	TYPE len = 10;

	if (memory_mode == 0)
	{
		TYPE **t = malloc(sizeof(TYPE *) * len);
		for (TYPE i = 0; i < len; i++)
		{
			t[i] = malloc(sizeof(TYPE) * len);
			for (TYPE j = 0; j < len; j++)
			{
				t[i][j] = i + j; // Initialize with some values
			}
		}

		switch (mode)
		{
		case 0:
			extern_print();
			break;
		case 1:
			extern_print_with_args(t);
			break;

		case 2:
			extern_print_with_args_less(t);
			break;
		case 3:
			extern_print_loop(t);
			break;
		case 4:
			extern_long_calc(t);
			break;
		case 5:
			print_uart("kkkk");
			break;
		case 6:
			extern_use_k(t);
			break;
		default:
			break;
		}

		for (int i = 0; i < len; i++)
		{
			for (int j = 0; j < len; j++)
			{
				printf("t[%d][%d]=%d\n", i, j, t[i][j]);
			}
		}

		for (TYPE i = 0; i < len; i++)
		{
			if (t[i] != NULL)
				free(t[i]);
		}
		free(t);
	}
	else if (memory_mode == 1)
	{
		TYPE *t = malloc(sizeof(TYPE) * len);
		if (t == NULL)
		{
			print_uart("Memory allocation failed\n");
			return 1;
		}
		for (TYPE i = 0; i < len; i++)
		{
			t[i] = i;
		}
		printf("t address: %p\n", (void *)t);

		switch (mode)
		{
		case 0:
			extern_print();
			break;
		case 1:
			extern_print_with_args_1D(t);
			break;

		case 2:
			extern_print_with_args_less_1D(t);
			break;
		case 3:
			extern_print_loop_1D(t);
			break;
		case 4:
			extern_long_calc_1D(t);
			break;
		case 5:
			print_uart("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
			break;
		default:
			break;
		}
		printf("\nt after call address: %p\n", (void *)t);

		// for (TYPE i = 0; i < len; i++)
		// {
		// 	print_uart("t[%d]=%d\n", i, t[i]);
		// }

		if (t != NULL){
			print_uart("goto free\n");
			free(t);
		}
	}
	else{
		int *t;
		switch (mode)
		{
		case 0:
			extern_print();
			break;
		case 1:
			extern_print_with_args_1D(t);
			break;

		case 2:
			extern_print_with_args_less_1D(t);
			break;
		case 3:
			extern_print_loop_1D(t);
			break;
		case 4:
			extern_long_calc_1D(t);
			break;
		case 5:
			print_uart("kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk");
			break;
		default:
			break;
		}
	}
	print_uart_double(3.141);
	print_uart(" ");
	print_uart_double(2.718);
	print_uart(" ");
	print_uart_double(1.499);
	print_uart("hello from main after freeing\n");
	return 0;
}
