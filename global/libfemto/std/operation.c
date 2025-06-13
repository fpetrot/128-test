#include <math.h>

double
sqrt (double x)
{
  asm ("fsqrt.s %0, %1" : "=f" (x) : "f" (x));
  return x;
}