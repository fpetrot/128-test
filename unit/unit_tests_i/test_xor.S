#include "exit.S"


.section .text.init,"ax",@progbits
.globl _start
_start:
    li s0, 0x75033785b9ca9eec0ec94d28201e1869
    //prgchk reg s0 == 0x75033785b9ca9eec0ec94d28201e1869
    
    // xor with -1 (bitwise not)
    li s1, -1
    //prgchk reg s1 == 0xffffffffffffffffffffffffffffffff
    xor s1, s0, s1
    //prgchk reg s1 == 0x8afcc87a46356113f136b2d7dfe1e796


    // xor with 0 = no-op
    li s1, 0
    xor s1, s0, 0
    //prgchk reg s1 == 0x75033785b9ca9eec0ec94d28201e1869


    // xor with zero dest : no-op
    xor zero, s0, s1
    //prgchk reg zero == 0

    // xor with self : mov zero
    xor s1, s0, s0
    //prgchk reg s2 == 0

    // try a few 128-bit bitmasks
    li s1, 0x55555555555555555555555555555555
    //prgchk reg s1 == 0x55555555555555555555555555555555

    xor s2, s1, s0
    //prgchk reg s2 == 0x205662d0ec9fcbb95b9c187d754b4d3c

    li s1, 0x12341234abcdabcd567856781234efef
    //prgchk reg s1 == 0x12341234abcdabcd567856781234efef

    xor s2, s1, s0
    //prgchk reg s2 == 0x673725b11207352158b11b50322af786
    j exit
