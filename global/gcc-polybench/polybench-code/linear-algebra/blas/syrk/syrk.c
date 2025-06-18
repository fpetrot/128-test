/* syrk.c: this file is part of PolyBench/C */

typedef unsigned int wint_t;

#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include "syrk.h"
#include "doKernel.h"



/* Array initialization. */
static
void init_array(int n, int m,
		DATA_TYPE *alpha,
		DATA_TYPE *beta,
		DATA_TYPE** C,
		DATA_TYPE** A)
{
  int i, j;

  *alpha = 1.5;
  *beta = 1.2;
  for (i = 0; i < n; i++)
    for (j = 0; j < m; j++)
      A[i][j] = (DATA_TYPE) (i*j%n) / n;
  for (i = 0; i < n; i++)
    for (j = 0; j < n; j++)
      C[i][j] = (DATA_TYPE) (i*j%m) / m;
}


/* DCE code. Must scan the entire live-out data.
   Can be used also to check the correctness of the output. */
static
void print_array(int n,
		 DATA_TYPE **C)
{
  int i, j;

 
  for (i = 0; i < n; i++){
    for (j = 0; j < n; j++) {
	    printf(PRINTF_MODIFIER, C[i][j]);
    }
    printf("\n");
  }
}


/* Main computational kernel. The whole function will be timed,
   including the call and return. */
static
void kernel_syrk(int n, int m,
		 DATA_TYPE alpha,
		 DATA_TYPE beta,
		 DATA_TYPE **C,
		 DATA_TYPE **A)
{
  int i, j, k;

//BLAS PARAMS
//TRANS = 'N' 
//UPLO  = 'L'
// =>  Form  C := alpha*A*A**T + beta*C.
//A is NxM
//C is NxN
#pragma scop
  for (i = 0; i < n; i++) {
    for (j = 0; j <= i; j++)
      C[i][j] *= beta;
    for (k = 0; k < m; k++) {
      for (j = 0; j <= i; j++)
        C[i][j] += alpha * A[i][k] * A[j][k];
    }
  }
#pragma endscop

}


int main(int argc, char** argv)
{
  /* Retrieve problem size. */
  int n = N;
  int m = M;

  /* Variable declaration/allocation. */
  DATA_TYPE alpha;
  DATA_TYPE beta;
  DATA_TYPE **C = malloc(n * sizeof(DATA_TYPE*));
  for (int i = 0; i < n; i++)
    C[i] = malloc(n * sizeof(DATA_TYPE));
  DATA_TYPE **A = malloc(n * sizeof(DATA_TYPE*));
  for (int i = 0; i < n; i++)
    A[i] = malloc(m * sizeof(DATA_TYPE));

  /* Initialize array(s). */
  init_array (n, m, &alpha, &beta, C, A);

  /* Start timer. */
  

  #ifdef ARRAY_CALC
  /* Run kernel. */
  kernel_syrk (n, m, alpha, beta, C, A);
  #endif
  /* Stop and print timer. */
  
  

  /* Prevent dead-code elimination. All live-out data must be printed
     by the function call in argument. */
  print_array(n, C);

  /* Be clean. */
  for (int i = 0; i < n; i++) {
    free(C[i]);
    free(A[i]);
  }
  free(C);
  free(A);

  return 0;
}
