/* cholesky.c: this file is part of PolyBench/C */

typedef unsigned int wint_t;

#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include "cholesky.h"
#include "doKernel.h"



/* Array initialization. */
static
void init_array(int n,
		DATA_TYPE** A)
{
  int i, j;

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
  int r,s,t;
  DATA_TYPE** B;
  B = (DATA_TYPE**)malloc(n * sizeof(DATA_TYPE*));
  for(int i = 0; i < n; i++){
    B[i] = (DATA_TYPE*)malloc(n * sizeof(DATA_TYPE));
  }
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
		 DATA_TYPE** A)

{
  int i, j;

  for (i = 0; i < n; i++){
    for (j = 0; j <= i; j++) {
      printf("%0.2lf ", A[i][j]);
    }
    printf("\n");
  }
}


/* Main computational kernel. The whole function will be timed,
   including the call and return. */
static
void kernel_cholesky(int n,
		     DATA_TYPE** A)
{
  int i, j, k;


#pragma scop
  for (i = 0; i < n; i++) {
     //j<i
     for (j = 0; j < i; j++) {
        for (k = 0; k < j; k++) {
           A[i][j] -= A[i][k] * A[j][k];
        }
        A[i][j] /= A[j][j];
     }
     // i==j case
     for (k = 0; k < i; k++) {
        A[i][i] -= A[i][k] * A[i][k];
     }
     A[i][i] = SQRT_FUN(A[i][i]);
  }
#pragma endscop

}


int main(int argc, char** argv)
{
  /* Retrieve problem size. */
  int n = N;


  DATA_TYPE** A;
  A = (DATA_TYPE**)malloc(n * sizeof(DATA_TYPE*));
  for (int i = 0; i < n; i++)
    A[i] = (DATA_TYPE*)malloc(n * sizeof(DATA_TYPE));
  /* Variable declaration/allocation. */
  

  /* Initialize array(s). */
  init_array (n, A);

  /* Start timer. */
  
  #ifdef ARRAY_CALC
  /* Run kernel. */
  kernel_cholesky (n, A);
  #endif

  /* Stop and print timer. */
  
  /* Prevent dead-code elimination. All live-out data must be printed
     by the function call in argument. */
  print_array(n, A);

  /* Be clean. */
  for (int i = 0; i < n; i++)
    free(A[i]);
  free(A);

  return 0;
}
