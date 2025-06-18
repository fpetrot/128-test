/* gemm.c: this file is part of PolyBench/C */

typedef unsigned int wint_t;

#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include "gemm.h"
#include "doKernel.h"



/* Array initialization. */
static
void init_array(int ni, int nj, int nk,
		DATA_TYPE *alpha,
		DATA_TYPE *beta,
		DATA_TYPE** C,
		DATA_TYPE** A,
		DATA_TYPE** B)
{
  int i, j;

  *alpha = 1.5;
  *beta = 1.2;
  for (i = 0; i < ni; i++)
    for (j = 0; j < nj; j++)
      C[i][j] = (DATA_TYPE) (i*j % ni) / ni;
  for (i = 0; i < ni; i++)
    for (j = 0; j < nk; j++)
      A[i][j] = (DATA_TYPE) (i*(j+1) % nk) / nk;
  for (i = 0; i < nk; i++)
    for (j = 0; j < nj; j++)
      B[i][j] = (DATA_TYPE) (i*(j+2) % nj) / nj;
}


/* DCE code. Must scan the entire live-out data.
   Can be used also to check the correctness of the output. */
static
void print_array(int ni, int nj,
		 DATA_TYPE** C)
{
  int i, j;

  for (i = 0; i < ni; i++){
    for (j = 0; j < nj; j++) {
      printf(PRINTF_MODIFIER, C[i][j]);
    }
    printf("\n");
  }
}


/* Main computational kernel. The whole function will be timed,
   including the call and return. */
static
void kernel_gemm(int ni, int nj, int nk,
		 DATA_TYPE alpha,
		 DATA_TYPE beta,
		 DATA_TYPE** C,
		 DATA_TYPE** A,
		 DATA_TYPE** B)
{
  int i, j, k;

//BLAS PARAMS
//TRANSA = 'N'
//TRANSB = 'N'
// => Form C := alpha*A*B + beta*C,
//A is NIxNK
//B is NKxNJ
//C is NIxNJ
#pragma scop
  for (i = 0; i < ni; i++) {
    for (j = 0; j < nj; j++)
	C[i][j] *= beta;
    for (k = 0; k < nk; k++) {
       for (j = 0; j < nj; j++)
	  C[i][j] += alpha * A[i][k] * B[k][j];
    }
  }
#pragma endscop

}


int main(int argc, char** argv)
{
  /* Retrieve problem size. */
  int ni = NI;
  int nj = NJ;
  int nk = NK;

  /* Variable declaration/allocation. */
  DATA_TYPE alpha;
  DATA_TYPE beta;
  DATA_TYPE** C = (DATA_TYPE**)malloc(ni * sizeof(DATA_TYPE*));
  for (int i = 0; i < ni; i++)
    C[i] = (DATA_TYPE*)malloc(nj * sizeof(DATA_TYPE));
  DATA_TYPE** A = (DATA_TYPE**)malloc(ni * sizeof(DATA_TYPE*));
  for (int i = 0; i < ni; i++)
    A[i] = (DATA_TYPE*)malloc(nk * sizeof(DATA_TYPE));
  DATA_TYPE** B = (DATA_TYPE**)malloc(nk * sizeof(DATA_TYPE*));
  for (int i = 0; i < nk; i++)
    B[i] = (DATA_TYPE*)malloc(nj * sizeof(DATA_TYPE));

  /* Initialize array(s). */
  init_array (ni, nj, nk, &alpha, &beta,
	      C,
	      A,
	      B);

  /* Start timer. */
  
  
  #ifdef ARRAY_CALC
  /* Run kernel. */
  kernel_gemm (ni, nj, nk,
	       alpha, beta,
	       C,
	       A,
	       B);
  #endif

  /* Stop and print timer. */
  

  /* Prevent dead-code elimination. All live-out data must be printed
     by the function call in argument. */
  print_array(ni, nj, C);

  /* Be clean. */
  for (int i = 0; i < ni; i++)
    free(C[i]);
  free(C);
  for (int i = 0; i < ni; i++)
    free(A[i]);
  free(A);
  for (int i = 0; i < nk; i++)
    free(B[i]);
  free(B);

  return 0;
}
