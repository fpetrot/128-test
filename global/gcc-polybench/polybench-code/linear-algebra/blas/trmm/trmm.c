/* trmm.c: this file is part of PolyBench/C */

typedef unsigned int wint_t;

#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include "trmm.h"
#include "doKernel.h"



/* Array initialization. */
static
void init_array(int m, int n,
		DATA_TYPE *alpha,
		DATA_TYPE** A,
		DATA_TYPE** B)
{
  int i, j;

  *alpha = 1.5;
  for (i = 0; i < m; i++) {
    for (j = 0; j < i; j++) {
      A[i][j] = (DATA_TYPE)((i+j) % m)/m;
    }
    A[i][i] = 1.0;
    for (j = 0; j < n; j++) {
      B[i][j] = (DATA_TYPE)((n+(i-j)) % n)/n;
    }
 }

}


/* DCE code. Must scan the entire live-out data.
   Can be used also to check the correctness of the output. */
static
void print_array(int m, int n,
		 DATA_TYPE **B)
{
  int i, j;

  for (i = 0; i < m; i++){
    for (j = 0; j < n; j++) {
      printf("%0.2lf", B[i][j]);
      printf(" ");
    }
    printf("\n");
  }
}


/* Main computational kernel. The whole function will be timed,
   including the call and return. */
static
void kernel_trmm(int m, int n,
		 DATA_TYPE alpha,
		 DATA_TYPE **A,
		 DATA_TYPE **B)
{
  int i, j, k;

//BLAS parameters
//SIDE   = 'L'
//UPLO   = 'L'
//TRANSA = 'T'
//DIAG   = 'U'
// => Form  B := alpha*A**T*B.
// A is MxM
// B is MxN
#pragma scop
  for (i = 0; i < m; i++)
     for (j = 0; j < n; j++) {
        for (k = i+1; k < m; k++) 
           B[i][j] += A[k][i] * B[k][j];
        B[i][j] = alpha * B[i][j];
     }
#pragma endscop

}


int main(int argc, char** argv)
{
  /* Retrieve problem size. */
  int m = M;
  int n = N;

  /* Variable declaration/allocation. */
  DATA_TYPE alpha;
  DATA_TYPE **A = malloc(m * sizeof(DATA_TYPE*));
  for (int i = 0; i < m; i++)
    A[i] = malloc(m * sizeof(DATA_TYPE));
  DATA_TYPE **B = malloc(m * sizeof(DATA_TYPE*));
  for (int i = 0; i < m; i++)
    B[i] = malloc(n * sizeof(DATA_TYPE));

  /* Initialize array(s). */
  init_array (m, n, &alpha, A, B);

  /* Start timer. */
  
  #ifdef ARRAY_CALC
  /* Run kernel. */
  kernel_trmm (m, n, alpha, A, B);
#endif
  /* Stop and print timer. */
  
  

  /* Prevent dead-code elimination. All live-out data must be printed
     by the function call in argument. */
  print_array(m, n, B);

  /* Be clean. */
  for (int i = 0; i < m; i++) {
    free(A[i]);
    free(B[i]);
  }
  free(A);
  free(B);

  return 0;
}
