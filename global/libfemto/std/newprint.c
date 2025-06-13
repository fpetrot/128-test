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

   // flen = number of decimal places after the decimal point
   int exponent = 0;
   int places = 0;
   // to done round before put numbers in buffer
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
      decimal_buffer[decimal_index++] = digit;
      value = value * 10 - digit;
      ++places;
      --exponent;
   }

   if (places == 0){
      decimal_buffer[decimal_index++] = 0;
   }


   decimal_buffer[decimal_index++] = -1; // add a '.' as a marker for the decimal point
   places = 0;

   while (exponent < 0 && places < flen + 1) {
      decimal_buffer[decimal_index++] = 0;
      ++exponent;
      ++places;
   }

   while (places < flen + 1) {
      int digit = value * 10.0;
      decimal_buffer[decimal_index++] = digit;
      value = value * 10.0 - digit;
      ++places;
   }

   decimal_index--;
   // correct decimal_buffer by rounding the last digit
   if (decimal_buffer[decimal_index] >= 5) {
      int i = 1;
      while (i < decimal_index + 1) {
         if (decimal_buffer[decimal_index - i] < 0) { // skip the decimal point
            i++;
            continue;
         }
         decimal_buffer[decimal_index - i]++;
         if (decimal_buffer[decimal_index - i] == 10) { // to implement if the max digit is 9
            decimal_buffer[decimal_index - i] = 0;
            if (decimal_index - i == 0) { // if we are at the first digit, we need to add a new digit
               *buffer++ = '1';
            }
            i++;
         } else {
            break;
         }
      }
   }

   for (int i = 0; i < decimal_index; i++)
   {
      if (decimal_buffer[i] < 0) {
         *buffer++ = '.'; 
         continue;
      }
      *buffer++ = decimal_buffer[i] + '0';
   }


   *buffer = '\0';
}


void print_uart_double(double d, int flen)
{
  char buffer[32];
  ftoa_fixed(buffer, d, flen);


  print_uart(buffer);
}

void print_uart_int(int i)
{
   char buffer[12]; 
   int index = 0;
   
   if (i < 0) {
      putchar_uart('-');
      i = -i;
   }
   
   if (i == 0) {
      putchar_uart('0');
      return;
   }
   
   while (i > 0) {
      buffer[index++] = (i % 10) + '0';
      i /= 10;
   }
   
   // Print the digits in reverse order
   for (int j = index - 1; j >= 0; j--) {
      putchar_uart(buffer[j]);
   }
}