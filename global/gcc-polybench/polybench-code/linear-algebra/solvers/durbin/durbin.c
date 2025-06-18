/* durbin.c: this file is part of PolyBench/C */

typedef unsigned int wint_t;

#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include "durbin.h"
#include "doKernel.h"



/* Array initialization. */
static
void init_array (int n,
		 DATA_TYPE *r)
{
  int i, j;

  for (i = 0; i < n; i++)
    {
      r[i] = (n+1-i);
    }
}


/* DCE code. Must scan the entire live-out data.
   Can be used also to check the correctness of the output. */
static
void print_array(int n,
		 DATA_TYPE *y)

{
  int i;

  for (i = 0; i < n; i++) {
    if (i % 10 == 0) printf("\n");
    printf(PRINTF_MODIFIER, y[i]);
  }
  printf("\n");
}


/* Main computational kernel. The whole function will be timed,
   including the call and return. */
static
void kernel_durbin(int n,
		   DATA_TYPE *r,
		   DATA_TYPE *y)
{
 DATA_TYPE z[N];
 DATA_TYPE alpha;
 DATA_TYPE beta;
 DATA_TYPE sum;

 int i,k;

#pragma scop
 y[0] = -r[0];
 beta = SCALAR_VAL(1.0);
 alpha = -r[0];

 for (k = 1; k < n; k++) {
   beta = (1-alpha*alpha)*beta;
   sum = SCALAR_VAL(0.0);
   for (i=0; i<k; i++) {
      sum += r[k-i-1]*y[i];
   }
   alpha = - (r[k] + sum)/beta;

   for (i=0; i<k; i++) {
      z[i] = y[i] + alpha*y[k-i-1];
   }
   for (i=0; i<k; i++) {
     y[i] = z[i];
   }
   y[k] = alpha;
 }
#pragma endscop

}


int main(int argc, char** argv)
{
  /* Retrieve problem size. */
  int n = N;


  DATA_TYPE* r;
  DATA_TYPE* y;

  r = (DATA_TYPE*)malloc(N * sizeof(DATA_TYPE));
  y = (DATA_TYPE*)malloc(N * sizeof(DATA_TYPE));
  /* Variable declaration/allocation. */
  

  /* Initialize array(s). */
  init_array (n, r);

  /* Start timer. */
    /* Run kernel. */
    #ifdef ARRAY_CALC
  kernel_durbin (n,
		 r,
		 y);
    #endif

  /* Stop and print timer. */
  

  /* Prevent dead-code elimination. All live-out data must be printed
     by the function call in argument. */
  print_array(n, y);

  /* Be clean. */
  free(r);
  free(y);

  return 0;
}
