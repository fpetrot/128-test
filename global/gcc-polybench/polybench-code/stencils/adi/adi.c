/* adi.c: this file is part of PolyBench/C */

typedef unsigned int wint_t;

#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include "adi.h"
#include "doKernel.h"



/* Array initialization. */
static
void init_array (int n,
		 DATA_TYPE **u)
{
  int i, j;

  for (i = 0; i < n; i++)
    for (j = 0; j < n; j++)
      {
	u[i][j] =  (DATA_TYPE)(i + n-j) / n;
      }
}


/* DCE code. Must scan the entire live-out data.
   Can be used also to check the correctness of the output. */
static
void print_array(int n,
		 DATA_TYPE **u)

{
  int i, j;

  for (i = 0; i < n; i++){
    for (j = 0; j < n; j++) {
      printf(PRINTF_MODIFIER, u[i][j]);
    }
    printf("\n");
  }
}


/* Main computational kernel. The whole function will be timed,
   including the call and return. */
/* Based on a Fortran code fragment from Figure 5 of
 * "Automatic Data and Computation Decomposition on Distributed Memory Parallel Computers"
 * by Peizong Lee and Zvi Meir Kedem, TOPLAS, 2002
 */
static
void kernel_adi(int tsteps, int n,
		DATA_TYPE **u,
		DATA_TYPE **v,
		DATA_TYPE **p,
		DATA_TYPE **q)
{
  int t, i, j;
  DATA_TYPE DX, DY, DT;
  DATA_TYPE B1, B2;
  DATA_TYPE mul1, mul2;
  DATA_TYPE a, b, c, d, e, f;

#pragma scop

  DX = SCALAR_VAL(1.0)/(DATA_TYPE)n;
  DY = SCALAR_VAL(1.0)/(DATA_TYPE)n;
  DT = SCALAR_VAL(1.0)/(DATA_TYPE)tsteps;
  B1 = SCALAR_VAL(2.0);
  B2 = SCALAR_VAL(1.0);
  mul1 = B1 * DT / (DX * DX);
  mul2 = B2 * DT / (DY * DY);

  a = -mul1 /  SCALAR_VAL(2.0);
  b = SCALAR_VAL(1.0)+mul1;
  c = a;
  d = -mul2 / SCALAR_VAL(2.0);
  e = SCALAR_VAL(1.0)+mul2;
  f = d;

 for (t=1; t<=tsteps; t++) {
    //Column Sweep
    for (i=1; i<n-1; i++) {
      v[0][i] = SCALAR_VAL(1.0);
      p[i][0] = SCALAR_VAL(0.0);
      q[i][0] = v[0][i];
      for (j=1; j<n-1; j++) {
        p[i][j] = -c / (a*p[i][j-1]+b);
        q[i][j] = (-d*u[j][i-1]+(SCALAR_VAL(1.0)+SCALAR_VAL(2.0)*d)*u[j][i] - f*u[j][i+1]-a*q[i][j-1])/(a*p[i][j-1]+b);
      }
      
      v[n-1][i] = SCALAR_VAL(1.0);
      for (j=n-2; j>=1; j--) {
        v[j][i] = p[i][j] * v[j+1][i] + q[i][j];
      }
    }
    //Row Sweep
    for (i=1; i<n-1; i++) {
      u[i][0] = SCALAR_VAL(1.0);
      p[i][0] = SCALAR_VAL(0.0);
      q[i][0] = u[i][0];
      for (j=1; j<n-1; j++) {
        p[i][j] = -f / (d*p[i][j-1]+e);
        q[i][j] = (-a*v[i-1][j]+(SCALAR_VAL(1.0)+SCALAR_VAL(2.0)*a)*v[i][j] - c*v[i+1][j]-d*q[i][j-1])/(d*p[i][j-1]+e);
      }
      u[i][n-1] = SCALAR_VAL(1.0);
      for (j=n-2; j>=1; j--) {
        u[i][j] = p[i][j] * u[i][j+1] + q[i][j];
      }
    }
  }
#pragma endscop
}


int main(int argc, char** argv)
{
  /* Retrieve problem size. */
  int n = N;
  int tsteps = TSTEPS;

  /* Variable declaration/allocation. */
  DATA_TYPE **u = (DATA_TYPE **)malloc(n * sizeof(DATA_TYPE *));
  for (int i = 0; i < n; i++)
    u[i] = (DATA_TYPE *)malloc(n * sizeof(DATA_TYPE));
  DATA_TYPE **v = (DATA_TYPE **)malloc(n * sizeof(DATA_TYPE *));
  for (int i = 0; i < n; i++)
    v[i] = (DATA_TYPE *)malloc(n * sizeof(DATA_TYPE));
  DATA_TYPE **p = (DATA_TYPE **)malloc(n * sizeof(DATA_TYPE *));
  for (int i = 0; i < n; i++)
    p[i] = (DATA_TYPE *)malloc(n * sizeof(DATA_TYPE));
  DATA_TYPE **q = (DATA_TYPE **)malloc(n * sizeof(DATA_TYPE *));
  for (int i = 0; i < n; i++)
    q[i] = (DATA_TYPE *)malloc(n * sizeof(DATA_TYPE));


  /* Initialize array(s). */
  init_array (n, u);

  /* Start timer. */
  

  #ifdef ARRAY_CALC
  /* Run kernel. */
  kernel_adi (tsteps, n, u, v, p, q);
  #endif

  /* Stop and print timer. */
  
  

  /* Prevent dead-code elimination. All live-out data must be printed
     by the function call in argument. */
  print_array(n, u);

  /* Be clean. */
  for (int i = 0; i < n; i++) {
    free(u[i]);
    free(v[i]);
    free(p[i]);
    free(q[i]);
  }
  free(u);
  free(v);
  free(p);
  free(q);

  return 0;
}
