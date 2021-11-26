#include "insns.S" 
#include "utils.S"

.section .data
    val1: .octa 0x26bf5f56d85c76ce7141e1c7d71b77d0
    val2: .octa 0xafb8c0b4f3e85dc236d4f35bb6e1f175
    val3: .octa 0xdf9a9c04623568cd0000000000000000
    val4: .octa 0x72679b604129a5b80000000000000000

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Basic test of non equal values.
    la t0, val1
    lq(t0, 0, t0)

    la t1, val2
    lq(t1, 0, t1)

    beq t0, t1, all_err

    // Basic test of equal values.
    la t0, val2
    lq(t0, 0, t0)

    la t1, val2
    lq(t1, 0, t1)

    beq t0, t1, after_tst1

    //prgchk err
    nop

after_tst1:
    // Check if upper 64 bits are compared
    la t0, val3
    lq(t0, 0, t0)

    la t1, val4
    lq(t1, 0, t1)

    beq t0, t1, all_err

    la t1, val3
    lq(t1, 0, t1)

    beq t0, t1, after_tst2

    //prgchk err
    nop
    
after_tst2:
    // Check equals with x0
    li t0, 0
    
    beq t0, zero, after_tst3

    //prgchk err
    nop

after_tst3:
    j exit

all_err:
    //prgchk err
    nop
