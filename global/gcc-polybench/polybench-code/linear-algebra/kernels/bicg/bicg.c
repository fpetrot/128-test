/* bicg.c: this file is part of PolyBench/C */

typedef unsigned int wint_t;

#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include "bicg.h"
#include "global_var.h"



/* Array initialization. */
static
void init_array (int m, int n,
		 DATA_TYPE** A,
		 DATA_TYPE* r,
		 DATA_TYPE* p)
{
  int i, j;

  for (i = 0; i < m; i++)
    p[i] = (DATA_TYPE)(i % m) / m;
  for (i = 0; i < n; i++) {
    r[i] = (DATA_TYPE)(i % n) / n;
    for (j = 0; j < m; j++)
      A[i][j] = (DATA_TYPE) (i*(j+1) % n)/n;
  }
}


/* DCE code. Must scan the entire live-out data.
   Can be used also to check the correctness of the output. */
static
void print_array(int m, int n,
		 DATA_TYPE* s,
		 DATA_TYPE* q)

{
  int i;

  printf("s:\n");
  for (i = 0; i < m; i++) {
    if (i % 10 == 0) printf("\n");
    printf(PRINTF_MODIFIER, s[i]);
  }
  printf("\nq:\n");
  for (i = 0; i < n; i++) {
    if (i % 10 == 0) printf("\n");
    printf(PRINTF_MODIFIER, q[i]);
  }
  printf("\n");
}


/* Main computational kernel. The whole function will be timed,
   including the call and return. */
static
void kernel_bicg(int m, int n,
		 DATA_TYPE** A,
		 DATA_TYPE* s,
		 DATA_TYPE* q,
		 DATA_TYPE* p,
		 DATA_TYPE* r)
{
  int i, j;

#pragma scop
  for (i = 0; i < m; i++)
    s[i] = 0;
  for (i = 0; i < n; i++)
    {
      q[i] = SCALAR_VAL(0.0);
      for (j = 0; j < m; j++)
	{
	  s[j] = s[j] + r[i] * A[i][j];
	  q[i] = q[i] + A[i][j] * p[j];
	}
    }
#pragma endscop

}


int main(int argc, char** argv)
{
  /* Retrieve problem size. */
  int n = N;
  int m = M;

  /* Variable declaration/allocation. */
  DATA_TYPE** A = (DATA_TYPE**)malloc(n * sizeof(DATA_TYPE*));
  for (int i = 0; i < n; i++)
    A[i] = (DATA_TYPE*)malloc(m * sizeof(DATA_TYPE));
  DATA_TYPE* s = (DATA_TYPE*)malloc(m * sizeof(DATA_TYPE));
  DATA_TYPE* q = (DATA_TYPE*)malloc(n * sizeof(DATA_TYPE));
  DATA_TYPE* p = (DATA_TYPE*)malloc(m * sizeof(DATA_TYPE));
  DATA_TYPE* r = (DATA_TYPE*)malloc(n * sizeof(DATA_TYPE));

  /* Initialize array(s). */
  init_array (m, n,
	      A,
	      r,
	      p);

  /* Start timer. */
  

  #ifdef ARRAY_CALC
  /* Run kernel. */
  kernel_bicg (m, n,
	       A,
	       s,
	       q,
	       p,
	       r);
  #endif

  /* Stop and print timer. */
  

  /* Prevent dead-code elimination. All live-out data must be printed
     by the function call in argument. */
  print_array(m, n, s, q);

  /* Be clean. */
  for (int i = 0; i < n; i++)
    free(A[i]);
  free(A);
  free(s);
  free(q);
  free(p);
  free(r);

  return 0;
}
