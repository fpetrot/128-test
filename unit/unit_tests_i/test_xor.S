#include "insns.S" 
#include "utils.S"

.section .data
    test_quad:  .octa 0x75033785b9ca9eec0ec94d28201e1869
    test_mask1: .octa 0x55555555555555555555555555555555
    test_mask2: .octa 0x12341234abcdabcd567856781234efef

.section .text.init,"ax",@progbits
.globl _start
_start:
    la t0, test_quad
    lq(t0, 0, t0)
    
    // xor with -1 (bitwise not)
    li t1, -1
    xor t1, t0, t1
    //prgchk reg t1 == 0xf136b2d7dfe1e796
    srli(t1, t1, 64)
    //prgchk reg t1 == 0x8afcc87a46356113

    // xor with 0 = no-op
    li t1, 0
    xor t1, t0, 0
    //prgchk reg t1 == 0x0ec94d28201e1869
    srli(t1, t1, 64)
    //prgchk reg t1 == 0x75033785b9ca9eec

    // xor with zero dest : no-op
    xor zero, t0, t1
    //prgchk reg zero == 0
    srli(t1, zero, 64)
    //prgchk reg t1 == 0

    // xor with self : mov zero
    xor t1, t0, t0
    //prgchk reg t2 == 0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0

    // try a few 128-bit bitmasks
    la t1, test_mask1
    lq(t1, 0, t1)

    xor t2, t1, t0
    //prgchk reg t2 == 0x5b9c187d754b4d3c
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x205662d0ec9fcbb9

    la t1, test_mask2
    lq(t1, 0, t1)

    xor t2, t1, t0
    //prgchk reg t2 == 0x58b11b50322af786
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x673725b112073521
    j exit
