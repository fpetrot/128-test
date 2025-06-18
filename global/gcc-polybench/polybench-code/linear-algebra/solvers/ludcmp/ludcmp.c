/* ludcmp.c: this file is part of PolyBench/C */

typedef unsigned int wint_t;

#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include "ludcmp.h"
#include "doKernel.h"



/* Array initialization. */
static
void init_array (int n,
		 DATA_TYPE** A,
		 DATA_TYPE* b,
		 DATA_TYPE* x,
		 DATA_TYPE* y)
{
  int i, j;
  DATA_TYPE fn = (DATA_TYPE)n;

  for (i = 0; i < n; i++)
    {
      x[i] = 0;
      y[i] = 0;
      b[i] = (i+1)/fn/2.0 + 4;
    }

  for (i = 0; i < n; i++)
    {
      for (j = 0; j <= i; j++)
	A[i][j] = (DATA_TYPE)(-j % n) / n + 1;
      for (j = i+1; j < n; j++) {
	A[i][j] = 0;
      }
      A[i][i] = 1;
    }

  /* Make the matrix positive semi-definite. */
  /* not necessary for LU, but using same code as cholesky */
  int r,s,t;
  DATA_TYPE** B;
  B = malloc(n * sizeof(DATA_TYPE*));
  for (int i = 0; i < n; i++)
    B[i] = malloc(n * sizeof(DATA_TYPE));
  
  for (r = 0; r < n; ++r)
    for (s = 0; s < n; ++s)
      B[r][s] = 0;
  for (t = 0; t < n; ++t)
    for (r = 0; r < n; ++r)
      for (s = 0; s < n; ++s)
	B[r][s] += A[r][t] * A[s][t];
    for (r = 0; r < n; ++r)
      for (s = 0; s < n; ++s)
	A[r][s] = B[r][s];
  for (int i = 0; i < n; i++)
    free(B[i]);
  free(B);

}


/* DCE code. Must scan the entire live-out data.
   Can be used also to check the correctness of the output. */
static
void print_array(int n,
		 DATA_TYPE* x)

{
  int i;

  for (i = 0; i < n; i++) {
    if (i % 10 == 0) printf("\n");
    printf(PRINTF_MODIFIER, x[i]);
  }
  printf("\n");
}


/* Main computational kernel. The whole function will be timed,
   including the call and return. */
static
void kernel_ludcmp(int n,
		   DATA_TYPE** A,
		   DATA_TYPE* b,
		   DATA_TYPE* x,
		   DATA_TYPE* y)
{
  int i, j, k;

  DATA_TYPE w;

#pragma scop
  for (i = 0; i < n; i++) {
    for (j = 0; j <i; j++) {
       w = A[i][j];
       for (k = 0; k < j; k++) {
          w -= A[i][k] * A[k][j];
       }
        A[i][j] = w / A[j][j];
    }
   for (j = i; j < n; j++) {
       w = A[i][j];
       for (k = 0; k < i; k++) {
          w -= A[i][k] * A[k][j];
       }
       A[i][j] = w;
    }
  }

  for (i = 0; i < n; i++) {
     w = b[i];
     for (j = 0; j < i; j++)
        w -= A[i][j] * y[j];
     y[i] = w;
  }

   for (i = n-1; i >=0; i--) {
     w = y[i];
     for (j = i+1; j < n; j++)
        w -= A[i][j] * x[j];
     x[i] = w / A[i][i];
  }
#pragma endscop

}


int main(int argc, char** argv)
{
  /* Retrieve problem size. */
  int n = N;

  DATA_TYPE** A;
  DATA_TYPE* b;
  DATA_TYPE* x;
  DATA_TYPE* y;
  A = (DATA_TYPE**)malloc(n * sizeof(DATA_TYPE*));
  for (int i = 0; i < n; i++)
    A[i] = (DATA_TYPE*)malloc(n * sizeof(DATA_TYPE));
  b = (DATA_TYPE*)malloc(n * sizeof(DATA_TYPE));
  x = (DATA_TYPE*)malloc(n * sizeof(DATA_TYPE));
  y = (DATA_TYPE*)malloc(n * sizeof(DATA_TYPE));

  /* Variable declaration/allocation. */
  

  /* Initialize array(s). */
  init_array (n,
	      A,
	      b,
	      x,
	      y);

  /* Start timer. */
  

  #ifdef ARRAY_CALC
  /* Run kernel. */
  kernel_ludcmp (n,
		 A,
		 b,
		 x,
		 y);
  #endif

  /* Stop and print timer. */
  

  /* Prevent dead-code elimination. All live-out data must be printed
     by the function call in argument. */
  print_array(n, x);

  /* Be clean. */
  for (int i = 0; i < n; i++)
    free(A[i]);
  free(A);
  free(b);
  free(x);
  free(y);

  return 0;
}
