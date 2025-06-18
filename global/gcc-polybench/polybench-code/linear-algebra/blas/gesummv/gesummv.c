/* gesummv.c: this file is part of PolyBench/C */

typedef unsigned int wint_t;

#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include "gesummv.h"
#include "doKernel.h"



/* Array initialization. */
static
void init_array(int n,
		DATA_TYPE *alpha,
		DATA_TYPE *beta,
		DATA_TYPE** A,
		DATA_TYPE** B,
		DATA_TYPE* x)
{
  int i, j;

  *alpha = 1.5;
  *beta = 1.2;
  for (i = 0; i < n; i++)
    {
      x[i] = (DATA_TYPE)( i % n) / n;
      for (j = 0; j < n; j++) {
	A[i][j] = (DATA_TYPE) (i*j % n) / n;
	B[i][j] = (DATA_TYPE) (i*j % n) / n;
      }
    }
}


/* DCE code. Must scan the entire live-out data.
   Can be used also to check the correctness of the output. */
static
void print_array(int n,
		 DATA_TYPE* y)

{
  int i;

  for (i = 0; i < n; i++) {
    if (i % 10 == 0) printf("\n");
    printf(PRINTF_MODIFIER, y[i]);
    }
  printf("\n");
}


/* Main computational kernel. The whole function will be timed,
   including the call and return. */
static
void kernel_gesummv(int n,
		    DATA_TYPE alpha,
		    DATA_TYPE beta,
		    DATA_TYPE** A,
		    DATA_TYPE** B,
		    DATA_TYPE* tmp,
		    DATA_TYPE* x,
		    DATA_TYPE* y)
{
  int i, j;

#pragma scop
  for (i = 0; i < n; i++)
    {
      tmp[i] = SCALAR_VAL(0.0);
      y[i] = SCALAR_VAL(0.0);
      for (j = 0; j < n; j++)
	{
	  tmp[i] = A[i][j] * x[j] + tmp[i];
	  y[i] = B[i][j] * x[j] + y[i];
	}
      y[i] = alpha * tmp[i] + beta * y[i];
    }
#pragma endscop

}


int main(int argc, char** argv)
{
  /* Retrieve problem size. */
  int n = N;

  /* Variable declaration/allocation. */
  DATA_TYPE alpha;
  DATA_TYPE beta;
  DATA_TYPE** A;
  DATA_TYPE** B;
  DATA_TYPE* tmp;
  DATA_TYPE* x;
  DATA_TYPE* y;

  A = malloc(n * sizeof(DATA_TYPE*));
  for (int i = 0; i < n; i++)
    A[i] = malloc(n * sizeof(DATA_TYPE));
  B = malloc(n * sizeof(DATA_TYPE*));
  for (int i = 0; i < n; i++)
    B[i] = malloc(n * sizeof(DATA_TYPE));
  tmp = malloc(n * sizeof(DATA_TYPE));
  x = malloc(n * sizeof(DATA_TYPE));
  y = malloc(n * sizeof(DATA_TYPE));

  /* Initialize array(s). */
  init_array (n, &alpha, &beta,
	      A,
	      B,
	      x);

  /* Start timer. */
  

  #ifdef ARRAY_CALC
  /* Run kernel. */
  kernel_gesummv (n, alpha, beta,
		  A,
		  B,
		  tmp,
		  x,
		  y);
  #endif

  /* Stop and print timer. */

  /* Prevent dead-code elimination. All live-out data must be printed
     by the function call in argument. */
  print_array(n, y);

  /* Be clean. */
  for (int i = 0; i < n; i++) {
    free(A[i]);
    free(B[i]);
  }
  free(A);
  free(B);
  free(tmp);
  free(x);
  free(y);

  return 0;
}
