/* Make sure the Int128 div and rem functions behave as expected */
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

#include "int128.h"

uint64_t r(void) {
    uint64_t x = random() << 32 | random();
    x *= random() % 2 ? -1 : 1;
    return x;
}

int main(void) {
    Int128 x;
    Int128 y;

    srandom(122);

    /* Make sure we hit the hi < tmp case */
    for (int i = 0; i < 1310; i++) {
        x = int128_make128(r(), r());
        y = int128_make128(r(), r());
        Int128 du = int128_divu(x, y);
        printf("du 0x%016lx%016lx\n", int128_gethi(du), int128_getlo(du));
        Int128 ds = int128_divs(x, y);
        printf("ds 0x%016lx%016lx\n", int128_gethi(ds), int128_getlo(ds));
        Int128 ru = int128_remu(x, y);
        printf("ru 0x%016lx%016lx\n", int128_gethi(ru), int128_getlo(ru));
        Int128 rs = int128_rems(x, y);
        printf("rs 0x%016lx%016lx\n", int128_gethi(rs), int128_getlo(rs));
    }

    return 0;
}
