// See LICENSE for license details.

#include <stddef.h>
#include <stdarg.h>
#include <string.h>

/* Look into K&R 2nd edition */

/* reverse:  reverse string s in place */
static void reverse(char s[])
{
    int i, j;
    char c;

    for (i = 0, j = strlen(s)-1; i<j; i++, j--) {
        c = s[i];
        s[i] = s[j];
        s[j] = c;
    }
}

static void itoa(int n, char s[])
{
    int i, sign;

    if ((sign = n) < 0)  /* record sign */
        n = -n;          /* make n positive */
    i = 0;
    do {       /* generate digits in reverse order */
        s[i++] = n % 10 + '0';   /* get next digit */
    } while ((n /= 10) > 0);     /* delete it */
    if (sign < 0)
        s[i++] = '-';
    s[i] = '\0';
    reverse(s);
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

void ftoa_sci(char *buffer, double value) {
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

    int digit = value * 10.0;
    *buffer++ = digit + '0';
    value = value * 10.0 - digit;
    --exponent;

    *buffer++ = '.';

    for (int i = 0; i < width; i++) {
        int digit = value * 10.0;
        *buffer++ = digit + '0';
        value = value * 10.0 - digit;
    }

    *buffer++ = 'e';
    itoa(exponent, buffer);
}

int vsnprintf(char *out, size_t n, const char *s, va_list vl)
{
    int format = 0;
    int longarg = 0;
    size_t pos = 0;
    for (; *s; s++) {
        if (format) {
            switch(*s) {
            case 'l': {
                longarg++;
                break;
            }
            case 'p': {
                longarg = 1;
                if (out && pos < n) {
                    out[pos] = '0';
                }
                pos++;
                if (out && pos < n) {
                    out[pos] = 'x';
                }
                pos++;
            }
            case 'x': {
                __int128 num = (longarg > 1) ? va_arg(vl, __int128) : (longarg ? va_arg(vl, long) : va_arg(vl, int));
                int hexdigits = 2*((longarg > 1) ? sizeof(__int128) : (longarg ? sizeof(long) : sizeof(int)))-1;
                for(int i = hexdigits; i >= 0; i--) {
                    int d = (num >> (4*i)) & 0xF;
                    if (out && pos < n) {
                        out[pos] = (d < 10 ? '0'+d : 'a'+d-10);
                    }
                    pos++;
                }
                longarg = 0;
                format = 0;
                break;
            }
            case 'd': {
                __int128 num = (longarg > 1) ? va_arg(vl, __int128) : (longarg ? va_arg(vl, long) : va_arg(vl, int));
                if (num < 0) {
                    num = -num;
                    if (out && pos < n) {
                        out[pos] = '-';
                    }
                    pos++;
                }
                __int128 digits = 1;
                for (__int128 nn = num; nn /= 10; digits++)
                    ;
                for (int i = digits-1; i >= 0; i--) {
                    if (out && pos + i < n) {
                        out[pos + i] = '0' + (num % 10);
                    }
                    num /= 10;
                }
                pos += digits;
                longarg = 0;
                format = 0;
                break;
            }
            case 's': {
                const char* s2 = va_arg(vl, const char*);
                while (*s2) {
                    if (out && pos < n) {
                        out[pos] = *s2;
                    }
                    pos++;
                    s2++;
                }
                longarg = 0;
                format = 0;
                break;
            }
            case 'c': {
                if (out && pos < n) {
                    out[pos] = (char)va_arg(vl,int);
                }
                pos++;
                longarg = 0;
                format = 0;
                break;
            }

            case 'f': {
                char buffer[128];
                double tmp = va_arg(vl, double);
                ftoa_fixed(buffer, tmp);
                int len = strlen(buffer);
                if (out && pos + len < n) {
                    strncpy(&out[pos], buffer, len);
                }
                pos += len;
                longarg = 0;
                format = 0;
                break;
            }

            case 'e': {
                char buffer[128];
                double tmp = va_arg(vl, double);
                ftoa_sci(buffer, tmp);
                int len = strlen(buffer);
                if (out && pos + len < n) {
                    strncpy(&out[pos], buffer, len);
                }
                pos += len;
                longarg = 0;
                format = 0;
                break;
            }

            default:
                break;
            }
        }
        else if(*s == '%') {
          format = 1;
        }
        else {
          if (out && pos < n) {
            out[pos] = *s;
          }
          pos++;
        }
    }
    if (out && pos < n) {
        out[pos] = 0;
    }
    else if (out && n) {
        out[n-1] = 0;
    }
    return pos;
}
