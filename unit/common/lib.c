/*
 * Q&D hacks to compile for riscv
 */

typedef unsigned int size_t;

static inline void *memset(void *dest, int c, size_t n)
{
    char *p = dest;
    while (n-- > 0) {
        *(char*)dest++ = c;
    }
    return p;
}

#define UART_BASE (volatile int *)0x10000000
#define UART_TXFIFO 0

static inline int putchar(int ch)
{
    *(UART_BASE + UART_TXFIFO) = ch & 0xff;
    return ch & 0xff;
}

int putstr(const char *s)
{
    while (*s) putchar(*s++);
    return 0;
}

int putint(int v)
{
   if (v < 0) {
      v = -v;
      putchar('-');
   }
   long digits = 1;
   for (long nn = v; nn /= 10; digits++);
   for (int i = digits-1; i >= 0; i--) {
      putchar('0' + v % 10);
      v /= 10;
   }
   return 0;
}

static inline void *memcpy(void *dest, const void *src, size_t n)
{
    char *p = dest;
    while (n-- > 0) {
        *(char*)dest++ = *(char*)src++;
    }
    return p;
}

static inline double sqrt(double x)
{
   asm ("fsqrt.d %0, %1" : "=f" (x) : "f" (x));
   return x;
}

/* 
 * Thanks to https://stackoverflow.com/questions/16647278/minimal-implementation-of-sprintf-or-printf
 */
static int normalize(double *val)
{
   int exponent = 0;
   double value = *val;

   while (value >= 1.0) {
      value /= 10.0;
      ++exponent;
   }

   while (value < 0.1) {
      value *= 10.0;
      --exponent;
   }
   *val = value;
   return exponent;
}

static void ftoa_fixed(char *buffer, double value)
{
   /* carry out a fixed conversion of a double value to a string, with a precision of 5 decimal digits. 
    * Values with absolute values less than 0.000001 are rounded to 0.0
    * Note: this blindly assumes that the buffer will be large enough to hold the largest possible result.
    * The largest value we expect is an IEEE 754 double precision real, with maximum magnitude of approximately
    * e+308. The C standard requires an implementation to allow a single conversion to produce up to 512 
    * characters, so that's what we really expect as the buffer size.     
    */

   int exponent = 0;
   int places = 0;
   static const int width = 4;

   if (value == 0.0) {
      buffer[0] = '0';
      buffer[1] = '\0';
      return;
   }

   if (value < 0.0) {
      *buffer++ = '-';
      value = -value;
   }

   exponent = normalize(&value);

   while (exponent > 0) {
      int digit = value * 10;
      *buffer++ = digit + '0';
      value = value * 10 - digit;
      ++places;
      --exponent;
   }

   if (places == 0)
      *buffer++ = '0';

   *buffer++ = '.';

   while (exponent < 0 && places < width) {
      *buffer++ = '0';
      --exponent;
      ++places;
   }

   while (places < width) {
      int digit = value * 10.0;
      *buffer++ = digit + '0';
      value = value * 10.0 - digit;
      ++places;
   }
   *buffer = '\0';
}

void print_double(double f)
{
   char buffer[64];
   ftoa_fixed(buffer, f);
   putstr(buffer);
}

void cinit_array_cholesky_double(int n, double a[n][n])
{
   int i, j;
   double b[n][n];

   for (i = 0; i < n; i++) {
      for (j = 0; j < i; j++)
         a[i][j] = (double) (-j % n) / n + 1;
      a[i][i] = 1;
      for (j = i + 1; j < n; j++)
         a[i][j] = 0;
   }

   int r, s, t;
   for (r = 0; r < n; ++r)
      for (s = 0; s < n; ++s)
         b[r][s] = 0;

   for (t = 0; t < n; ++t)
      for (r = 0; r < n; ++r)
         for (s = 0; s < n; ++s)
            b[r][s] += a[r][t] * a[s][t];

   for (r = 0; r < n; ++r)
      for (s = 0; s < n; ++s)
         a[r][s] = b[r][s];
}

void print_array_cholesky_double(int n, double a[n][n])
{
   int i, j;

   putstr("==BEGIN DUMP_ARRAYS==\n");
   putstr("begin dump: a\n");
   for (i = 0; i < n; i++)
      for (j = 0; j <= i; j++) {
         if ((i * n + j) % 20 == 0)
            putstr("\n");
         print_double(a[i][j]); putstr(" ");
      }
   putstr("\nend   dump: a\n");
   putstr("==END   DUMP_ARRAYS==\n");
}


/* Dirtiest hack on earth, lovin'it though! */
void print_array_cholesky_single(int n, float a[n][n])
{
   int i, j;

   putstr("==BEGIN DUMP_ARRAYS==\n");
   putstr("begin dump: a\n");
   for (i = 0; i < n; i++)
      for (j = 0; j <= i; j++) {
         if ((i * n + j) % 20 == 0)
            putstr("\n");
         print_double((double)a[i][j]); putstr(" ");
      }
   putstr("\nend   dump: a\n");
   putstr("==END   DUMP_ARRAYS==\n");
}

void print_array_cholesky_arbitrary(void)
{
   putstr("CHOLESKY ARBITRARY\n");
}
