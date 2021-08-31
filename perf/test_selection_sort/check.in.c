#include <stdint.h>

#define TABSIZE @TABSIZE@
#define TYPE @TYPE@

extern int putstr(const char *s);
extern int putint(int v);

extern TYPE tableau[TABSIZE];

void checkthestuff()
{
   int i;
   for (i = 0; i < TABSIZE - 1; i++)
      if (tableau[i] > tableau[i+1])
         putstr("Hell, we're screwed at index"),
         putint(i),
         putstr("\n");
   if (i == TABSIZE - 1)
      putstr("We're good\n");
}
