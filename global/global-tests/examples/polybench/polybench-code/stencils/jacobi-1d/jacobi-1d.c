/* jacobi-1d.c: this file is part of PolyBench/C */

typedef unsigned int wint_t;

#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <math.h>
#include "global_var.h" 

/* Include polybench common header. */
#include <polybench.h>

/* Include benchmark-specific header. */
#include "jacobi-1d.h"

/* Array initialization. */
static void init_array(int n,
                       DATA_TYPE POLYBENCH_1D(A, N, n),
                       DATA_TYPE POLYBENCH_1D(B, N, n))
{
  int i;

  for (i = 0; i < n; i++)
  {
    A[i] = ((DATA_TYPE)i + 2) / n;
    B[i] = ((DATA_TYPE)i + 3) / n;
  }
}

/* DCE code. Must scan the entire live-out data.
   Can be used also to check the correctness of the output. */
static void print_array(int n,
                        DATA_TYPE POLYBENCH_1D(A, N, n))

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
    print_uart_double(A[i], (int)DECIMAL_PLACES);
#else
    printf(PRINTF_MODIFIER, A[i]);
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
static void kernel_jacobi_1d(int tsteps,
                             int n,
                             DATA_TYPE POLYBENCH_1D(A, N, n),
                             DATA_TYPE POLYBENCH_1D(B, N, n))
{
  int t, i;

#pragma scop
  for (t = 0; t < _PB_TSTEPS; t++)
  {
    for (i = 1; i < _PB_N - 1; i++)
      B[i] = 0.33333 * (A[i - 1] + A[i] + A[i + 1]);
    for (i = 1; i < _PB_N - 1; i++)
      A[i] = 0.33333 * (B[i - 1] + B[i] + B[i + 1]);
  }
#pragma endscop
}

int main(int argc, char **argv)
{
  /* Retrieve problem size. */
  int n = N;
  int tsteps = TSTEPS;

  /* Variable declaration/allocation. */
  POLYBENCH_1D_ARRAY_DECL(A, DATA_TYPE, N, n);
  POLYBENCH_1D_ARRAY_DECL(B, DATA_TYPE, N, n);

  /* Initialize array(s). */
  init_array(n, POLYBENCH_ARRAY(A), POLYBENCH_ARRAY(B));

  /* Start timer. */
  polybench_start_instruments;

#ifdef ARRAY_CALC
  /* Run kernel. */
  kernel_jacobi_1d(tsteps, n, POLYBENCH_ARRAY(A), POLYBENCH_ARRAY(B));
#endif /* ARRAY_CALC */
  /* Stop and print timer. */
  polybench_stop_instruments;
  polybench_print_instruments;

  /* Prevent dead-code elimination. All live-out data must be printed
     by the function call in argument. */
  print_array(n, POLYBENCH_ARRAY(A));

  /* Be clean. */
  POLYBENCH_FREE_ARRAY(A);
  POLYBENCH_FREE_ARRAY(B);

  return 0;
}
