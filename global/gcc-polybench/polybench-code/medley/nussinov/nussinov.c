/* nussinov.c: this file is part of PolyBench/C */

typedef unsigned int wint_t;

#include <stdio.h>
#include <string.h>
#include <math.h>
#include <stdlib.h>
#include "nussinov.h"
#include "doKernel.h"


/* RNA bases represented as chars, range is [0,3] */
typedef char base;

#define match(b1, b2) (((b1)+(b2)) == 3 ? 1 : 0)
#define max_score(s1, s2) ((s1 >= s2) ? s1 : s2)

/* Array initialization. */
static
void init_array (int n,
                 base* seq,
		 DATA_TYPE** table)
{
  int i, j;

  //base is AGCT/0..3
  for (i=0; i <n; i++) {
     seq[i] = (base)((i+1)%4);
  }

  for (i=0; i <n; i++)
     for (j=0; j <n; j++)
       table[i][j] = 0;
}


/* DCE code. Must scan the entire live-out data.
   Can be used also to check the correctness of the output. */
static
void print_array(int n,
		 DATA_TYPE** table)

{
  int i, j;
  int t = 0;

  for (i = 0; i < n; i++) {
    for (j = i; j < n; j++) {
      if (j % 10 == 0) printf("\n");
      printf("%d ", table[i][j]);
      t++;
    }
  }
  printf("\n");
}

static
void kernel_nussinov(int n, base* seq, DATA_TYPE** table)
{
  int i, j, k;

#pragma scop
 for (i = n-1; i >= 0; i--) {
  for (j=i+1; j<n; j++) {

   if (j-1>=0) 
      table[i][j] = max_score(table[i][j], table[i][j-1]);
   if (i+1<n) 
      table[i][j] = max_score(table[i][j], table[i+1][j]);

   if (j-1>=0 && i+1<n) {
     /* don't allow adjacent elements to bond */
     if (i<j-1) 
        table[i][j] = max_score(table[i][j], table[i+1][j-1]+match(seq[i], seq[j]));
     else 
        table[i][j] = max_score(table[i][j], table[i+1][j-1]);
   }

   for (k=i+1; k<j; k++) {
      table[i][j] = max_score(table[i][j], table[i][k] + table[k+1][j]);
   }
  }
 }
#pragma endscop

}


int main(int argc, char** argv)
{
  /* Retrieve problem size. */
  int n = N;

  /* Variable declaration/allocation. */
  base* seq = (base*)malloc(n * sizeof(base));
  DATA_TYPE** table = (DATA_TYPE**)malloc(n * sizeof(DATA_TYPE*));
  for (int i = 0; i < n; i++)
    table[i] = (DATA_TYPE*)malloc(n * sizeof(DATA_TYPE));

  /* Initialize array(s). */
  init_array (n, seq, table);

  /* Start timer. */

#ifdef ARRAY_CALC
  /* Run kernel. */
  kernel_nussinov (n, seq, table);
  #endif

  /* Stop and print timer. */


  /* Prevent dead-code elimination. All live-out data must be printed
     by the function call in argument. */
  print_array(n, table);

  /* Be clean. */
  free(seq);
  for (int i = 0; i < n; i++)
    free(table[i]);
  free(table);

  return 0;
}
