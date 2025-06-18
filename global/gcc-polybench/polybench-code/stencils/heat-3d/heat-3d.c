/* heat-3d.c: this file is part of PolyBench/C */

typedef unsigned int wint_t;

#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include "heat-3d.h"
#include "doKernel.h"



/* Array initialization. */
static
void init_array (int n,
		 DATA_TYPE*** A,
		 DATA_TYPE*** B)
{
  int i, j, k;

  for (i = 0; i < n; i++)
    for (j = 0; j < n; j++)
      for (k = 0; k < n; k++)
        A[i][j][k] = B[i][j][k] = (DATA_TYPE) (i + j + (n-k))* 10 / (n);
}


/* DCE code. Must scan the entire live-out data.
   Can be used also to check the correctness of the output. */
static
void print_array(int n,
		 DATA_TYPE*** A)

{
  int i, j, k;

  for (i = 0; i < n; i++)
    for (j = 0; j < n; j++)
      for (k = 0; k < n; k++) {
         if ((i * n * n + j * n + k) % 20 == 0) printf("\n");
         printf(PRINTF_MODIFIER, A[i][j][k]);
      }
  printf("\n");
}


/* Main computational kernel. The whole function will be timed,
   including the call and return. */
static
void kernel_heat_3d(int tsteps,
		      int n,
		      DATA_TYPE*** A,
		      DATA_TYPE*** B)
{
  int t, i, j, k;

#pragma scop
    for (t = 1; t <= tsteps; t++) {
        for (i = 1; i < n-1; i++) {
            for (j = 1; j < n-1; j++) {
                for (k = 1; k < n-1; k++) {
                    B[i][j][k] =   SCALAR_VAL(0.125) * (A[i+1][j][k] - SCALAR_VAL(2.0) * A[i][j][k] + A[i-1][j][k])
                                 + SCALAR_VAL(0.125) * (A[i][j+1][k] - SCALAR_VAL(2.0) * A[i][j][k] + A[i][j-1][k])
                                 + SCALAR_VAL(0.125) * (A[i][j][k+1] - SCALAR_VAL(2.0) * A[i][j][k] + A[i][j][k-1])
                                 + A[i][j][k];
                }
            }
        }
        for (i = 1; i < n-1; i++) {
           for (j = 1; j < n-1; j++) {
               for (k = 1; k < n-1; k++) {
                   A[i][j][k] =   SCALAR_VAL(0.125) * (B[i+1][j][k] - SCALAR_VAL(2.0) * B[i][j][k] + B[i-1][j][k])
                                + SCALAR_VAL(0.125) * (B[i][j+1][k] - SCALAR_VAL(2.0) * B[i][j][k] + B[i][j-1][k])
                                + SCALAR_VAL(0.125) * (B[i][j][k+1] - SCALAR_VAL(2.0) * B[i][j][k] + B[i][j][k-1])
                                + B[i][j][k];
               }
           }
       }
    }
#pragma endscop

}


int main(int argc, char** argv)
{
  /* Retrieve problem size. */
  int n = N;
  int tsteps = TSTEPS;

  /* Variable declaration/allocation. */
  DATA_TYPE*** A = (DATA_TYPE***)malloc(n * sizeof(DATA_TYPE**));
  for (int i = 0; i < n; i++) {
    A[i] = (DATA_TYPE**)malloc(n * sizeof(DATA_TYPE*));
    for (int j = 0; j < n; j++) {
      A[i][j] = (DATA_TYPE*)malloc(n * sizeof(DATA_TYPE));
    }
  }
  DATA_TYPE*** B = (DATA_TYPE***)malloc(n * sizeof(DATA_TYPE**));
  for (int i = 0; i < n; i++) {
    B[i] = (DATA_TYPE**)malloc(n * sizeof(DATA_TYPE*));
    for (int j = 0; j < n; j++) {
      B[i][j] = (DATA_TYPE*)malloc(n * sizeof(DATA_TYPE));
    }
  }


  /* Initialize array(s). */
  init_array (n, A, B);

  /* Start timer. */
  
#ifdef ARRAY_CALC
  /* Run kernel. */
  kernel_heat_3d (tsteps, n, A, B);
#endif
  /* Stop and print timer. */
  

  /* Prevent dead-code elimination. All live-out data must be printed
     by the function call in argument. */
  print_array(n, A);

  /* Be clean. */
  for (int i = 0; i < n; i++) {
    free(A[i]);
    free(B[i]);
  }
  free(A);
  free(B);

  return 0;
}
