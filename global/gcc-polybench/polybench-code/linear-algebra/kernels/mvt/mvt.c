/* mvt.c: this file is part of PolyBench/C */

typedef unsigned int wint_t;

#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include "mvt.h"
#include "doKernel.h"



/* Array initialization. */
static
void init_array(int n,
		DATA_TYPE *x1,
		DATA_TYPE *x2,
		DATA_TYPE *y_1,
		DATA_TYPE *y_2,
		DATA_TYPE **A)
{
  int i, j;

  for (i = 0; i < n; i++)
    {
      x1[i] = (DATA_TYPE) (i % n) / n;
      x2[i] = (DATA_TYPE) ((i + 1) % n) / n;
      y_1[i] = (DATA_TYPE) ((i + 3) % n) / n;
      y_2[i] = (DATA_TYPE) ((i + 4) % n) / n;
      for (j = 0; j < n; j++)
	A[i][j] = (DATA_TYPE) (i*j % n) / n;
    }
}


/* DCE code. Must scan the entire live-out data.
   Can be used also to check the correctness of the output. */
static
void print_array(int n,
		 DATA_TYPE *x1,
		 DATA_TYPE *x2)

{
  int i;

  printf("x1");
  for (i = 0; i < n; i++) {
    if (i % 10 == 0) printf("\n");
    printf("%0.2lf ", x1[i]);
  }
  printf("\n");

  printf("x2");
  for (i = 0; i < n; i++) {
    if (i % 10 == 0) printf("\n");
    printf("%0.2lf ", x2[i]);
  }
  printf("\n");
}


/* Main computational kernel. The whole function will be timed,
   including the call and return. */
static
void kernel_mvt(int n,
		DATA_TYPE *x1,
		DATA_TYPE *x2,
		DATA_TYPE *y_1,
		DATA_TYPE *y_2,
		DATA_TYPE **A)
{
  int i, j;

#pragma scop
  for (i = 0; i < n; i++)
    for (j = 0; j < n; j++)
      x1[i] = x1[i] + A[i][j] * y_1[j];
  for (i = 0; i < n; i++)
    for (j = 0; j < n; j++)
      x2[i] = x2[i] + A[j][i] * y_2[j];
#pragma endscop

}


int main(int argc, char** argv)
{
  /* Retrieve problem size. */
  int n = N;

  DATA_TYPE** A;
  DATA_TYPE* x1;
  DATA_TYPE* x2;
  DATA_TYPE* y_1;
  DATA_TYPE* y_2;


  A = (DATA_TYPE**)malloc(n * sizeof(DATA_TYPE*));
  for (int i = 0; i < n; i++)
    A[i] = (DATA_TYPE*)malloc(n * sizeof(DATA_TYPE));
  x1 = (DATA_TYPE*)malloc(n * sizeof(DATA_TYPE));
  x2 = (DATA_TYPE*)malloc(n * sizeof(DATA_TYPE)); 
  y_1 = (DATA_TYPE*)malloc(n * sizeof(DATA_TYPE));
  y_2 = (DATA_TYPE*)malloc(n * sizeof(DATA_TYPE));
  /* Variable declaration/allocation. */
  

  init_array (n,
	      x1,
	      x2,
	      y_1,
	      y_2,
	      A);

  /* Start timer. */
  #ifdef ARRAY_CALC
  /* Run kernel. */
  kernel_mvt (n,
	      x1,
	      x2,
	      y_1,
	      y_2,
	      A);
  #endif
  /* Stop and print timer. */
  

  /* Prevent dead-code elimination. All live-out data must be printed
     by the function call in argument. */
  print_array(n, x1, x2);

  /* Be clean. */
  for (int i = 0; i < n; i++)
    free(A[i]);
  free(A);
  free(x1);
  free(x2);
  free(y_1);
  free(y_2);

  return 0;
}
