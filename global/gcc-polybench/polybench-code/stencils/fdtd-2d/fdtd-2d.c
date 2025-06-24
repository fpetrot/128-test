/* fdtd-2d.c: this file is part of PolyBench/C */

typedef unsigned int wint_t;

#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include "fdtd-2d.h"
#include "global_var.h"



/* Array initialization. */
static
void init_array (int tmax,
		 int nx,
		 int ny,
		 DATA_TYPE** ex,
		 DATA_TYPE** ey,
		 DATA_TYPE** hz, 
		 DATA_TYPE* _fict_)
{
  int i, j;

  for (i = 0; i < tmax; i++)
    _fict_[i] = (DATA_TYPE) i;
  for (i = 0; i < nx; i++)
    for (j = 0; j < ny; j++)
      {
	ex[i][j] = ((DATA_TYPE) i*(j+1)) / nx;
	ey[i][j] = ((DATA_TYPE) i*(j+2)) / ny;
	hz[i][j] = ((DATA_TYPE) i*(j+3)) / nx;
      }
}


/* DCE code. Must scan the entire live-out data.
   Can be used also to check the correctness of the output. */
static
void print_array(int nx,
		 int ny,
		 DATA_TYPE** ex,
		 DATA_TYPE** ey,
		 DATA_TYPE** hz)
{
  int i, j;

  
  for (i = 0; i < nx; i++){
    for (j = 0; j < ny; j++) {
      printf(PRINTF_MODIFIER, ex[i][j]);
    }
    printf("\n");
  }

  for (i = 0; i < nx; i++){
    for (j = 0; j < ny; j++) {
      printf(PRINTF_MODIFIER, ey[i][j]);
    }
    printf("\n");
  }

  for (i = 0; i < nx; i++){
    for (j = 0; j < ny; j++) {
      printf(PRINTF_MODIFIER, hz[i][j]);
    }
    printf("\n");
  }
}


/* Main computational kernel. The whole function will be timed,
   including the call and return. */
static
void kernel_fdtd_2d(int tmax,
		    int nx,
		    int ny,
		    DATA_TYPE** ex,
		    DATA_TYPE** ey,
		    DATA_TYPE** hz,
		    DATA_TYPE* _fict_)
{
  int t, i, j;

#pragma scop

  for(t = 0; t < tmax; t++)
    {
      for (j = 0; j < ny; j++)
	ey[0][j] = _fict_[t];
      for (i = 1; i < nx; i++)
	for (j = 0; j < ny; j++)
	  ey[i][j] = ey[i][j] - SCALAR_VAL(0.5)*(hz[i][j]-hz[i-1][j]);
      for (i = 0; i < nx; i++)
	for (j = 1; j < ny; j++)
	  ex[i][j] = ex[i][j] - SCALAR_VAL(0.5)*(hz[i][j]-hz[i][j-1]);
      for (i = 0; i < nx - 1; i++)
	for (j = 0; j < ny - 1; j++)
	  hz[i][j] = hz[i][j] - SCALAR_VAL(0.7)*  (ex[i][j+1] - ex[i][j] +
				       ey[i+1][j] - ey[i][j]);
    }

#pragma endscop
}


int main(int argc, char** argv)
{
  /* Retrieve problem size. */
  int tmax = TMAX;
  int nx = NX;
  int ny = NY;

  /* Variable declaration/allocation. */
  DATA_TYPE** ex = (DATA_TYPE**)malloc(nx * sizeof(DATA_TYPE*));
  for (int i = 0; i < nx; i++)
    ex[i] = (DATA_TYPE*)malloc(ny * sizeof(DATA_TYPE));
  DATA_TYPE** ey = (DATA_TYPE**)malloc(nx * sizeof(DATA_TYPE*));
  for (int i = 0; i < nx; i++)
    ey[i] = (DATA_TYPE*)malloc(ny * sizeof(DATA_TYPE));
  DATA_TYPE** hz = (DATA_TYPE**)malloc(nx * sizeof(DATA_TYPE*));
  for (int i = 0; i < nx; i++)
    hz[i] = (DATA_TYPE*)malloc(ny * sizeof(DATA_TYPE));
  DATA_TYPE* _fict_ = (DATA_TYPE*)malloc(tmax * sizeof(DATA_TYPE));

  /* Initialize array(s). */
  init_array (tmax, nx, ny,
	      ex,
	      ey,
	      hz,
	      _fict_);

  /* Start timer. */
  

  #ifdef ARRAY_CALC
  /* Run kernel. */
  kernel_fdtd_2d (tmax, nx, ny,
		  ex,
		  ey,
		  hz,
		  _fict_);
  #endif


  /* Stop and print timer. */
  
  

  /* Prevent dead-code elimination. All live-out data must be printed
     by the function call in argument. */
  print_array(nx, ny, ex,
	      ey,
	      hz);

  /* Be clean. */
  for (int i = 0; i < nx; i++) {
    free(ex[i]);
    free(ey[i]);
    free(hz[i]);
  }
  free(ex);
  free(ey);
  free(hz);
  free(_fict_);

  return 0;
}
