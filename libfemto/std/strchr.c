#include <string.h>

char *strchr(const char *s, int c)
{
    char *p = (char *)s;
    while (*p) {
       if (*p == c) return p;
       p++;
    }
    return NULL;
}
