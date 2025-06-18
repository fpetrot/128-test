/* floyd-warshall.c: this file is part of PolyBench/C */

typedef unsigned int wint_t;

#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include "floyd-warshall.h"
#include "doKernel.h"



/* Array initialization. */
static
void init_array (int n,
		 DATA_TYPE** path)
{
  int i, j;

  for (i = 0; i < n; i++)
    for (j = 0; j < n; j++) {
      path[i][j] = i*j%7+1;
      if ((i+j)%13 == 0 || (i+j)%7==0 || (i+j)%11 == 0)
         path[i][j] = 999;
    }
}


/* DCE code. Must scan the entire live-out data.
   Can be used also to check the correctness of the output. */
static
void print_array(int n,
		 DATA_TYPE** path)

{
  int i, j;

 
  for (i = 0; i < n; i++){
    for (j = 0; j < n; j++) {
      printf("%d ", path[i][j]);
    }
  printf("\n");}
}


/* Main computational kernel. The whole function will be timed,
   including the call and return. */
static
void kernel_floyd_warshall(int n,
			   DATA_TYPE** path)
{
  int i, j, k;

#pragma scop
  for (k = 0; k < n; k++)
    {
      for(i = 0; i < n; i++)
	for (j = 0; j < n; j++)
	  path[i][j] = path[i][j] < path[i][k] + path[k][j] ?
	    path[i][j] : path[i][k] + path[k][j];
    }
#pragma endscop

}


int main(int argc, char** argv)
{
  /* Retrieve problem size. */
  int n = N;

  /* Variable declaration/allocation. */
  DATA_TYPE** path = (DATA_TYPE**)malloc(n * sizeof(DATA_TYPE*));
  for (int i = 0; i < n; i++)
    path[i] = (DATA_TYPE*)malloc(n * sizeof(DATA_TYPE));


  /* Initialize array(s). */
  init_array (n, path);

  /* Start timer. */
  

  /* Run kernel. */
  kernel_floyd_warshall (n, path);

  /* Stop and print timer. */
  

  /* Prevent dead-code elimination. All live-out data must be printed
     by the function call in argument. */
  print_array(n, path);

  /* Be clean. */
  for (int i = 0; i < n; i++)
    free(path[i]);
  free(path);

  return 0;
}
