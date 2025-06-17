/* trisolv.c: this file is part of PolyBench/C */

typedef unsigned int wint_t;

#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include "trisolv.h"


/* Array initialization. */
static
void init_array(int n,
		DATA_TYPE** L,
		DATA_TYPE* x,
		DATA_TYPE* b)
{
  int i, j;

  for (i = 0; i < n; i++)
    {
      x[i] = - 999;
      b[i] =  i ;
      for (j = 0; j <= i; j++)
	L[i][j] = (DATA_TYPE) (i+n-j+1)*2/n;
    }
}


/* DCE code. Must scan the entire live-out data.
   Can be used also to check the correctness of the output. */
static
void print_array(int n,
		 DATA_TYPE* x)

{
  int i;

  for (i = 0; i < n; i++) {
    printf("%0.2lf ", x[i]);
  }
  printf("\n");
}


/* Main computational kernel. The whole function will be timed,
   including the call and return. */
static
void kernel_trisolv(int n,
		    DATA_TYPE** L,
		    DATA_TYPE* x,
		    DATA_TYPE* b)
{
  int i, j;

#pragma scop
  for (i = 0; i < n; i++)
    {
      x[i] = b[i];
      for (j = 0; j <i; j++)
        x[i] -= L[i][j] * x[j];
      x[i] = x[i] / L[i][i];
    }
#pragma endscop

}


int main(int argc, char** argv)
{
  /* Retrieve problem size. */
  int n = N;

  /* Variable declaration/allocation. */
  DATA_TYPE** L = (DATA_TYPE**)malloc(n * sizeof(DATA_TYPE*));
  for (int i = 0; i < n; i++)

    L[i] = (DATA_TYPE*)malloc(n * sizeof(DATA_TYPE));
  DATA_TYPE* x = (DATA_TYPE*)malloc(n * sizeof(DATA_TYPE));
  DATA_TYPE* b = (DATA_TYPE*)malloc(n * sizeof(DATA_TYPE));


  /* Initialize array(s). */
  init_array (n, L, x, b);

  /* Start timer. */
  
#ifdef ARRAY_CALC
  /* Run kernel. */
  kernel_trisolv (n, L, x, b);
#endif
  /* Stop and print timer. */
  
  /* Prevent dead-code elimination. All live-out data must be printed
     by the function call in argument. */
  print_array(n, x);

  /* Be clean. */
  for (int i = 0; i < n; i++)
    free(L[i]);
  free(L);
  free(x);
  free(b);

  return 0;
}
