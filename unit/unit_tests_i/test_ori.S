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

    // ori with max immediate
    ori t1, t0, 2047
    //prgchk reg t1 == 0x0ec94d28201e1fff
    srli(t1, t1, 64)
    //prgchk reg t1 == 0x75033785b9ca9eec

    // ori with min immediate
    ori t1, t0, -2048
    //prgchk reg t1 == 0xfffffffffffff869
    srli(t1, t1, 64)
    //prgchk reg t1 == 0xffffffffffffffff

    // ori with zero : no-op
    ori t1, t0, 0
    //prgchk reg t1 == 0x0ec94d28201e1869
    srli(t1, t1, 64)
    //prgchk reg t1 == 0x75033785b9ca9eec

    // ori with -1 : set to -1
    ori t1, t0, -1
    //prgchk reg t1 == 0xffffffffffffffff
    srli(t1, t1, 64)
    //prgchk reg t1 == 0xffffffffffffffff

    // ori with pattern 
    ori t1, t0, 0x555
    //prgchk reg t1 == 0x0ec94d28201e1d7d
    srli(t1, t1, 64)
    //prgchk reg t1 == 0x75033785b9ca9eec
j exit