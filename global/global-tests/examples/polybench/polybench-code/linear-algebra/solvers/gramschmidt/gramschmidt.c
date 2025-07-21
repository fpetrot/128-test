/* gramschmidt.c: this file is part of PolyBench/C */

typedef unsigned int wint_t;

#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <math.h>
#include "global_var.h" 

/* Include polybench common header. */
#include <polybench.h>

/* Include benchmark-specific header. */
#include "gramschmidt.h"

/* Array initialization. */
static void init_array(int m, int n,
                       DATA_TYPE POLYBENCH_2D(A, M, N, m, n),
                       DATA_TYPE POLYBENCH_2D(R, N, N, n, n),
                       DATA_TYPE POLYBENCH_2D(Q, M, N, m, n))
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
                        DATA_TYPE POLYBENCH_2D(A, M, N, m, n),
                        DATA_TYPE POLYBENCH_2D(R, N, N, n, n),
                        DATA_TYPE POLYBENCH_2D(Q, M, N, m, n))
{
  int i, j;

  for (i = 0; i < n; i++)
  {
    for (j = 0; j < n; j++)
    {
      #ifdef LIBFEMTO
print_uart_double(R[i][j], (int)DECIMAL_PLACES);
#else
printf(PRINTF_MODIFIER, R[i][j]);
#endif
      
    }
    #ifdef LIBFEMTO
print_uart("\n");
#else
printf("\n");
#endif
  }
  
  for (i = 0; i < m; i++)
  {
    for (j = 0; j < n; j++)
    {
      #ifdef LIBFEMTO
print_uart_double(Q[i][j], (int)DECIMAL_PLACES);
#else
printf(PRINTF_MODIFIER, Q[i][j]);
#endif
      
    }
    #ifdef LIBFEMTO
print_uart("\n");
#else
printf("\n");
#endif
  }
  #ifdef LIBFEMTO
print_uart("\n");
#else
printf("\n");
#endif
}

/* Main computational kernel. The whole function will be timed,
   including the call and return. */
/* QR Decomposition with Modified Gram Schmidt:
 http://www.inf.ethz.ch/personal/gander/ */
static void kernel_gramschmidt(int m, int n,
                               DATA_TYPE POLYBENCH_2D(A, M, N, m, n),
                               DATA_TYPE POLYBENCH_2D(R, N, N, n, n),
                               DATA_TYPE POLYBENCH_2D(Q, M, N, m, n))
{
  int i, j, k;

  DATA_TYPE nrm;

#pragma scop
  for (k = 0; k < _PB_N; k++)
  {
    nrm = SCALAR_VAL(0.0);
    for (i = 0; i < _PB_M; i++)
      nrm += A[i][k] * A[i][k];
    R[k][k] = SQRT_FUN(nrm);
    for (i = 0; i < _PB_M; i++)
      Q[i][k] = A[i][k] / R[k][k];
    for (j = k + 1; j < _PB_N; j++)
    {
      R[k][j] = SCALAR_VAL(0.0);
      for (i = 0; i < _PB_M; i++)
        R[k][j] += Q[i][k] * A[i][j];
      for (i = 0; i < _PB_M; i++)
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

  /* Variable declaration/allocation. */
  POLYBENCH_2D_ARRAY_DECL(A, DATA_TYPE, M, N, m, n);
  POLYBENCH_2D_ARRAY_DECL(R, DATA_TYPE, N, N, n, n);
  POLYBENCH_2D_ARRAY_DECL(Q, DATA_TYPE, M, N, m, n);

  /* Initialize array(s). */
  init_array(m, n,
             POLYBENCH_ARRAY(A),
             POLYBENCH_ARRAY(R),
             POLYBENCH_ARRAY(Q));

  /* Start timer. */
  polybench_start_instruments;

  #ifdef ARRAY_CALC
  /* Run kernel. */
  kernel_gramschmidt(m, n,
                     POLYBENCH_ARRAY(A),
                     POLYBENCH_ARRAY(R),
                     POLYBENCH_ARRAY(Q));
  #endif /* ARRAY_CALC */

  /* Stop and print timer. */
  polybench_stop_instruments;
  polybench_print_instruments;

  /* Prevent dead-code elimination. All live-out data must be printed
     by the function call in argument. */
  print_array(m, n, POLYBENCH_ARRAY(A), POLYBENCH_ARRAY(R), POLYBENCH_ARRAY(Q));

  /* Be clean. */
  POLYBENCH_FREE_ARRAY(A);
  POLYBENCH_FREE_ARRAY(R);
  POLYBENCH_FREE_ARRAY(Q);

  return 0;
}
