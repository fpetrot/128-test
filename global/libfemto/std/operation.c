#include <math.h>

// https://c-for-dummies.com/blog/?p=4250
double
sqrt (double x)
{
  double y;
  int p,square,c;

  /* find the surrounding perfect squares */
  p = 0;
  do
  {
      p++;
      square = (p+1) * (p+1);
  }
  while( x > square );

  /* process the root */
  y = (double)p;
  c = 0;
  while(c<10)
  {
      /* divide and average */
      y = (x/y + y)/2;
      /* test for success */
      if( y*y == x)
          return(y);
      c++;
  }
  return(y);
}