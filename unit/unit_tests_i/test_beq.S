#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Basic test of non equal values.
    li s0, 0x26bf5f56d85c76ce7141e1c7d71b77d0
    li s1, 0xafb8c0b4f3e85dc236d4f35bb6e1f175

    beq s0, s1, all_err

    // Basic test of equal values.
    li s0, 0xafb8c0b4f3e85dc236d4f35bb6e1f175
    li s1, 0xafb8c0b4f3e85dc236d4f35bb6e1f175

    beq s0, s1, after_tst1

    //prgchk err
    nop

after_tst1:
    // Check if upper 64 bits are compared
    li s0, 0xdf9a9c04623568cd0000000000000000
    li s1, 0x72679b604129a5b80000000000000000

    beq s0, s1, all_err

    li s1, 0xdf9a9c04623568cd0000000000000000
    beq s0, s1, after_tst2

    //prgchk err
    nop
    
after_tst2:
    // Check equals with x0
    li s0, 0
    
    beq s0, zero, after_tst3

    //prgchk err
    nop

after_tst3:
    j exit

all_err:
    //prgchk err
    nop
