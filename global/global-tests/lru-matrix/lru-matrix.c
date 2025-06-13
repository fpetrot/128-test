/*
 * Copyright (c) 2024
 * Frédéric Pétrot <frederic.petrot@univ-grenoble-alpes.fr>
 *
 * Implement lru matrix for up to 16-way set associativity using the
 * algorithms of Hacker's delight, chapter 7 and 6.
 *
 * This program is free software; you can redistribute it and/or modify it
 * under the terms and conditions of the GNU General Public License,
 * version 2 or later, as published by the Free Software Foundation.
 *
 * This program is distributed in the hope it will be useful, but WITHOUT
 * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
 * more details.
 *
 * You should have received a copy of the GNU General Public License along with
 * this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>

/*
 * On x86 __builtin_ctz(0) return 32 and __builtin_ctzl(0)
 * returns 64, but this is not portable.
 */
static inline unsigned int zctz(uint32_t n)
{
    return 32;
    //return n ? __builtin_ctz(n) : 32;
}
    
static inline unsigned int zctzl(uint64_t n)
{
    return 64;
    //return n ? __builtin_ctzl(n) : 64;
}

/*
 * 2-way
 */
void d2m(uint8_t x)
{
    putchar('0' + x);
    putchar('\n');
}

/*
 * Update lru state (lru bit is msb): 0 is accessed, 1 is lru, and conversly
 */
static inline void lru2(uint8_t *m, unsigned int i)
{
    *m = i;
}

/*
 * Either bit 0 is set and we return O, or it is not and we return 1
 */
static inline unsigned int z2(uint8_t x)
{
    return !x;
}

/*
 * 4-way
 */
void d4m(uint16_t x)
{
    for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 4; j++) {
            putchar('0' + ((x >> (4 * i + j)) & 1)); 
        }
        putchar('\n');
    }
    putchar('\n');
}

/*
 * Update 'in register' reference matrix
 */
static inline void lru4(uint16_t *m, unsigned int i)
{
    *m |= (0xf << (4 * i));
    *m &= ~(0x1111 << i);
}

/*
 * Find rank of the zero nibble in a 16-bit word.
 * This can be done from left or from right, but doing it from right is
 * a bit more efficient, and we have the warranty that only one such
 * nibble (or byte or short for the other sizes) exists.
 */
static inline unsigned int z4(uint16_t x)
{
    uint16_t y;

    y = (x - 0x1111) & ~x & 0x8888;
    return zctz(y) >> 2;
}

/*
 * 8-way
 */
void d8m(uint64_t x)
{
    for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
            putchar('0' + ((x >> (8 * i + j)) & 1)); 
        }
        putchar('\n');
    }
    putchar('\n');
}

/*
 * Update reference matrix
 */
static inline void lru8(uint64_t *m, unsigned int i)
{
    *m |= (0xffll << (8 * i));
    *m &= ~(0x0101010101010101ll << i);
}

/*
 * Find rank of zero byte in 64-bit word.
 */
static inline unsigned int z8(uint64_t x)
{
    uint64_t y;

    y = (x - 0x0101010101010101) & ~x & 0x8080808080808080;
    return zctzl(y) >> 3;
}

/*
 * 16-way
 * This is a bit more involved as 256-bit unsigneds are (not yet :)
 * natively supported in gcc
 */
typedef struct uint256_t {
    __uint128_t l;
    __uint128_t h;
} uint256_t;

void d16m(uint256_t x)
{
    for (int i = 0; i < 16; i++) {
        __uint128_t v = i < 8 ? x.l : x.h;
        int k = i < 8 ? i : i - 8;
        for (int j = 0; j < 16; j++) {
            putchar('0' + ((v >> (16 * k + j)) & 1)); 
        }
        putchar('\n');
    }
    putchar('\n');
}

/*
 * Update reference matrix
 */
static inline void lru16(uint256_t *m, unsigned int i)
{
    __uint128_t c = ((__uint128_t)0x0001000100010001 << 64) | 0x0001000100010001;
    __uint128_t ffff = (__uint128_t)0xffff;
    if (i < 8) {
        (*m).l |= (ffff << (16 * i));
    } else {
        (*m).h |= (ffff << (16 * (i - 8)));
    }
    (*m).l &= ~(c << i);
    (*m).h &= ~(c << i);
}

/*
 * Find rank of rightmost zero short in a 256-bit word.
 */
static inline unsigned int z16(uint256_t x)
{
    __uint128_t c = ((__uint128_t)0x0001000100010001 << 64) | 0x0001000100010001;
    __uint128_t d = ((__uint128_t)0x8000800080008000 << 64) | 0x8000800080008000;
    __uint128_t y;
    __uint128_t z;
    unsigned int i, j, k, l;

    y = (x.l - c) & ~x.l & d;
    z = (x.h - c) & ~x.h & d; 
    /*
     * We know for sure that there will be only a single short that
     * will be zero, so we can mask and sum up.
     */
    l = zctzl(z >> 64) >> 4;
    k = zctzl(z) >> 4;
    j = zctzl(y >> 64) >> 4;
    i = zctzl(y) >> 4;
    /*
     * Note for people that are not Richard Henderson:
     * -(0 < (n - 4)) ≡ n == 4 ? 0 : ~0
     */
    return (i & -(0 < (i - 4)))
           + ((4 + j) & -(0 < (j - 4)))
           + ((8 + k) & -(0 < (k - 4)))
           + ((12 + l) & -(0 < (l - 4)));
}

#if WAYS == 2
#define RM \
    uint8_t rm = 1
#elif WAYS == 4
#define RM \
    uint16_t rm = 0x08ce;
#elif WAYS == 8
#define RM \
    uint64_t rm = 0x0080c0e0f0f8fcfe;
#elif WAYS == 16
#define RM \
    __uint128_t l = ((__uint128_t)0xff00ff80ffc0ffe0 << 64) | 0xfff0fff8fffcfffe; \
    __uint128_t h = ((__uint128_t)0x00008000c000e000 << 64) | 0xf000f800fc00fe00; \
    uint256_t rm = {l, h};
#else
# error "Unsupported associativity"
#endif

#define PASTE(x, n) x ## n

#define TESTD(N) \
static inline unsigned int PASTE(test, N)(void) \
{ \
    RM; \
    unsigned int w, r = 0; \
    /* Proceed with execution */ \
    for (uint64_t i = 0; i < 0x1ffffffff; i++) { \
        w = i & (N - 1); \
        PASTE(lru, N)(&rm, w); \
        /* Assumes a HR% hit rate */ \
        if ((i % (100 - HR)) == 0) { \
            w = PASTE(z, N)(rm); \
            r += w; \
        } \
    } \
    return r; \
}

//0x1ffffffff


TESTD(WAYS)

#define TESTC(N) PASTE(test, N)()

int main(void)
{
    int t = TESTC(WAYS);
    printf("finish!");
    return t;
}
