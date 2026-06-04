#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <math.h>

#define INT_TYPE int 
int main()
{
	INT_TYPE negative = -3;
	printf("testing abs...\n");
	printf("absolute value of %d is %d\n", negative, abs(negative));

	printf("testing sqrt...\n");
	INT_TYPE value = 4;
	printf("sqrt of %d is %lf\n", value, sqrt(value));

	printf("testing trigo func...\n");
	int step=10;
	for (int i =0; i<step; i++){
		double val = (M_PI / (step-1)) * i;
		printf("sin(%lf)=%lf\n",	val, sin(val));
		printf("cos(%lf)=%lf\n",	val, cos(val));
		printf("cos^2+sin^2=%lf\n", sin(val)*sin(val) + cos(val)*cos(val));
	}
	return 0;
}
