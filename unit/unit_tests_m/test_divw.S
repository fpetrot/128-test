#include "insns.S" 
#include "utils.S"

.section .rodata
    w1:     .word 0x87654321
    w2:     .word 0x12345678
    w3:     .word 0x42
    w4:     .word 0x78967451
    w5:     .word 0xffffffff
    w6:     .word 0xffffffd6
    minsgn: .word 0x80000000

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Various basic divisions
    lw s0, w1
    lw s1, w2
    divw s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffffffffffa

    divw s2, s1, s0
    //prgchk reg s2 == 0

    lw s1, w3
    divw s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffffe2c3371
    
    // Divide by self.
    divw s2, s0, s0
    //prgchk reg s2 == 1

    // Divide by -1
    lw s0, w1
    lw s1, w5
    divw s2, s0, s1
    //prgchk reg s2 == 0x789abcdf

    lw s0, w4
    divw s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffff87698baf

    lw s0, w6
    divw s2, s0, s1
    //prgchk reg s2 == 42

    // Check overflow behavior.
    lw s0, minsgn
    lw s1, w5
    divw s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffff80000000

    // Check div by zero behavior
    lw s0, w1
    liu(s1, 0)
    divw s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffffff
    j exit
