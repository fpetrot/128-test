#define UART_BASE 0x10000000L
#define UART_THR (volatile char *)(UART_BASE)



void putchar_uart(char c)
{
  *UART_THR = c;
}

void print_uart(const char *s)
{
  while (*s)
  {
    putchar_uart(*s++);
  }
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

void print_uart_double(double d)
{
  char buffer[32];
  ftoa_fixed(buffer,d);
  print_uart(buffer);
}


