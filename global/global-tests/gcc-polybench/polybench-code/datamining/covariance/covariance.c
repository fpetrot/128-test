/* covariance.c: this file is part of PolyBench/C */

typedef unsigned int wint_t;

#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include "covariance.h"


/* Array initialization. */
static
void init_array (int m, int n,
		 DATA_TYPE *float_n,
		 DATA_TYPE **data)
{
  int i, j;

  *float_n = (DATA_TYPE)n;

  for (i = 0; i < N; i++)
    for (j = 0; j < M; j++)
      data[i][j] = ((DATA_TYPE) i*j) / M;
}


/* DCE code. Must scan the entire live-out data.
   Can be used also to check the correctness of the output. */
static
void print_array(int m,
		 DATA_TYPE** cov)
{
  int i, j;

  for (i = 0; i < m; i++){
    for (j = 0; j < m; j++) {
      printf("%0.2lf ", cov[i][j]);
    }
    printf("\n");
  }
}


/* Main computational kernel. The whole function will be timed,
   including the call and return. */
static
void kernel_covariance(int m, int n,
		       DATA_TYPE float_n,
		       DATA_TYPE **data,
		       DATA_TYPE **cov,
		       DATA_TYPE *mean)
{
  int i, j, k;

#pragma scop
  for (j = 0; j < m; j++)
    {
      mean[j] = SCALAR_VAL(0.0);
      for (i = 0; i < n; i++)
        mean[j] += data[i][j];
      mean[j] /= float_n;
    }

  for (i = 0; i < n; i++)
    for (j = 0; j < m; j++)
      data[i][j] -= mean[j];

  for (i = 0; i < m; i++)
    for (j = i; j < m; j++)
      {
        cov[i][j] = SCALAR_VAL(0.0);
        for (k = 0; k < n; k++)
	  cov[i][j] += data[k][i] * data[k][j];
        cov[i][j] /= (float_n - SCALAR_VAL(1.0));
        cov[j][i] = cov[i][j];
      }
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
  DATA_TYPE **cov = (DATA_TYPE **)malloc(m * sizeof(DATA_TYPE *));
  for (int i = 0; i < m; i++) {
    cov[i] = (DATA_TYPE *)malloc(m * sizeof(DATA_TYPE));
  }
  DATA_TYPE *mean = (DATA_TYPE *)malloc(m * sizeof(DATA_TYPE));


  /* Initialize array(s). */
  init_array (m, n, &float_n, data);

  /* Start timer. */
  
  #ifdef ARRAY_CALC
  /* Run kernel. */
  kernel_covariance (m, n, float_n,
		     data,
		     cov,
		     mean);

  /* Stop and print timer. */


  #endif

  /* Prevent dead-code elimination. All live-out data must be printed
     by the function call in argument. */
  print_array(m, cov);

  /* Be clean. */
  for (int i = 0; i < n; i++) {
    free(data[i]);
  }
  free(data);
  for (int i = 0; i < m; i++) {
    free(cov[i]);
  }
  free(cov);
  free(mean);

  return 0;
}
