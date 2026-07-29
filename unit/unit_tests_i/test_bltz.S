#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Check comparison is actually signed.
    li s0, -666
    bltz s0, 1f

    //prgchk err
    nop
1:
    // Check comparison is actually signed.
    li s0, 13
    bltz s0, all_err

    // Well, just the upper bit set
    li s0, 0x80000000000000000000000000000000
    bltz s0, 1f

    //prgchk err
    nop
1:
    // Well, just the upper bit not set
    li s0, 0x7fffffffffffffffffffffffffffffff
    bltz s0, all_err

    // Compare with zero, to finish with
    li s0, 0
    bltz s0, all_err

    j exit

all_err:
    //prgchk err
    nop
