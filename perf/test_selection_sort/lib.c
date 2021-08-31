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
