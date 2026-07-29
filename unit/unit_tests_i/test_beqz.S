#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Is value non-zero
    li s0, 0x26bf5f56d85c76ce7141e1c7d71b77d0
    beqz s0, all_err

    // Is value non-zero
    li s0, 0xdf9a9c04623568cd0000000000000000
    beqz s0, all_err

    // Is value non-zero
    li s0, 0x00000000000000000000000000000001
    beqz s0, all_err

    // Is value zero, finally ?
    li s0, 0x00000000000000000000000000000000
    
    beqz s0, 1f

    //prgchk err
    nop

1:  j exit

all_err:
    //prgchk err
    nop
