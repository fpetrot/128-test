#include "insns.S" 
#include "utils.S"

.section .rodata
    d1:        .dword 0x1234567890abcdef
    d2:        .dword 0xfedcba0987654321
    minusone:  .dword 0xffffffffffffffff
    d3:        .dword 0xffffffffffffffd6
    d4:        .dword 0x7000000000000000

.section .text.init,"ax",@progbits
.globl _start
_start:
    ld t0, d1
    ld t1, d2
    muld t2, t0, t1
    //prgchk reg t2 == 0xc24a442fe55618cf
    muld t2, t1, t0
    //prgchk reg t2 == 0xffffffffffffffffc24a442fe55618cf

    ld t0, d2
    ld t1, minusone
    muld t2, t0, t1
    //prgchk reg t2 == 0x012345f6789abcdf

    ld t0, minusone
    ld t1, d3
    muld t2, t0, t1
    //prgchk reg t2 == 42

    ld t0, minusone
    muld t2, t0, t0
    //prgchk reg t2 == 1

    // test sign extension
    ld t0, d4
    liu(t1, 2)
    muld t2, t0, t1
    //prgchk reg t2 == 0xe000000000000000
    muld t2, t1, t0
    //prgchk reg t2 == 0xffffffffffffffffe000000000000000
    j exit
