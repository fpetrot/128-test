#include "exit.S"

.section .data
    test_quad: .octa 0x75033785b9ca9eec0ec94d28201e1869

.section .text.init,"ax",@progbits
.globl _start
_start:
    la t0, test_quad
    lq t0, 0(t0)

    // ori with max immediate
    ori t1, t0, 2047
    //prgchk reg t1 == 0x75033785b9ca9eec0ec94d28201e1fff

    // ori with min immediate
    ori t1, t0, -2048
    //prgchk reg t1 == 0xfffffffffffffffffffffffffffff869

    // ori with zero : no-op
    ori t1, t0, 0
    //prgchk reg t1 == 0x75033785b9ca9eec0ec94d28201e1869

    // ori with -1 : set to -1
    ori t1, t0, -1
    //prgchk reg t1 == 0xffffffffffffffffffffffffffffffff

    // ori with pattern 
    ori t1, t0, 0x555
    //prgchk reg t1 == 0x75033785b9ca9eec0ec94d28201e1d7d
    j exit
