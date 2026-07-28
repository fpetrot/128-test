#include "utils.S"
#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Check RV128 is running
    csrr s0, misa
    srli s1, s0, 126
    //prgchk reg s1 == 3

    // Check UXL and SXL are set to RV128 too
    csrr s0, mstatus
    srli s1, s0, 32
    andi s1, s1, 0xf
    //prgchk reg s1 == 0xf

    // Mark FPU dirty to check for SD
    .equiv   MSTATUS_FS, 0x00006000
    li  s0,  MSTATUS_FS
    csrs     mstatus, s0
    // Do some fun useless computation
    fmadd.s  f3, f2, f1, f0
    fmax.s   f0, f1, f2
    // Check SD has changed where expected
    csrr s0, mstatus
    srli s1, s0, 127
    //prgchk reg s1 == 1
    // Mark FPU clean (2 in FS place)
    li  s0, ~0x00004000
    csrc     mstatus, s0
    csrr s0, mstatus
    srli s1, s0, 13
    andi s1, s1, 3
    //prgchk reg s1 == 2
    j exit
