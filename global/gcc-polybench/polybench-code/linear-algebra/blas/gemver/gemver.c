/* gemver.c: this file is part of PolyBench/C */

typedef unsigned int wint_t;

#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include "gemver.h"
#include "doKernel.h"



/* Array initialization. */
static
void init_array (int n,
		 DATA_TYPE *alpha,
		 DATA_TYPE *beta,
		 DATA_TYPE **A,
		 DATA_TYPE *u1,
		 DATA_TYPE *v1,
		 DATA_TYPE *u2,
		 DATA_TYPE *v2,
		 DATA_TYPE *w,
		 DATA_TYPE *x,
		 DATA_TYPE *y,
		 DATA_TYPE *z)
{
  int i, j;

  *alpha = 1.5;
  *beta = 1.2;

  DATA_TYPE fn = (DATA_TYPE)n;

  for (i = 0; i < n; i++)
    {   
      u1[i] = i;
      u2[i] = ((i+1)/fn)/2.0;
      v1[i] = ((i+1)/fn)/4.0;
      v2[i] = ((i+1)/fn)/6.0;
      y[i] = ((i+1)/fn)/8.0;
      z[i] = ((i+1)/fn)/9.0;
      x[i] = 0.0;
      w[i] = 0.0;
      for (j = 0; j < n; j++)
        A[i][j] = (DATA_TYPE) (i*j % n) / n;
    }   
}


/* DCE code. Must scan the entire live-out data.
   Can be used also to check the correctness of the output. */
static
void print_array(int n,
		 DATA_TYPE *w)
{
  int i;

  for (i = 0; i < n; i++) {
    if (i % 10 == 0) printf("\n");
    printf("%0.2lf", w[i]);
    printf(" ");
  }
  printf("\n");
}


/* Main computational kernel. The whole function will be timed,
   including the call and return. */
static
void kernel_gemver(int n,
		   DATA_TYPE alpha,
		   DATA_TYPE beta,
		   DATA_TYPE **A,
		   DATA_TYPE *u1,
		   DATA_TYPE *v1,
		   DATA_TYPE *u2,
		   DATA_TYPE *v2,
		   DATA_TYPE *w,
		   DATA_TYPE *x,
		   DATA_TYPE *y,
		   DATA_TYPE *z)
{
  int i, j;

#pragma scop

  for (i = 0; i < n; i++)
    for (j = 0; j < n; j++)
      A[i][j] = A[i][j] + u1[i] * v1[j] + u2[i] * v2[j];

  for (i = 0; i < n; i++)
    for (j = 0; j < n; j++)
      x[i] = x[i] + beta * A[j][i] * y[j];

  for (i = 0; i < n; i++)
    x[i] = x[i] + z[i];

  for (i = 0; i < n; i++)
    for (j = 0; j < n; j++)
      w[i] = w[i] +  alpha * A[i][j] * x[j];

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
  DATA_TYPE* u1;
  DATA_TYPE* v1;
  DATA_TYPE* u2;
  DATA_TYPE* v2;
  DATA_TYPE* w;
  DATA_TYPE* x;
  DATA_TYPE* y;
  DATA_TYPE* z;
  A = (DATA_TYPE**)malloc(n * sizeof(DATA_TYPE*));
  for (int i = 0; i < n; i++)
    A[i] = (DATA_TYPE*)malloc(n * sizeof(DATA_TYPE));
  u1 = (DATA_TYPE*)malloc(n * sizeof(DATA_TYPE));
  v1 = (DATA_TYPE*)malloc(n * sizeof(DATA_TYPE));
  u2 = (DATA_TYPE*)malloc(n * sizeof(DATA_TYPE));
  v2 = (DATA_TYPE*)malloc(n * sizeof(DATA_TYPE));
  w = (DATA_TYPE*)malloc(n * sizeof(DATA_TYPE));
  x = (DATA_TYPE*)malloc(n * sizeof(DATA_TYPE));
  y = (DATA_TYPE*)malloc(n * sizeof(DATA_TYPE));
  z = (DATA_TYPE*)malloc(n * sizeof(DATA_TYPE));
  

  init_array (n, &alpha, &beta,
	      A,
	      u1,
	      v1,
	      u2,
	      v2,
	      w,
	      x,
	      y,
	      z);

  /* Start timer. */
  

  #ifdef ARRAY_CALC
  /* Run kernel. */
  kernel_gemver (n, alpha, beta,
		 A,
		 u1,
		 v1,
		 u2,
		 v2,
		 w,
		 x,
		 y,
		 z);
  #endif

  /* Stop and print timer. */
  

  /* Prevent dead-code elimination. All live-out data must be printed
     by the function call in argument. */
  print_array(n, w);

  /* Be clean. */
  for (int i = 0; i < n; i++)
    free(A[i]);
  free(A);
  free(u1);
  free(v1);
  free(u2);
  free(v2);
  free(w);
  free(x);
  free(y);
  free(z);

  return 0;
}
