// See LICENSE for license details.

#include <stdio.h>
#include <stddef.h>
#include <stdarg.h>

int printf(const char* s, ...)
{
    int res = 0;
    va_list vl;
    va_start(vl, s);
    res = vprintf(s, vl);
    va_end(vl);
    return res;
}

/* Quick and dirty hack for running the polybench without too much pain */
int fprintf(int fd, const char* s, ...)
{
    int res = 0;
    va_list vl;
    va_start(vl, s);
    res = vprintf(s, vl);
    va_end(vl);
    return res;
}
