#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Is value non-zero (checking both 64-bit words) ?
    li s0, 0x26bf5f56d85c76ce7141e1c7d71b77d0
    bnez s0, 1f

    //prgchk err
    nop
1:
    // Is value non-zero (checking upper 64-bit word) ?
    li s0, 0xdf9a9c04623568cd0000000000000000
    bnez s0, 1f

    //prgchk err
    nop
1:
    // Is value non-zero (checking lower 64-bit word) ?
    li s0, 0x00000000000000000000000000000001
    bnez s0, 1f

    //prgchk err
    nop
1:
    // Is value zero, finally ?
    li s0, 0 
    bnez s0, all_err

    j exit

all_err:
    //prgchk err
    nop
