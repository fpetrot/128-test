/* doitgen.c: this file is part of PolyBench/C */

typedef unsigned int wint_t;

#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <math.h>
#include "global_var.h" 

/* Include polybench common header. */
#include <polybench.h>

/* Include benchmark-specific header. */
#include "doitgen.h"

/* Array initialization. */
static void init_array(int nr, int nq, int np,
                       DATA_TYPE POLYBENCH_3D(A, NR, NQ, NP, nr, nq, np),
                       DATA_TYPE POLYBENCH_2D(C4, NP, NP, np, np))
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
                        DATA_TYPE POLYBENCH_3D(A, NR, NQ, NP, nr, nq, np))
{
  int i, j, k;

  for (i = 0; i < nr; i++)
  {
    for (j = 0; j < nq; j++)
    {
      for (k = 0; k < np; k++)
      {
        if ((i * nq * np + j * np + k) % 20 == 0)
          #ifdef LIBFEMTO
print_uart("\n");
#else
printf("\n");
#endif
        #ifdef LIBFEMTO
print_uart_double(A[i][j][k], (int)DECIMAL_PLACES);
#else
printf(PRINTF_MODIFIER, A[i][j][k]);
#endif
        
      }
    }
  }
  #ifdef LIBFEMTO
print_uart("\n");
#else
printf("\n");
#endif
}

/* Main computational kernel. The whole function will be timed,
   including the call and return. */
void kernel_doitgen(int nr, int nq, int np,
                    DATA_TYPE POLYBENCH_3D(A, NR, NQ, NP, nr, nq, np),
                    DATA_TYPE POLYBENCH_2D(C4, NP, NP, np, np),
                    DATA_TYPE POLYBENCH_1D(sum, NP, np))
{
  int r, q, p, s;

#pragma scop
  for (r = 0; r < _PB_NR; r++)
    for (q = 0; q < _PB_NQ; q++)
    {
      for (p = 0; p < _PB_NP; p++)
      {
        sum[p] = SCALAR_VAL(0.0);
        for (s = 0; s < _PB_NP; s++)
          sum[p] += A[r][q][s] * C4[s][p];
      }
      for (p = 0; p < _PB_NP; p++)
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

  /* Variable declaration/allocation. */
  POLYBENCH_3D_ARRAY_DECL(A, DATA_TYPE, NR, NQ, NP, nr, nq, np);
  POLYBENCH_1D_ARRAY_DECL(sum, DATA_TYPE, NP, np);
  POLYBENCH_2D_ARRAY_DECL(C4, DATA_TYPE, NP, NP, np, np);

  /* Initialize array(s). */
  init_array(nr, nq, np,
             POLYBENCH_ARRAY(A),
             POLYBENCH_ARRAY(C4));

  /* Start timer. */
  polybench_start_instruments;

  #ifdef ARRAY_CALC
  /* Run kernel. */
  kernel_doitgen(nr, nq, np,
                 POLYBENCH_ARRAY(A),
                 POLYBENCH_ARRAY(C4),
                 POLYBENCH_ARRAY(sum));
  #endif /* ARRAY_CALC */

  /* Stop and print timer. */
  polybench_stop_instruments;
  polybench_print_instruments;

  #ifdef ARRAY_CALC
  /* Prevent dead-code elimination. All live-out data must be printed
     by the function call in argument. */
  print_array(nr, nq, np, POLYBENCH_ARRAY(A));
  #endif

  /* Be clean. */
  POLYBENCH_FREE_ARRAY(A);
  POLYBENCH_FREE_ARRAY(sum);
  POLYBENCH_FREE_ARRAY(C4);

  return 0;
}
