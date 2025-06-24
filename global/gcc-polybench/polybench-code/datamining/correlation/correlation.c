/* correlation.c: this file is part of PolyBench/C */

typedef unsigned int wint_t;

#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include "correlation.h"
#include "global_var.h"


/* Array initialization. */
static
void init_array (int m,
		 int n,
		 DATA_TYPE *float_n,
		 DATA_TYPE **data)
{
  int i, j;

  *float_n = (DATA_TYPE)N;

  for (i = 0; i < N; i++)
    for (j = 0; j < M; j++)
      data[i][j] = (DATA_TYPE)(i*j)/M + i;
    
}


/* DCE code. Must scan the entire live-out data.
   Can be used also to check the correctness of the output. */
static
void print_array(int m,
		 DATA_TYPE** corr)

{
  int i, j;

 
  for (i = 0; i < m; i++){
    for (j = 0; j < m; j++) {
            printf(PRINTF_MODIFIER, corr[i][j]);
    }
    printf("\n");
  }
}


/* Main computational kernel. The whole function will be timed,
   including the call and return. */
static
void kernel_correlation(int m, int n,
			DATA_TYPE float_n,
			DATA_TYPE **data,
			DATA_TYPE **corr,
			DATA_TYPE *mean,
			DATA_TYPE *stddev)
{
  int i, j, k;

  DATA_TYPE eps = SCALAR_VAL(0.1);


#pragma scop
  for (j = 0; j < m; j++)
    {
      mean[j] = SCALAR_VAL(0.0);
      for (i = 0; i < n; i++)
	mean[j] += data[i][j];
      mean[j] /= float_n;
    }


   for (j = 0; j < m; j++)
    {
      stddev[j] = SCALAR_VAL(0.0);
      for (i = 0; i < n; i++)
        stddev[j] += (data[i][j] - mean[j]) * (data[i][j] - mean[j]);
      stddev[j] /= float_n;
      stddev[j] = SQRT_FUN(stddev[j]);
      /* The following in an inelegant but usual way to handle
         near-zero std. dev. values, which below would cause a zero-
         divide. */
      stddev[j] = stddev[j] <= eps ? SCALAR_VAL(1.0) : stddev[j];
    }

  /* Center and reduce the column vectors. */
  for (i = 0; i < n; i++)
    for (j = 0; j < m; j++)
      {
        data[i][j] -= mean[j];
        data[i][j] /= SQRT_FUN(float_n) * stddev[j];
      }

  /* Calculate the m * m correlation matrix. */
  for (i = 0; i < m-1; i++)
    {
      corr[i][i] = SCALAR_VAL(1.0);
      for (j = i+1; j < m; j++)
        {
          corr[i][j] = SCALAR_VAL(0.0);
          for (k = 0; k < n; k++)
            corr[i][j] += (data[k][i] * data[k][j]);
          corr[j][i] = corr[i][j];
        }
    }
  corr[m-1][m-1] = SCALAR_VAL(1.0);
#pragma endscop

}


int main(int argc, char** argv)
{
  /* Retrieve problem size. */
  int n = N;
  int m = M;

  /* Variable declaration/allocation. */
  DATA_TYPE float_n;
  DATA_TYPE **data = (DATA_TYPE **)malloc(n * sizeof(DATA_TYPE *));
  for (int i = 0; i < n; i++) {
    data[i] = (DATA_TYPE *)malloc(m * sizeof(DATA_TYPE));
  }
  DATA_TYPE **corr = (DATA_TYPE **)malloc(m * sizeof(DATA_TYPE *));
  for (int i = 0; i < m; i++) {
    corr[i] = (DATA_TYPE *)malloc(m * sizeof(DATA_TYPE));
  }
  DATA_TYPE *mean = (DATA_TYPE *)malloc(m * sizeof(DATA_TYPE));
  DATA_TYPE *stddev = (DATA_TYPE *)malloc(m * sizeof(DATA_TYPE));

  /* Initialize array(s). */
  init_array (m, n, &float_n, data);

  /* Start timer. */
  

  /* Run kernel. */
  kernel_correlation (m, n, float_n,
		      data,
		      corr,
		      mean,
		      stddev);

  /* Stop and print timer. */
    

  /* Prevent dead-code elimination. All live-out data must be printed
     by the function call in argument. */
  print_array(m, corr);

  /* Be clean. */
  for (int i = 0; i < n; i++) {
    free(data[i]);
  }
  free(data);
  for (int i = 0; i < m; i++) {
    free(corr[i]);
  }
  free(corr);
  free(mean);
  free(stddev);

  return 0;
}
