/* heat-3d.c: this file is part of PolyBench/C */

typedef unsigned int wint_t;

#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <math.h>
#include "global_var.h" 

/* Include polybench common header. */
#include <polybench.h>

/* Include benchmark-specific header. */
#include "heat-3d.h"

/* Array initialization. */
static void init_array(int n,
                       DATA_TYPE POLYBENCH_3D(A, N, N, N, n, n, n),
                       DATA_TYPE POLYBENCH_3D(B, N, N, N, n, n, n))
{
  int i, j, k;

  for (i = 0; i < n; i++)
    for (j = 0; j < n; j++)
      for (k = 0; k < n; k++)
        A[i][j][k] = B[i][j][k] = (DATA_TYPE)(i + j + (n - k)) * 10 / (n);
}

/* DCE code. Must scan the entire live-out data.
   Can be used also to check the correctness of the output. */
static void print_array(int n,
                        DATA_TYPE POLYBENCH_3D(A, N, N, N, n, n, n))

{
  int i, j, k;

  for (i = 0; i < n; i++)
    for (j = 0; j < n; j++)
      for (k = 0; k < n; k++)
      {
        if ((i * n * n + j * n + k) % 20 == 0)
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
#ifdef LIBFEMTO
  print_uart("\n");
#else
  printf("\n");
#endif
}

/* Main computational kernel. The whole function will be timed,
   including the call and return. */
static void kernel_heat_3d(int tsteps,
                           int n,
                           DATA_TYPE POLYBENCH_3D(A, N, N, N, n, n, n),
                           DATA_TYPE POLYBENCH_3D(B, N, N, N, n, n, n))
{
  int t, i, j, k;

#pragma scop
  for (t = 1; t <= TSTEPS; t++)
  {
    for (i = 1; i < _PB_N - 1; i++)
    {
      for (j = 1; j < _PB_N - 1; j++)
      {
        for (k = 1; k < _PB_N - 1; k++)
        {
          B[i][j][k] = SCALAR_VAL(0.125) * (A[i + 1][j][k] - SCALAR_VAL(2.0) * A[i][j][k] + A[i - 1][j][k]) + SCALAR_VAL(0.125) * (A[i][j + 1][k] - SCALAR_VAL(2.0) * A[i][j][k] + A[i][j - 1][k]) + SCALAR_VAL(0.125) * (A[i][j][k + 1] - SCALAR_VAL(2.0) * A[i][j][k] + A[i][j][k - 1]) + A[i][j][k];
        }
      }
    }
    for (i = 1; i < _PB_N - 1; i++)
    {
      for (j = 1; j < _PB_N - 1; j++)
      {
        for (k = 1; k < _PB_N - 1; k++)
        {
          A[i][j][k] = SCALAR_VAL(0.125) * (B[i + 1][j][k] - SCALAR_VAL(2.0) * B[i][j][k] + B[i - 1][j][k]) + SCALAR_VAL(0.125) * (B[i][j + 1][k] - SCALAR_VAL(2.0) * B[i][j][k] + B[i][j - 1][k]) + SCALAR_VAL(0.125) * (B[i][j][k + 1] - SCALAR_VAL(2.0) * B[i][j][k] + B[i][j][k - 1]) + B[i][j][k];
        }
      }
    }
  }
#pragma endscop
}

int main(int argc, char **argv)
{
  /* Retrieve problem size. */
  int n = N;
  int tsteps = TSTEPS;

  /* Variable declaration/allocation. */
  POLYBENCH_3D_ARRAY_DECL(A, DATA_TYPE, N, N, N, n, n, n);
  POLYBENCH_3D_ARRAY_DECL(B, DATA_TYPE, N, N, N, n, n, n);

  /* Initialize array(s). */
  init_array(n, POLYBENCH_ARRAY(A), POLYBENCH_ARRAY(B));

  /* Start timer. */
  polybench_start_instruments;

#ifdef ARRAY_CALC
  /* Run kernel. */
  kernel_heat_3d(tsteps, n, POLYBENCH_ARRAY(A), POLYBENCH_ARRAY(B));
#endif /* ARRAY_CALC */
  /* Stop and print timer. */
  polybench_stop_instruments;
  polybench_print_instruments;

  /* Prevent dead-code elimination. All live-out data must be printed
     by the function call in argument. */
  print_array(n, POLYBENCH_ARRAY(A));

  /* Be clean. */
  POLYBENCH_FREE_ARRAY(A);

  return 0;
}
