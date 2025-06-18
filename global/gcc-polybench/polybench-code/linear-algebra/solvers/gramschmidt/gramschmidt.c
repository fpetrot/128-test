/* gramschmidt.c: this file is part of PolyBench/C */

typedef unsigned int wint_t;

#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include "gramschmidt.h"
#include "doKernel.h"


/* Array initialization. */
static void init_array(int m, int n,
                       DATA_TYPE **A,
                       DATA_TYPE **R,
                       DATA_TYPE **Q)
{
  int i, j;

  for (i = 0; i < m; i++)
    for (j = 0; j < n; j++)
    {
      A[i][j] = (((DATA_TYPE)((i * j) % m) / m) * 100) + 10;
      Q[i][j] = 0.0;
    }
  for (i = 0; i < n; i++)
    for (j = 0; j < n; j++)
      R[i][j] = 0.0;
}

/* DCE code. Must scan the entire live-out data.
   Can be used also to check the correctness of the output. */
static void print_array(int m, int n,
                        DATA_TYPE **A,
                        DATA_TYPE **R,
                        DATA_TYPE **Q)
{
  int i, j;

  for (i = 0; i < n; i++)
  {
    for (j = 0; j < n; j++)
    {
      printf(PRINTF_MODIFIER, R[i][j]);  
    }
    printf("\n");
  }

  for (i = 0; i < m; i++)
  {
    for (j = 0; j < n; j++)
    {
      printf(PRINTF_MODIFIER, Q[i][j]);
    }
    printf("\n");
  }
  printf("\n");
}

/* Main computational kernel. The whole function will be timed,
   including the call and return. */
/* QR Decomposition with Modified Gram Schmidt:
 http://www.inf.ethz.ch/personal/gander/ */
static void kernel_gramschmidt(int m, int n,
                               DATA_TYPE** A,
                               DATA_TYPE** R,
                               DATA_TYPE** Q)
{
  int i, j, k;

  DATA_TYPE nrm;

#pragma scop
  for (k = 0; k < n; k++)
  {
    nrm = SCALAR_VAL(0.0);
    for (i = 0; i < m; i++)
      nrm += A[i][k] * A[i][k];
    R[k][k] = sqrt(nrm);
    for (i = 0; i < m; i++)
      Q[i][k] = A[i][k] / R[k][k];
    for (j = k + 1; j < n; j++)
    {
      R[k][j] = SCALAR_VAL(0.0);
      for (i = 0; i < m; i++)
        R[k][j] += Q[i][k] * A[i][j];
      for (i = 0; i < m; i++)
        A[i][j] = A[i][j] - Q[i][k] * R[k][j];
    }
  }
#pragma endscop
}

int main(int argc, char **argv)
{
  /* Retrieve problem size. */
  int m = M;
  int n = N;

  DATA_TYPE** A;
  DATA_TYPE** R;
  DATA_TYPE** Q;
  A = (DATA_TYPE**)malloc(m * sizeof(DATA_TYPE*));
  for (int i = 0; i < m; i++)
    A[i] = (DATA_TYPE*)malloc(n * sizeof(DATA_TYPE));
  R = (DATA_TYPE**)malloc(n * sizeof(DATA_TYPE*));
  for (int i = 0; i < n; i++)
    R[i] = (DATA_TYPE*)malloc(n * sizeof(DATA_TYPE));
  Q = (DATA_TYPE**)malloc(m * sizeof(DATA_TYPE*));
  for (int i = 0; i < m; i++)
    Q[i] = (DATA_TYPE*)malloc(n * sizeof(DATA_TYPE));
  /* Variable declaration/allocation. */
  

  /* Initialize array(s). */
  init_array(m, n,
             A,
             R,
             Q);

  /* Start timer. */
  

  #ifdef ARRAY_CALC
  /* Run kernel. */
  kernel_gramschmidt(m, n,
                     A,
                     R,
                     Q);
  #endif

  /* Stop and print timer. */
  
  
  /* Prevent dead-code elimination. All live-out data must be printed
     by the function call in argument. */
  print_array(m, n, A, R, Q);

  /* Be clean. */
  for (int i = 0; i < m; i++)
    free(A[i]);
  free(A);
  for (int i = 0; i < n; i++)
    free(R[i]);
  free(R);
  for (int i = 0; i < m; i++)
    free(Q[i]);
  free(Q);

  return 0;
}
