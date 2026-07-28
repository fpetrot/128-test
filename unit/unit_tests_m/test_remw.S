#include "utils.S"
#include "exit.S"

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
    // Check trucature towards 0
    li s0, 3
    li s1, -2
    remw s2, s0, s1
    //prgchk reg s2 == 1

    // Various basic divisions
    lw s0, w1
    lw s1, w2
    remw s2, s0, s1
    //prgchk reg s2 == 0xfffffffffffffffffffffffff49f49f1

    remw s2, s1, s0
    //prgchk reg s2 == 0x12345678

    lw s1, w3
    remw s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffffff

    // Divide by self.
    remw s2, s0, s0
    //prgchk reg s2 == 0

    // Divide by -1
    lw s0, w1
    lw s1, w5
    remw s2, s0, s1
    //prgchk reg s2 == 0

    lw s0, w4
    remw s2, s0, s1
    //prgchk reg s2 == 0

    lw s0, w6
    remw s2, s0, s1
    //prgchk reg s2 == 0

    // Check overflow behavior.
    lw s0, minsgn
    lw s1, w5
    remw s2, s0, s1
    //prgchk reg s2 == 0

    // Check div by zero behavior
    lw s0, w1
    liu(s1, 0)
    remw s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffff87654321
    j exit
