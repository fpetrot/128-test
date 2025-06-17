/* doitgen.c: this file is part of PolyBench/C */

typedef unsigned int wint_t;

#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include "doitgen.h"
#include "doKernel.h"


/* Array initialization. */
static void init_array(int nr, int nq, int np,
                       DATA_TYPE ***A,
                       DATA_TYPE **C4)
{
  int i, j, k;

  for (i = 0; i < nr; i++)
    for (j = 0; j < nq; j++)
      for (k = 0; k < np; k++)
        A[i][j][k] = (DATA_TYPE)((i * j + k) % np) / np;
  for (i = 0; i < np; i++)
    for (j = 0; j < np; j++)
      C4[i][j] = (DATA_TYPE)(i * j % np) / np;
}

/* DCE code. Must scan the entire live-out data.
   Can be used also to check the correctness of the output. */
static void print_array(int nr, int nq, int np,
                        DATA_TYPE ***A)
{
  int i, j, k;

  for (i = 0; i < nr; i++)
  {
    for (j = 0; j < nq; j++)
    {
      for (k = 0; k < np; k++)
      {
        if ((i * nq * np + j * np + k) % 20 == 0)
          printf("\n");
        printf("%0.2lf ", A[i][j][k]);
      }
    }
  }
  printf("\n");
}

/* Main computational kernel. The whole function will be timed,
   including the call and return. */
void kernel_doitgen(int nr, int nq, int np,
                    DATA_TYPE*** A,
                    DATA_TYPE** C4,
                    DATA_TYPE* sum)
{
  int r, q, p, s;

#pragma scop
  for (r = 0; r < nr; r++)
    for (q = 0; q < nq; q++)
    {
      for (p = 0; p < np; p++)
      {
        sum[p] = SCALAR_VAL(0.0);
        for (s = 0; s < np; s++)
          sum[p] += A[r][q][s] * C4[s][p];
      }
      for (p = 0; p < np; p++)
        A[r][q][p] = sum[p];
    }
#pragma endscop
}

int main(int argc, char **argv)
{
  /* Retrieve problem size. */
  int nr = NR;
  int nq = NQ;
  int np = NP;

  DATA_TYPE*** A;
  DATA_TYPE** C4;
  DATA_TYPE* sum;

  A = malloc(nr * sizeof(DATA_TYPE**));
  for (int i = 0; i < nr; i++)
    A[i] = malloc(nq * sizeof(DATA_TYPE*));
  for (int i = 0; i < nr; i++)
    for (int j = 0; j < nq; j++)
      A[i][j] = malloc(np * sizeof(DATA_TYPE));
  C4 = malloc(np * sizeof(DATA_TYPE*));
  for (int i = 0; i < np; i++)
    C4[i] = malloc(np * sizeof(DATA_TYPE));
  sum = malloc(np * sizeof(DATA_TYPE));
  /* Variable declaration/allocation. */
  
  init_array(nr, nq, np,
             A,
             C4);

  /* Start timer. */
  

  #ifdef ARRAY_CALC
  /* Run kernel. */
  kernel_doitgen(nr, nq, np,
                 A,
                 C4,
                 sum);

  /* Stop and print timer. */


  #endif

  /* Prevent dead-code elimination. All live-out data must be printed
     by the function call in argument. */
  print_array(nr, nq, np, A);

  /* Be clean. */
  for (int i = 0; i < nr; i++)
    for (int j = 0; j < nq; j++)
      free(A[i][j]);
  free(A);
  free(sum);
  for (int i = 0; i < np; i++)
    free(C4[i]);
  free(C4);

  return 0;
}
