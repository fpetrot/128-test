/* gesummv.c: this file is part of PolyBench/C */

typedef unsigned int wint_t;

#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <math.h>
#include "global_var.h" 

/* Include polybench common header. */
#include <polybench.h>

/* Include benchmark-specific header. */
#include "gesummv.h"

/* Array initialization. */
static void init_array(int n,
                       DATA_TYPE *alpha,
                       DATA_TYPE *beta,
                       DATA_TYPE POLYBENCH_2D(A, N, N, n, n),
                       DATA_TYPE POLYBENCH_2D(B, N, N, n, n),
                       DATA_TYPE POLYBENCH_1D(x, N, n))
{
  int i, j;

  *alpha = 1.5;
  *beta = 1.2;
  for (i = 0; i < n; i++)
  {
    x[i] = (DATA_TYPE)(i % n) / n;
    for (j = 0; j < n; j++)
    {
      A[i][j] = (DATA_TYPE)(i * j % n) / n;
      B[i][j] = (DATA_TYPE)(i * j % n) / n;
    }
  }
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
static void kernel_gesummv(int n,
                           DATA_TYPE alpha,
                           DATA_TYPE beta,
                           DATA_TYPE POLYBENCH_2D(A, N, N, n, n),
                           DATA_TYPE POLYBENCH_2D(B, N, N, n, n),
                           DATA_TYPE POLYBENCH_1D(tmp, N, n),
                           DATA_TYPE POLYBENCH_1D(x, N, n),
                           DATA_TYPE POLYBENCH_1D(y, N, n))
{
  int i, j;

#pragma scop
  for (i = 0; i < _PB_N; i++)
  {
    tmp[i] = SCALAR_VAL(0.0);
    y[i] = SCALAR_VAL(0.0);
    for (j = 0; j < _PB_N; j++)
    {
      tmp[i] = A[i][j] * x[j] + tmp[i];
      y[i] = B[i][j] * x[j] + y[i];
    }
    y[i] = alpha * tmp[i] + beta * y[i];
  }
#pragma endscop
}

int main(int argc, char **argv)
{
  /* Retrieve problem size. */
  int n = N;

  /* Variable declaration/allocation. */
  DATA_TYPE alpha;
  DATA_TYPE beta;
  POLYBENCH_2D_ARRAY_DECL(A, DATA_TYPE, N, N, n, n);
  POLYBENCH_2D_ARRAY_DECL(B, DATA_TYPE, N, N, n, n);
  POLYBENCH_1D_ARRAY_DECL(tmp, DATA_TYPE, N, n);
  POLYBENCH_1D_ARRAY_DECL(x, DATA_TYPE, N, n);
  POLYBENCH_1D_ARRAY_DECL(y, DATA_TYPE, N, n);

  /* Initialize array(s). */
  init_array(n, &alpha, &beta,
             POLYBENCH_ARRAY(A),
             POLYBENCH_ARRAY(B),
             POLYBENCH_ARRAY(x));

  /* Start timer. */
  polybench_start_instruments;
#ifdef ARRAY_CALC
  /* Run kernel. */
  kernel_gesummv(n, alpha, beta,
                 POLYBENCH_ARRAY(A),
                 POLYBENCH_ARRAY(B),
                 POLYBENCH_ARRAY(tmp),
                 POLYBENCH_ARRAY(x),
                 POLYBENCH_ARRAY(y));
#endif
  /* Stop and print timer. */
  polybench_stop_instruments;
  polybench_print_instruments;

  /* Prevent dead-code elimination. All live-out data must be printed
     by the function call in argument. */
  print_array(n, POLYBENCH_ARRAY(y));

  /* Be clean. */
  POLYBENCH_FREE_ARRAY(A);
  POLYBENCH_FREE_ARRAY(B);
  POLYBENCH_FREE_ARRAY(tmp);
  POLYBENCH_FREE_ARRAY(x);
  POLYBENCH_FREE_ARRAY(y);

  return 0;
}
