#include "utils.S"
#include "exit.S"

.section .rodata
    d1:        .dword 0x1234567890abcdef
    d2:        .dword 0xfedcba0987654321
    minusone:  .dword 0xffffffffffffffff
    d3:        .dword 0xffffffffffffffd6
    d4:        .dword 0x7000000000000000

.section .text.init,"ax",@progbits
.globl _start
_start:
    ld s0, d1
    ld s1, d2
    muld s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffc24a442fe55618cf
    muld s2, s1, s0
    //prgchk reg s2 == 0xffffffffffffffffc24a442fe55618cf

    ld s0, d2
    ld s1, minusone
    muld s2, s0, s1
    //prgchk reg s2 == 0x012345f6789abcdf

    ld s0, minusone
    ld s1, d3
    muld s2, s0, s1
    //prgchk reg s2 == 42

    ld s0, minusone
    muld s2, s0, s0
    //prgchk reg s2 == 1

    // test sign extension
    ld s0, d4
    liu(s1, 2)
    muld s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffe000000000000000
    muld s2, s1, s0
    //prgchk reg s2 == 0xffffffffffffffffe000000000000000
    j exit
