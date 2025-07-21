#pragma once

#ifdef __cplusplus
extern "C" {
#endif

#include <stdarg.h>
#include <stddef.h>
int getchar(void);
int printf(const char *, ...);
/* Hack hack hack */
enum{stdout = 1, stderr = 2};
int fprintf(int fd, const char *, ...);
int putchar(int);
int puts(const char *);
int snprintf(char *, size_t, const char *, ...);
int vprintf(const char *, va_list);
int vsnprintf(char *, size_t, const char *, va_list);


/* code added to stdio because of a bug of print*/
#define LIBFEMTO
void print_uart(const char *s);
void print_uart_double(double d, int flen);
void print_uart_int(int i);

#ifdef __cplusplus
}
#endif
