/* seidel-2d.c: this file is part of PolyBench/C */

typedef unsigned int wint_t;

#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include "seidel-2d.h"
#include "doKernel.h"


/* Array initialization. */
static
void init_array (int n,
		 DATA_TYPE** A)
{
  int i, j;

  for (i = 0; i < n; i++)
    for (j = 0; j < n; j++)
      A[i][j] = ((DATA_TYPE) i*(j+2) + 2) / n;
}


/* DCE code. Must scan the entire live-out data.
   Can be used also to check the correctness of the output. */
static
void print_array(int n,
		 DATA_TYPE** A)

{
  int i, j;

  for (i = 0; i < n; i++){
    for (j = 0; j < n; j++) {
      printf(PRINTF_MODIFIER, A[i][j]);
    }
    printf("\n");
  }
}


/* Main computational kernel. The whole function will be timed,
   including the call and return. */
static
void kernel_seidel_2d(int tsteps,
		      int n,
		      DATA_TYPE** A)
{
  int t, i, j;

#pragma scop
  for (t = 0; t <= tsteps - 1; t++)
    for (i = 1; i<= n - 2; i++)
      for (j = 1; j <= n - 2; j++)
	A[i][j] = (A[i-1][j-1] + A[i-1][j] + A[i-1][j+1]
		   + A[i][j-1] + A[i][j] + A[i][j+1]
		   + A[i+1][j-1] + A[i+1][j] + A[i+1][j+1])/SCALAR_VAL(9.0);
#pragma endscop

}


int main(int argc, char** argv)
{
  /* Retrieve problem size. */
  int n = N;
  int tsteps = TSTEPS;

  /* Variable declaration/allocation. */
  DATA_TYPE** A = (DATA_TYPE**)malloc(n * sizeof(DATA_TYPE*));
  for (int i = 0; i < n; i++) {
    A[i] = (DATA_TYPE*)malloc(n * sizeof(DATA_TYPE));
  }


  /* Initialize array(s). */
  init_array (n, A);

  /* Start timer. */
  
#ifdef ARRAY_CALC
  /* Run kernel. */
  kernel_seidel_2d (tsteps, n, A);
  #endif

  /* Stop and print timer. */
  

  /* Prevent dead-code elimination. All live-out data must be printed
     by the function call in argument. */
  print_array(n, A);

  /* Be clean. */
  for (int i = 0; i < n; i++) {
    free(A[i]);
  }
  free(A);

  return 0;
}
