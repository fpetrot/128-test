#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    li s0, 0x75033785b9ca9eec0ec94d28201e1869
    //prgchk reg s0 == 0x75033785b9ca9eec0ec94d28201e1869
    
    // xori with -1 (bitwise not)
    xori s1, s0, -1
    //prgchk reg s1 == 0x8afcc87a46356113f136b2d7dfe1e796


    // Maximal immediate
    xori s1, s0, 2047
    //prgchk reg s1 == 0x75033785b9ca9eec0ec94d28201e1f96


    // Minimal immediate
    xori s1, s0, -2048
    //prgchk reg s1 == 0x8afcc87a46356113f136b2d7dfe1e069


    // xori with 0 = no-op
    xori s1, s0, 0
    //prgchk reg s1 == 0x75033785b9ca9eec0ec94d28201e1869

    // xori with zero dest : no-op
    xori zero, s0, 42
    //prgchk reg zero == 0

    // xori with self : mov zero
    li s1, 1789
    xori s2, s1, 1789
    //prgchk reg s2 == 0
    j exit
