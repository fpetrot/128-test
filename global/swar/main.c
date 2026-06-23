/*******************************************************************************
 * vim:set ts=3:
 * File   : conv-int.c, file for JPEG-JFIF sequential decoder
 *
 * Copyright (C) 2007-2018 TIMA Laboratory
 * Author(s) :      Frédéric Pétrot <Frederic.Petrot@imag.fr>
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License
 * as published by the Free Software Foundation; either version 2
 * of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301,
 * USA.
 *
 *************************************************************************************/

// #include "stdint.h"
#include "stdio.h"
#include "stdlib.h"
#include <stdint.h>

#define LOOP_COUNT 1
#define NB_VALUES 16

#define N sizeof(uint64_t)

#define H 0x8080808080808080

uint64_t swar_add(uint64_t a, uint64_t b) {
    return ((a & ~H) + (b & ~H)) ^ ((a ^ b) & H);
}

uint64_t swar_sub(uint64_t a, uint64_t b) {
    return ((a | H) - (b & ~H)) ^ ((a ^ ~b) & H);
}

uint64_t swar_const(uint8_t b) {
    uint64_t c = b;
    c = (c << 56) | (c << 48) | (c << 40) | (c << 32) | (c << 24) | (c << 16) |
        (c << 8) | c;
    return c;
}

void base(uint8_t *restrict a, uint8_t *restrict b, uint64_t size) {
    for (int64_t i = 0; i < size; i++) {
        a[i] -= b[i];
    }
}

void swar(uint8_t *restrict a, uint8_t *restrict b, uint64_t size) {
    uint64_t *big_a = (uint64_t *)a;
    uint64_t *big_b = (uint64_t *)b;
    for (int64_t i = 0; i < size / N; i++) {
        big_a[i] = swar_sub(big_a[i], big_b[i]);
    }
}

int main() {
    uint8_t *a = malloc(sizeof(uint8_t) * NB_VALUES);
    uint8_t *b = malloc(sizeof(uint8_t) * NB_VALUES);

    for (uint64_t i = 0; i < LOOP_COUNT; i++) {
        for (uint64_t j = 0; j < NB_VALUES; j++) {
            a[j] = (uint8_t)i + (uint8_t)j;
            b[j] = (uint8_t)i - (uint8_t)j;
        }
        __asm__("nop");
        base(a, b, NB_VALUES);
    }

    for (uint64_t i = 0; i < NB_VALUES; i++) {
        printf("%03d\n", a[i]);
    }

    return 0;
}
