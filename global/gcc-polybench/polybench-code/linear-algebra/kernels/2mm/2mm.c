/* 2mm.c: this file is part of PolyBench/C */

typedef unsigned int wint_t;

#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include "2mm.h"
#include "doKernel.h"



/* Array initialization. */
static
void init_array(int ni, int nj, int nk, int nl,
		DATA_TYPE *alpha,
		DATA_TYPE *beta,
		DATA_TYPE** A,
		DATA_TYPE** B,
		DATA_TYPE** C,
		DATA_TYPE** D)
{
  int i, j;

  *alpha = 1.5;
  *beta = 1.2;
  for (i = 0; i < ni; i++)
    for (j = 0; j < nk; j++)
      A[i][j] = (DATA_TYPE) (i*j % ni) / ni;
  for (i = 0; i < nk; i++)
    for (j = 0; j < nj; j++)
      B[i][j] = (DATA_TYPE) (i*(j+1) % nj) / nj;
  for (i = 0; i < nj; i++)
    for (j = 0; j < nl; j++)
      C[i][j] = (DATA_TYPE) (i*(j+3) % nl) / nl;
  for (i = 0; i < ni; i++)
    for (j = 0; j < nl; j++)
      D[i][j] = (DATA_TYPE) (i*(j+2) % nk) / nk;
}


/* DCE code. Must scan the entire live-out data.
   Can be used also to check the correctness of the output. */
static
void print_array(int ni, int nl,
		 DATA_TYPE** M)
{
  int i, j;
  for (i = 0; i < ni; i++)
  {
    for (j = 0; j < nl; j++)
    {
      printf("%0.2lf ", M[i][j]);
    }
    printf("\n");
  }
}


/* Main computational kernel. The whole function will be timed,
   including the call and return. */
static
void kernel_2mm(int ni, int nj, int nk, int nl,
		DATA_TYPE alpha,
		DATA_TYPE beta,
		DATA_TYPE** tmp,
		DATA_TYPE** A,
		DATA_TYPE** B,
		DATA_TYPE** C,
		DATA_TYPE** D)
{
  int i, j, k;

#pragma scop
  /* D := alpha*A*B*C + beta*D */
  for (i = 0; i < ni; i++)
    for (j = 0; j < nj; j++)
      {
	tmp[i][j] = SCALAR_VAL(0.0);
	for (k = 0; k < nk; ++k)
	  tmp[i][j] += alpha * A[i][k] * B[k][j];
      }
  for (i = 0; i < ni; i++)
    for (j = 0; j < nl; j++)
      {
	D[i][j] *= beta;
	for (k = 0; k < nj; ++k)
	  D[i][j] += tmp[i][k] * C[k][j];
      }
#pragma endscop

}


int main(int argc, char** argv)
{
  /* Retrieve problem size. */
  int ni = NI;
  int nj = NJ;
  int nk = NK;
  int nl = NL;

  /* Variable declaration/allocation. */
  DATA_TYPE alpha;
  DATA_TYPE beta;

  DATA_TYPE** tmp;
  DATA_TYPE** A;
  DATA_TYPE** B;
  DATA_TYPE** C;
  DATA_TYPE** D;

  tmp = malloc(ni * sizeof(DATA_TYPE*));
  for (int i = 0; i < ni; i++)
    tmp[i] = malloc(nj * sizeof(DATA_TYPE));
  A = malloc(ni * sizeof(DATA_TYPE*));
  for (int i = 0; i < ni; i++)
    A[i] = malloc(nk * sizeof(DATA_TYPE));
  B = malloc(nk * sizeof(DATA_TYPE*));
  for (int i = 0; i < nk; i++)
    B[i] = malloc(nj * sizeof(DATA_TYPE));
  C = malloc(nj * sizeof(DATA_TYPE*));
  for (int i = 0; i < nj; i++)
    C[i] = malloc(nl * sizeof(DATA_TYPE));
D = malloc(ni * sizeof(DATA_TYPE*));
  for (int i = 0; i < ni; i++)
    D[i] = malloc(nl * sizeof(DATA_TYPE));
  
  /* Initialize array(s). */
  init_array (ni, nj, nk, nl, &alpha, &beta,
	      A,
	      B,
	      C,
	      D);

  /* Start timer. */
  
    #ifdef ARRAY_CALC
  /* Run kernel. */
  kernel_2mm (ni, nj, nk, nl,
	      alpha, beta,
	      tmp,
	      A,
	      B,
	      C,
	      D);
#endif
  /* Stop and print timer. */
  
  /* Prevent dead-code elimination. All live-out data must be printed
     by the function call in argument. */
  print_array(ni, nl,  D);

  /* Be clean. */
  for (int i = 0; i < ni; i++)
    free(tmp[i]);
  free(tmp);
  for (int i = 0; i < ni; i++)
    free(A[i]);
  free(A);
  for (int i = 0; i < nk; i++)
    free(B[i]);
  free(B);
  for (int i = 0; i < nj; i++)
    free(C[i]);
  free(C);
  for (int i = 0; i < ni; i++)
    free(D[i]);
  free(D);

  return 0;
}
