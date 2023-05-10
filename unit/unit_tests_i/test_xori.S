#include "insns.S" 
#include "utils.S"

.section .data
    test_quad: .octa 0x75033785b9ca9eec0ec94d28201e1869

.section .text.init,"ax",@progbits
.globl _start
_start:
    la t0, test_quad
    lq t0, 0(t0)
    
    // xori with -1 (bitwise not)
    xori t1, t0, -1
    //prgchk reg t1 == 0x8afcc87a46356113f136b2d7dfe1e796


    // Maximal immediate
    xori t1, t0, 2047
    //prgchk reg t1 == 0x75033785b9ca9eec0ec94d28201e1f96


    // Minimal immediate
    xori t1, t0, -2048
    //prgchk reg t1 == 0x8afcc87a46356113f136b2d7dfe1e069


    // xori with 0 = no-op
    xori t1, t0, 0
    //prgchk reg t1 == 0x75033785b9ca9eec0ec94d28201e1869

    // xori with zero dest : no-op
    xori zero, t0, 42
    //prgchk reg zero == 0
    liu(t1, zero)
    //prgchk reg t1 == 0

    // xori with self : mov zero
    liu(t1, 1789)
    xori t2, t1, 1789
    //prgchk reg t2 == 0
    j exit
