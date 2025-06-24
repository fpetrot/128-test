/* jacobi-1d.c: this file is part of PolyBench/C */

typedef unsigned int wint_t;

#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include "jacobi-1d.h"
#include "global_var.h"



/* Array initialization. */
static
void init_array (int n,
		 DATA_TYPE* A,
		 DATA_TYPE* B)
{
  int i;

  for (i = 0; i < n; i++)
      {
	A[i] = ((DATA_TYPE) i+ 2) / n;
	B[i] = ((DATA_TYPE) i+ 3) / n;
      }
}


/* DCE code. Must scan the entire live-out data.
   Can be used also to check the correctness of the output. */
static
void print_array(int n,
		 DATA_TYPE* A)

{
  int i;

  for (i = 0; i < n; i++)
    {
      if (i % 10 == 0) printf("\n");
      printf(PRINTF_MODIFIER, A[i]);
    }
  printf("\n");
}


/* Main computational kernel. The whole function will be timed,
   including the call and return. */
static
void kernel_jacobi_1d(int tsteps,
			    int n,
			    DATA_TYPE* A,
			    DATA_TYPE* B)
{
  int t, i;

#pragma scop
  for (t = 0; t < tsteps; t++)
    {
      for (i = 1; i < n - 1; i++)
	B[i] = 0.33333 * (A[i-1] + A[i] + A[i + 1]);
      for (i = 1; i < n - 1; i++)
	A[i] = 0.33333 * (B[i-1] + B[i] + B[i + 1]);
    }
#pragma endscop

}


int main(int argc, char** argv)
{
  /* Retrieve problem size. */
  int n = N;
  int tsteps = TSTEPS;

  /* Variable declaration/allocation. */
  DATA_TYPE* A = (DATA_TYPE*)malloc(n * sizeof(DATA_TYPE));
  DATA_TYPE* B = (DATA_TYPE*)malloc(n * sizeof(DATA_TYPE));

  /* Initialize array(s). */
  init_array (n, A, B);

  /* Start timer. */
  
#ifdef ARRAY_CALC
  /* Run kernel. */
  kernel_jacobi_1d(tsteps, n, A, B);
  #endif

  /* Stop and print timer. */
  
  

  /* Prevent dead-code elimination. All live-out data must be printed
     by the function call in argument. */
  print_array(n, A);

  /* Be clean. */
  free(A);
  free(B);

  return 0;
}
