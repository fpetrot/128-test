/* atax.c: this file is part of PolyBench/C */

typedef unsigned int wint_t;

#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include "atax.h"


/* Array initialization. */
static
void init_array (int m, int n,
		 DATA_TYPE** A,
		 DATA_TYPE* x)
{
  int i, j;
  DATA_TYPE fn;
  fn = (DATA_TYPE)n;

  for (i = 0; i < n; i++)
      x[i] = 1 + (i / fn);
  for (i = 0; i < m; i++)
    for (j = 0; j < n; j++)
      A[i][j] = (DATA_TYPE) ((i+j) % n) / (5*m);
}


/* DCE code. Must scan the entire live-out data.
   Can be used also to check the correctness of the output. */
static
void print_array(int n,
		 DATA_TYPE* y)

{
  int i;
  for (i = 0; i < n; i++) {
    printf("%0.2lf ", y[i]);
  }
  printf("\n");
}


/* Main computational kernel. The whole function will be timed,
   including the call and return. */
static
void kernel_atax(int m, int n,
		 DATA_TYPE** A,
		 DATA_TYPE* x,
		 DATA_TYPE* y,
		 DATA_TYPE* tmp)
{
  int i, j;

#pragma scop
  for (i = 0; i < n; i++)
    y[i] = 0;
  for (i = 0; i < m; i++)
    {
      tmp[i] = SCALAR_VAL(0.0);
      for (j = 0; j < n; j++)
	tmp[i] = tmp[i] + A[i][j] * x[j];
      for (j = 0; j < n; j++)
	y[j] = y[j] + A[i][j] * tmp[i];
    }
#pragma endscop

}


int main(int argc, char** argv)
{
  /* Retrieve problem size. */
  int m = M;
  int n = N;

  DATA_TYPE** A;
  DATA_TYPE* x;
  DATA_TYPE* y;
  DATA_TYPE* tmp;
  A = (DATA_TYPE**)malloc(m * sizeof(DATA_TYPE*));
  for (int i = 0; i < m; i++)
    A[i] = (DATA_TYPE*)malloc(n * sizeof(DATA_TYPE));
  x = (DATA_TYPE*)malloc(n * sizeof(DATA_TYPE));
  y = (DATA_TYPE*)malloc(n * sizeof(DATA_TYPE));
  tmp = (DATA_TYPE*)malloc(m * sizeof(DATA_TYPE));

  /* Variable declaration/allocation. */

  init_array (m, n, A, x);

  /* Start timer. */
  
#ifdef ARRAY_CALC
  /* Run kernel. */
  kernel_atax (m, n,
	       A,
	       x,
	       y,
	       tmp);
#endif

  /* Stop and print timer. */
  
  /* Prevent dead-code elimination. All live-out data must be printed
     by the function call in argument. */
  print_array(n, y);

  /* Be clean. */
  for (int i = 0; i < m; i++)
    free(A[i]);
  free(A);
  free(x);
  free(y);
  free(tmp);

  return 0;
}
