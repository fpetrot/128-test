/* Make sure the Int128 div and rem functions behave as expected */
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdio.h>
#include <assert.h>

#include "int128.h"
/* quick and dirty c include */
#include "int128.c"

uint64_t r(void)
{
    uint64_t x = random() << 32 | random();
    x *= random() % 2 ? -1 : 1;
    return x;
}

int main(void)
{
    Int128 x;
    Int128 y;

    srandom(122);

    /* Make sure we hit the hi < tmp case */
    for (int i = 0; i < 131070; i++) {
        x = int128_make128(~0, ~0);
        y = int128_make128(2 * i + 1, 1);
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
    for (int i = 0; i < 256; i++) {
        x = int128_make128(r() & 0xffff, 0);
        y = int128_make128(i+1, 0);
        Int128 du = int128_divu(x, y);
        printf("du 0x%016lx%016lx\n", int128_gethi(du), int128_getlo(du));
        Int128 ds = int128_divs(x, y);
        printf("ds 0x%016lx%016lx\n", int128_gethi(ds), int128_getlo(ds));
        Int128 ru = int128_remu(x, y);
        printf("ru 0x%016lx%016lx\n", int128_gethi(ru), int128_getlo(ru));
        Int128 rs = int128_rems(x, y);
        printf("rs 0x%016lx%016lx\n", int128_gethi(rs), int128_getlo(rs));
    }
    for (int i = 0; i < 100000; i++) {
        x = int128_make128(r() & 0xfffffff, 0);
        y = int128_make128(i+1, 0);
        Int128 du = int128_divu(x, y);
        printf("du 0x%016lx%016lx\n", int128_gethi(du), int128_getlo(du));
        Int128 ds = int128_divs(x, y);
        printf("ds 0x%016lx%016lx\n", int128_gethi(ds), int128_getlo(ds));
        Int128 ru = int128_remu(x, y);
        printf("ru 0x%016lx%016lx\n", int128_gethi(ru), int128_getlo(ru));
        Int128 rs = int128_rems(x, y);
        printf("rs 0x%016lx%016lx\n", int128_gethi(rs), int128_getlo(rs));
    }
    for (int i = 0; i < 100000; i++) {
        x = int128_make128(r(), 0);
        y = int128_make128(i+1, 0);
        Int128 du = int128_divu(x, y);
        printf("du 0x%016lx%016lx\n", int128_gethi(du), int128_getlo(du));
        Int128 ds = int128_divs(x, y);
        printf("ds 0x%016lx%016lx\n", int128_gethi(ds), int128_getlo(ds));
        Int128 ru = int128_remu(x, y);
        printf("ru 0x%016lx%016lx\n", int128_gethi(ru), int128_getlo(ru));
        Int128 rs = int128_rems(x, y);
        printf("rs 0x%016lx%016lx\n", int128_gethi(rs), int128_getlo(rs));
    }
    for (int i = 0; i < 100000; i++) {
        x = int128_make128(r(), r());
        y = int128_make128(r(), i);
        Int128 du = int128_divu(x, y);
        printf("du 0x%016lx%016lx\n", int128_gethi(du), int128_getlo(du));
        Int128 ds = int128_divs(x, y);
        printf("ds 0x%016lx%016lx\n", int128_gethi(ds), int128_getlo(ds));
        Int128 ru = int128_remu(x, y);
        printf("ru 0x%016lx%016lx\n", int128_gethi(ru), int128_getlo(ru));
        Int128 rs = int128_rems(x, y);
        printf("rs 0x%016lx%016lx\n", int128_gethi(rs), int128_getlo(rs));
    }
    for (int i = 0; i < 100000; i++) {
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

    for (int i = 0; i < 128; i++) {
        y = int128_make128(r(), r());
        /* shift fails if shamt > 127, no assert in function */
        Int128 r = int128_rlshift(y, i);
        printf("r%3d 0x%016lx%016lx\n", i, int128_gethi(r), int128_getlo(r));
    }
    return 0;
}
