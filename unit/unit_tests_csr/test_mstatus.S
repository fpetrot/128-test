#include "insns.S" 
#include "utils.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Check RV128 is running
    csrr t0, misa
    //prgchk reg t1 == 3

    // Check UXL and SXL are set to RV128 too
    csrr t0, mstatus
    andi t1, t1, 0xf
    // Make sure SD is zero
    //prgchk reg t1 == 0x0000000000000000ffffffffffffffff

    // Mark FPU dirty to check for SD
    .equiv   MSTATUS_FS, 0x00006000
    li  t0,  MSTATUS_FS
    csrs     mstatus, t0
    // Do some fun useless computation
    fmadd.s  f3, f2, f1, f0
    fmax.s   f0, f1, f2
    // Check SD has changed where expected
    csrr t0, mstatus
    //prgchk reg t1 == 1
    // Mark FPU clean (2 in FS place)
    li  t0, ~0x00004000
    csrc     mstatus, t0
    csrr t0, mstatus
    //prgchk reg t1 == 0
    j exit
