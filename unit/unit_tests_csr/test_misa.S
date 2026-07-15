#include "insns.S" 
#include "utils.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Check RV128 is running
    csrr s0, misa
    srli s1, s0, 12
    //prgchk reg s1 == 3

    csrrs s0, misa, zero

    // Check flag I set.
    liu(s1, 1)
    slli s1, s1, 8
    and s2, s0, s1
    //prgchk reg s2 != 0

    // Check flag M set.
    liu(s1, 1)
    slli s1, s1, 12
    and s2, s0, s1
    //prgchk reg s2 != 0

    // Check flag E NOT set, since we should be in RV128I mode.
    liu(s1, 1)
    slli s1, s1, 4
    and s2, s0, s1
    //prgchk reg s2 == 0

    // Check reserved bits are zero (B, J, K, L, O, R, T, V, W, Y, Z), may need to be changed if those are used later.
    liu(s1, 1)
    slli s1, s1, 1
    and s2, s0, s1
    //prgchk reg s2 == 0

    liu(s1, 1)
    slli s1, s1, 9
    and s2, s0, s1
    //prgchk reg s2 == 0

    liu(s1, 1)
    slli s1, s1, 10
    and s2, s0, s1
    //prgchk reg s2 == 0

    liu(s1, 1)
    slli s1, s1, 11
    and s2, s0, s1
    //prgchk reg s2 == 0

    liu(s1, 1)
    slli s1, s1, 14
    and s2, s0, s1
    //prgchk reg s2 == 0

    liu(s1, 1)
    slli s1, s1, 15
    and s2, s0, s1
    //prgchk reg s2 == 0

    liu(s1, 1)
    slli s1, s1, 17
    and s2, s0, s1
    //prgchk reg s2 == 0

    liu(s1, 1)
    slli s1, s1, 19
    and s2, s0, s1
    //prgchk reg s2 == 0

    liu(s1, 1)
    slli s1, s1, 21
    and s2, s0, s1
    //prgchk reg s2 == 0

    liu(s1, 1)
    slli s1, s1, 22
    and s2, s0, s1
    //prgchk reg s2 == 0

    liu(s1, 1)
    slli s1, s1, 24
    and s2, s0, s1
    //prgchk reg s2 == 0

    liu(s1, 1)
    slli s1, s1, 25
    and s2, s0, s1
    //prgchk reg s2 == 0
    j exit
