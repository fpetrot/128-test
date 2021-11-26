#include "insns.S" 
#include "utils.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Test signext to 128 bits
    liu(t0, 0x80000000)
    addiw t0, t0, 0
    //prgchk reg t0 == 0xffffffff80000000
    srli(t0, t0, 64)
    //prgchk reg t0 == 0xffffffffffffffff

    // Test basic addition's result (no overflow)
    liu(t0, 0x1dcd8c46)
    addiw t0, t0, 1984
    //prgchk reg t0 == 0x1dcd9406
    srli(t0, t0, 64)
    //prgchk reg t0 == 0

    // Test basic addition's result (that overflows in bit 33)
    liu(t0, 0xfffffffe)
    addiw t0, t0, 2047
    //prgchk reg t0 == 0x000007fd
    srli(t0, t0, 64)
    //prgchk reg t0 == 0

    // Addition with overflow into sign bit.
    liu(t0, 0x7fffffff)
    addiw t0, t0, 1
    //prgchk reg t0 == 0xffffffff80000000
    srli(t0, t0, 64)
    //prgchk reg t0 == 0xffffffffffffffff
    j exit
