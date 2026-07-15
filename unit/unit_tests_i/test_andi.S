#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    li s0, 0x75033785b9ca9eec0ec94d28201e1869
    //prgchk reg s0 == 0x75033785b9ca9eec0ec94d28201e1869

    // andi with max immediate
    andi s1, s0, 2047
    //prgchk reg s1 == 0x69

    // andi with min immediate
    andi s1, s0, -2048
    //prgchk reg s1 == 0x75033785b9ca9eec0ec94d28201e1800

    // andi with zero : movi 0
    andi s1, s0, 0
    //prgchk reg s1 == 0x0

    // andi with -1 : no-op
    andi s1, s0, -1
    //prgchk reg s1 == 0x75033785b9ca9eec0ec94d28201e1869

    // andi with pattern 
    andi s1, s0, 0x555
    //prgchk reg s1 == 0x41
    j exit
