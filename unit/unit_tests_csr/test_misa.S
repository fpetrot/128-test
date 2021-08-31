#include "insns.S" 
#include "utils.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
# We're in bare metal, so set stack at the end of physical memory
la      sp, _memory_end
j main

main:
    csrrs t0, misa, zero

    // Check flag I set.
    liu(t1, 1)
    slli t1, t1, 8
    and t2, t0, t1
    //prgchk reg t2 != 0

    // Check flag M set.
    liu(t1, 1)
    slli t1, t1, 12
    and t2, t0, t1
    //prgchk reg t2 != 0

    // Check flag E NOT set, since we should be in RV128I mode.
    liu(t1, 1)
    slli t1, t1, 4
    and t2, t0, t1
    //prgchk reg t2 == 0

    // Check reserved bits are zero (B, J, K, L, O, R, T, V, W, Y, Z), may need to be changed if those are used later.
    liu(t1, 1)
    slli t1, t1, 1
    and t2, t0, t1
    //prgchk reg t2 == 0

    liu(t1, 1)
    slli t1, t1, 9
    and t2, t0, t1
    //prgchk reg t2 == 0

    liu(t1, 1)
    slli t1, t1, 10
    and t2, t0, t1
    //prgchk reg t2 == 0

    liu(t1, 1)
    slli t1, t1, 11
    and t2, t0, t1
    //prgchk reg t2 == 0

    liu(t1, 1)
    slli t1, t1, 14
    and t2, t0, t1
    //prgchk reg t2 == 0

    liu(t1, 1)
    slli t1, t1, 15
    and t2, t0, t1
    //prgchk reg t2 == 0

    liu(t1, 1)
    slli t1, t1, 17
    and t2, t0, t1
    //prgchk reg t2 == 0

    liu(t1, 1)
    slli t1, t1, 19
    and t2, t0, t1
    //prgchk reg t2 == 0

    liu(t1, 1)
    slli t1, t1, 21
    and t2, t0, t1
    //prgchk reg t2 == 0

    liu(t1, 1)
    slli t1, t1, 22
    and t2, t0, t1
    //prgchk reg t2 == 0

    liu(t1, 1)
    slli t1, t1, 24
    and t2, t0, t1
    //prgchk reg t2 == 0

    liu(t1, 1)
    slli t1, t1, 25
    and t2, t0, t1
    //prgchk reg t2 == 0
j exit