#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    li s0, 0x75033785b9ca9eec0ec94d28201e1869
    //prgchk reg s0 == 0x75033785b9ca9eec0ec94d28201e1869

    // ori with max immediate
    ori s1, s0, 2047
    //prgchk reg s1 == 0x75033785b9ca9eec0ec94d28201e1fff

    // ori with min immediate
    ori s1, s0, -2048
    //prgchk reg s1 == 0xfffffffffffffffffffffffffffff869

    // ori with zero : no-op
    ori s1, s0, 0
    //prgchk reg s1 == 0x75033785b9ca9eec0ec94d28201e1869

    // ori with -1 : set to -1
    ori s1, s0, -1
    //prgchk reg s1 == 0xffffffffffffffffffffffffffffffff

    // ori with pattern 
    ori s1, s0, 0x555
    //prgchk reg s1 == 0x75033785b9ca9eec0ec94d28201e1d7d
    j exit
