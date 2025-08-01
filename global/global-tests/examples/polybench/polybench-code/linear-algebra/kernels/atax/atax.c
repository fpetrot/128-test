/* atax.c: this file is part of PolyBench/C */

typedef unsigned int wint_t;

#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <math.h>
#include "global_var.h" 

/* Include polybench common header. */
#include <polybench.h>

/* Include benchmark-specific header. */
#include "atax.h"

/* Array initialization. */
static void init_array(int m, int n,
                       DATA_TYPE POLYBENCH_2D(A, M, N, m, n),
                       DATA_TYPE POLYBENCH_1D(x, N, n))
{
  int i, j;
  DATA_TYPE fn;
  fn = (DATA_TYPE)n;

  for (i = 0; i < n; i++)
    x[i] = 1 + (i / fn);
  for (i = 0; i < m; i++)
    for (j = 0; j < n; j++)
      A[i][j] = (DATA_TYPE)((i + j) % n) / (5 * m);
}

/* DCE code. Must scan the entire live-out data.
   Can be used also to check the correctness of the output. */
static void print_array(int n,
                        DATA_TYPE POLYBENCH_1D(y, N, n))

{
  int i;
  for (i = 0; i < n; i++)
  {
    if (i % 10 == 0)
#ifdef LIBFEMTO
          print_uart("\n");
#else
    printf("\n");
#endif
#ifdef LIBFEMTO
    print_uart_double(y[i], (int)DECIMAL_PLACES);
#else
    printf(PRINTF_MODIFIER, y[i]);
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
static void kernel_atax(int m, int n,
                        DATA_TYPE POLYBENCH_2D(A, M, N, m, n),
                        DATA_TYPE POLYBENCH_1D(x, N, n),
                        DATA_TYPE POLYBENCH_1D(y, N, n),
                        DATA_TYPE POLYBENCH_1D(tmp, M, m))
{
  int i, j;

#pragma scop
  for (i = 0; i < _PB_N; i++)
    y[i] = 0;
  for (i = 0; i < _PB_M; i++)
  {
    tmp[i] = SCALAR_VAL(0.0);
    for (j = 0; j < _PB_N; j++)
      tmp[i] = tmp[i] + A[i][j] * x[j];
    for (j = 0; j < _PB_N; j++)
      y[j] = y[j] + A[i][j] * tmp[i];
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
  POLYBENCH_1D_ARRAY_DECL(x, DATA_TYPE, N, n);
  POLYBENCH_1D_ARRAY_DECL(y, DATA_TYPE, N, n);
  POLYBENCH_1D_ARRAY_DECL(tmp, DATA_TYPE, M, m);

  /* Initialize array(s). */
  init_array(m, n, POLYBENCH_ARRAY(A), POLYBENCH_ARRAY(x));

  /* Start timer. */
  polybench_start_instruments;

#ifdef ARRAY_CALC
  /* Run kernel. */
  kernel_atax(m, n,
              POLYBENCH_ARRAY(A),
              POLYBENCH_ARRAY(x),
              POLYBENCH_ARRAY(y),
              POLYBENCH_ARRAY(tmp));

  /* Stop and print timer. */
  polybench_stop_instruments;
  polybench_print_instruments;
#endif

  /* Prevent dead-code elimination. All live-out data must be printed
     by the function call in argument. */
  print_array(n, POLYBENCH_ARRAY(y));

  /* Be clean. */
  POLYBENCH_FREE_ARRAY(A);
  POLYBENCH_FREE_ARRAY(x);
  POLYBENCH_FREE_ARRAY(y);
  POLYBENCH_FREE_ARRAY(tmp);

  return 0;
}
