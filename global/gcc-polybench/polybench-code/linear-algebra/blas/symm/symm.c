/* symm.c: this file is part of PolyBench/C */

typedef unsigned int wint_t;

#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include "symm.h"
#include "global_var.h"



/* Array initialization. */
static
void init_array(int m, int n,
		DATA_TYPE *alpha,
		DATA_TYPE *beta,
		DATA_TYPE** C,
		DATA_TYPE** A,
		DATA_TYPE** B)
{
  int i, j;

  *alpha = 1.5;
  *beta = 1.2;
  for (i = 0; i < m; i++)
    for (j = 0; j < n; j++) {
      C[i][j] = (DATA_TYPE) ((i+j) % 100) / m;
      B[i][j] = (DATA_TYPE) ((n+i-j) % 100) / m;
    }
  for (i = 0; i < m; i++) {
    for (j = 0; j <=i; j++)
      A[i][j] = (DATA_TYPE) ((i+j) % 100) / m;
    for (j = i+1; j < m; j++)
      A[i][j] = -999; //regions of arrays that should not be used
  }
}


/* DCE code. Must scan the entire live-out data.
   Can be used also to check the correctness of the output. */
static
void print_array(int m, int n,
		 DATA_TYPE **C)
{
  int i, j;


  for (i = 0; i < m; i++){
    for (j = 0; j < n; j++) {
	    printf(PRINTF_MODIFIER, C[i][j]);
         }
    printf("\n");
  }
}


/* Main computational kernel. The whole function will be timed,
   including the call and return. */
static
void kernel_symm(int m, int n,
		 DATA_TYPE alpha,
		 DATA_TYPE beta,
		 DATA_TYPE **C,
		 DATA_TYPE **A,
		 DATA_TYPE **B)
{
  int i, j, k;
  DATA_TYPE temp2;

//BLAS PARAMS
//SIDE = 'L'
//UPLO = 'L'
// =>  Form  C := alpha*A*B + beta*C
// A is MxM
// B is MxN
// C is MxN
//note that due to Fortran array layout, the code below more closely resembles upper triangular case in BLAS
#pragma scop
   for (i = 0; i < m; i++)
      for (j = 0; j < n; j++ )
      {
        temp2 = 0;
        for (k = 0; k < i; k++) {
           C[k][j] += alpha*B[i][j] * A[i][k];
           temp2 += B[k][j] * A[i][k];
        }
        C[i][j] = beta * C[i][j] + alpha*B[i][j] * A[i][i] + alpha * temp2;
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
  DATA_TYPE beta;
  DATA_TYPE **C;
  DATA_TYPE **A;
  DATA_TYPE **B;

  C = malloc(m * sizeof(DATA_TYPE*));
  for (int i = 0; i < m; i++)
    C[i] = malloc(n * sizeof(DATA_TYPE));
  A = malloc(m * sizeof(DATA_TYPE*));
  for (int i = 0; i < m; i++)
    A[i] = malloc(m * sizeof(DATA_TYPE));
  B = malloc(m * sizeof(DATA_TYPE*));
  for (int i = 0; i < m; i++)
    B[i] = malloc(n * sizeof(DATA_TYPE));

  /* Initialize array(s). */
  init_array (m, n, &alpha, &beta,
	      C,
	      A,
	      B);

  /* Start timer. */


  #ifdef ARRAY_CALC
  /* Run kernel. */
  kernel_symm (m, n,
	       alpha, beta,
	       C,
	       A,
	       B);

  /* Stop and print timer. */


  #endif

  /* Prevent dead-code elimination. All live-out data must be printed
     by the function call in argument. */
  print_array(m, n, C);

  /* Be clean. */
  for (int i = 0; i < m; i++) {
    free(C[i]);
    free(A[i]);
  }
  free(C);
  free(A);
  free(B);

  return 0;
}
