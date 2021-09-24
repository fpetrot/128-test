/* Make sure the Int128 div and rem functions behave as expected */
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdio.h>
#include <assert.h>

#include "int128.h"

uint64_t r(void)
{
    uint64_t x = random() << 32 | random();
    x *= random() % 2 ? -1 : 1;
    return x;
}

int main(void)
{
    srandom(122);
    for (int i = 0; i < 100000; i++) {
        Int128 x = int128_make128(r(), r());
        Int128 y = int128_make128(r(), i);
        Int128 du = int128_divu(x, y);
        printf("0x%016lx%016lx\n", int128_gethi(du), int128_getlo(du));
        Int128 ds = int128_divs(x, y);
        printf("0x%016lx%016lx\n", int128_gethi(ds), int128_getlo(ds));
        Int128 ru = int128_remu(x, y);
        printf("0x%016lx%016lx\n", int128_gethi(ru), int128_getlo(ru));
        Int128 rs = int128_rems(x, y);
        printf("0x%016lx%016lx\n", int128_gethi(rs), int128_getlo(rs));
    }
    return 0;
}
