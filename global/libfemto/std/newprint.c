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

static void ftoa_fixed(char *buffer, double value, int flen)
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
   int decimal_buffer[32];
   int decimal_index = 0;

   if (value == 0.0) {
      buffer[0] = '0';
      buffer[1] = '.';
      while (places < flen) {
         buffer[2 + places] = '0';
         ++places;
      }
      buffer[2 + places] = '\0';
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
   
   places = 0;

   *buffer++ = '.';

   while (exponent < 0 && places < flen + 1) {
      decimal_buffer[decimal_index++] = 0;

      --exponent;
      ++places;
   }

   while (places < flen + 1) {
      int digit = value * 10.0;
      decimal_buffer[decimal_index++] = digit;
      //*buffer++ = digit + '0';
      value = value * 10.0 - digit;
      ++places;
   }

   // correct decimal_buffer by rounding the last digit

   if (decimal_buffer[flen] >= 5) {
      int i = 0;
      while (i < flen) {
         decimal_buffer[flen - (i+1)]++;
         if (decimal_buffer[flen - (i+1)] == 10) {
            decimal_buffer[flen - (i+1)] = 0;
            decimal_buffer[flen - (i+2)]++;
            i++;
         } else {
            break;
         }
      }
   }

   // Now we have the digits in decimal_buffer, we need to round the last digit
   // and write them to the buffer with rounding
   for (int i = 0; i < flen; i++) {
      *buffer++ = decimal_buffer[i] + '0';
   }

   *buffer = '\0';
}


void print_uart_double(double d)
{
  int flen = 2;
  char buffer[32];
  ftoa_fixed(buffer, d, 2);


  print_uart(buffer);
}