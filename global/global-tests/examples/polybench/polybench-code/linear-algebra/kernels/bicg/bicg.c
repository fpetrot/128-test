/* bicg.c: this file is part of PolyBench/C */

typedef unsigned int wint_t;

#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <math.h>
#include "global_var.h" 

/* Include polybench common header. */
#include <polybench.h>

/* Include benchmark-specific header. */
#include "bicg.h"

/* Array initialization. */
static void init_array(int m, int n,
                       DATA_TYPE POLYBENCH_2D(A, N, M, n, m),
                       DATA_TYPE POLYBENCH_1D(r, N, n),
                       DATA_TYPE POLYBENCH_1D(p, M, m))
{
  int i, j;

  for (i = 0; i < m; i++)
    p[i] = (DATA_TYPE)(i % m) / m;
  for (i = 0; i < n; i++)
  {
    r[i] = (DATA_TYPE)(i % n) / n;
    for (j = 0; j < m; j++)
      A[i][j] = (DATA_TYPE)(i * (j + 1) % n) / n;
  }
}

/* DCE code. Must scan the entire live-out data.
   Can be used also to check the correctness of the output. */
static void print_array(int m, int n,
                        DATA_TYPE POLYBENCH_1D(s, M, m),
                        DATA_TYPE POLYBENCH_1D(q, N, n))

{
  int i;

  for (i = 0; i < m; i++)
  {
    if (i % 10 == 0)
#ifdef LIBFEMTO
      print_uart("\n");
#else
      printf("\n");
#endif
#ifdef LIBFEMTO
    print_uart_double(s[i], (int)DECIMAL_PLACES);
#else
    printf(PRINTF_MODIFIER, s[i]);
#endif
  }
  for (i = 0; i < m; i++)
  {
    if (i % 10 == 0)
#ifdef LIBFEMTO
      print_uart("\n");
#else
      printf("\n");
#endif
#ifdef LIBFEMTO
    print_uart_double(s[i], (int)DECIMAL_PLACES);
#else
    printf(PRINTF_MODIFIER, s[i]);
#endif
  }
  for (i = 0; i < n; i++)
  {
    if (i % 10 == 0)
#ifdef LIBFEMTO
          print_uart("\n");
#else
    printf("\n");
#endif
#ifdef LIBFEMTO
    print_uart_double(q[i], (int)DECIMAL_PLACES);
#else
    printf(PRINTF_MODIFIER, q[i]);
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
static void kernel_bicg(int m, int n,
                        DATA_TYPE POLYBENCH_2D(A, N, M, n, m),
                        DATA_TYPE POLYBENCH_1D(s, M, m),
                        DATA_TYPE POLYBENCH_1D(q, N, n),
                        DATA_TYPE POLYBENCH_1D(p, M, m),
                        DATA_TYPE POLYBENCH_1D(r, N, n))
{
  int i, j;

#pragma scop
  for (i = 0; i < _PB_M; i++)
    s[i] = 0;
  for (i = 0; i < _PB_N; i++)
  {
    q[i] = SCALAR_VAL(0.0);
    for (j = 0; j < _PB_M; j++)
    {
      s[j] = s[j] + r[i] * A[i][j];
      q[i] = q[i] + A[i][j] * p[j];
    }
  }
#pragma endscop
}

int main(int argc, char **argv)
{
  /* Retrieve problem size. */
  int n = N;
  int m = M;

  /* Variable declaration/allocation. */
  POLYBENCH_2D_ARRAY_DECL(A, DATA_TYPE, N, M, n, m);
  POLYBENCH_1D_ARRAY_DECL(s, DATA_TYPE, M, m);
  POLYBENCH_1D_ARRAY_DECL(q, DATA_TYPE, N, n);
  POLYBENCH_1D_ARRAY_DECL(p, DATA_TYPE, M, m);
  POLYBENCH_1D_ARRAY_DECL(r, DATA_TYPE, N, n);

  /* Initialize array(s). */
  init_array(m, n,
             POLYBENCH_ARRAY(A),
             POLYBENCH_ARRAY(r),
             POLYBENCH_ARRAY(p));

  /* Start timer. */
  polybench_start_instruments;

#ifdef ARRAY_CALC
  /* Run kernel. */
  kernel_bicg(m, n,
              POLYBENCH_ARRAY(A),
              POLYBENCH_ARRAY(s),
              POLYBENCH_ARRAY(q),
              POLYBENCH_ARRAY(p),
              POLYBENCH_ARRAY(r));
#endif

  /* Stop and print timer. */
  polybench_stop_instruments;
  polybench_print_instruments;

  /* Prevent dead-code elimination. All live-out data must be printed
     by the function call in argument. */
  print_array(m, n, POLYBENCH_ARRAY(s), POLYBENCH_ARRAY(q));

  /* Be clean. */
  POLYBENCH_FREE_ARRAY(A);
  POLYBENCH_FREE_ARRAY(s);
  POLYBENCH_FREE_ARRAY(q);
  POLYBENCH_FREE_ARRAY(p);
  POLYBENCH_FREE_ARRAY(r);

  return 0;
}
