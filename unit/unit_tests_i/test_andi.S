#include "insns.S" 
#include "utils.S"

.section .data
    test_quad: .octa 0x75033785b9ca9eec0ec94d28201e1869

.section .text.init,"ax",@progbits
.globl _start
_start:
# We're in bare metal, so set stack at the end of physical memory
la      sp, _memory_end
j main

main:
    la t0, test_quad
    lq(t0, 0, t0)

    // andi with max immediate
    andi t1, t0, 2047
    //prgchk reg t1 == 0x69
    srli(t1, t1, 64)
    //prgchk reg t1 == 0

    // andi with min immediate
    andi t1, t0, -2048
    //prgchk reg t1 == 0x0ec94d28201e1800
    srli(t1, t1, 64)
    //prgchk reg t1 == 0x75033785b9ca9eec

    // andi with zero : movi 0
    andi t1, t0, 0
    //prgchk reg t1 == 0
    srli(t1, t1, 64)
    //prgchk reg t1 == 0

    // andi with -1 : no-op
    andi t1, t0, -1
    //prgchk reg t1 == 0x0ec94d28201e1869
    srli(t1, t1, 64)
    //prgchk reg t1 == 0x75033785b9ca9eec

    // andi with pattern 
    andi t1, t0, 0x555
    //prgchk reg t1 == 0x41
    srli(t1, t1, 64)
    //prgchk reg t1 == 0
j exit