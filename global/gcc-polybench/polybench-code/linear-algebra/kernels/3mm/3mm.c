/* 3mm.c: this file is part of PolyBench/C */

typedef unsigned int wint_t;

#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include "3mm.h"
#include "doKernel.h"


/* Array initialization. */
static void init_array(int ni, int nj, int nk, int nl, int nm,
                       DATA_TYPE **A,
                       DATA_TYPE **B,
                       DATA_TYPE **C,
                       DATA_TYPE **D)
{
  int i, j;

  for (i = 0; i < ni; i++)
    for (j = 0; j < nk; j++)
      A[i][j] = (DATA_TYPE)(i * j % ni) / (5 * ni);
  for (i = 0; i < nk; i++)
    for (j = 0; j < nj; j++)
      B[i][j] = (DATA_TYPE)(i * (j + 1) % nj) / (5 * nj);
  for (i = 0; i < nj; i++)
    for (j = 0; j < nm; j++)
      C[i][j] = (DATA_TYPE)(i * (j + 3) % nl) / (5 * nl);
  for (i = 0; i < nm; i++)
    for (j = 0; j < nl; j++)
      D[i][j] = (DATA_TYPE)(i * (j + 2) % nk) / (5 * nk);
}

/* DCE code. Must scan the entire live-out data.
   Can be used also to check the correctness of the output. */
static void print_array(int ni, int nl,
                        DATA_TYPE **M)
{
  int i, j;
  for (i = 0; i < ni; i++)
  {
    for (j = 0; j < nl; j++)
    {
      printf(PRINTF_MODIFIER, M[i][j]);
    }
    printf("\n");
  }
}

/* Main computational kernel. The whole function will be timed,
   including the call and return. */
static void kernel_3mm(int ni, int nj, int nk, int nl, int nm,
                       DATA_TYPE **E,
                       DATA_TYPE **A,
                       DATA_TYPE **B,
                       DATA_TYPE **F,
                       DATA_TYPE **C,
                       DATA_TYPE **D,
                       DATA_TYPE **G)
{
  int i, j, k;

#pragma scop
  /* E := A*B */
  for (i = 0; i < ni; i++)
    for (j = 0; j < nj; j++)
    {
      E[i][j] = SCALAR_VAL(0.0);
      for (k = 0; k < nk; ++k)
        E[i][j] += A[i][k] * B[k][j];
    }
  /* F := C*D */
  for (i = 0; i < nj; i++)
    for (j = 0; j < nl; j++)
    {
      F[i][j] = SCALAR_VAL(0.0);
      for (k = 0; k < nm; ++k)
        F[i][j] += C[i][k] * D[k][j];
    }
  /* G := E*F */
  for (i = 0; i < ni; i++)
    for (j = 0; j < nl; j++)
    {
      G[i][j] = SCALAR_VAL(0.0);
      for (k = 0; k < nj; ++k)
        G[i][j] += E[i][k] * F[k][j];
    }
#pragma endscop
}

int main(int argc, char **argv)
{
  /* Retrieve problem size. */
  int ni = NI;
  int nj = NJ;
  int nk = NK;
  int nl = NL;
  int nm = NM;

  DATA_TYPE **E;
  DATA_TYPE **A;
  DATA_TYPE **B;
  DATA_TYPE **F;
  DATA_TYPE **C;
  DATA_TYPE **D;
  DATA_TYPE **G;

  E = malloc(ni * sizeof(DATA_TYPE *));
  for (int i = 0; i < ni; i++)
    E[i] = malloc(nj * sizeof(DATA_TYPE));
  A = malloc(ni * sizeof(DATA_TYPE *));
  for (int i = 0; i < ni; i++)
    A[i] = malloc(nk * sizeof(DATA_TYPE));
  B = malloc(nk * sizeof(DATA_TYPE *));
  for (int i = 0; i < nk; i++)
    B[i] = malloc(nj * sizeof(DATA_TYPE));
  F = malloc(nj * sizeof(DATA_TYPE *));
  for (int i = 0; i < nj; i++)
    F[i] = malloc(nl * sizeof(DATA_TYPE));
  C = malloc(nj * sizeof(DATA_TYPE *));
  for (int i = 0; i < nj; i++)
    C[i] = malloc(nm * sizeof(DATA_TYPE));
  D = malloc(nm * sizeof(DATA_TYPE *));
  for (int i = 0; i < nm; i++)
    D[i] = malloc(nl * sizeof(DATA_TYPE));
  G = malloc(ni * sizeof(DATA_TYPE *));
  for (int i = 0; i < ni; i++)
    G[i] = malloc(nl * sizeof(DATA_TYPE));

  /* Variable declaration/allocation. */
  /* Initialize array(s). */
  init_array(ni, nj, nk, nl, nm,
             A,
             B,
             C,
             D);

  /* Start timer. */
    #ifdef ARRAY_CALC
  /* Run kernel. */
  kernel_3mm(ni, nj, nk, nl, nm,
             E,
             A,
             B,
             F,
             C,
             D,
             G);
             #endif

  /* Stop and print timer. */

  /* Prevent dead-code elimination. All live-out data must be printed
     by the function call in argument. */
  print_array(ni, nl, G);

  /* Be clean. */

  return 0;
}
