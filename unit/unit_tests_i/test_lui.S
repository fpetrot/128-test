#include "insns.S" 
#include "utils.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Check sign extension to 64 bits.
    lui t0, 0x80000
    //prgchk reg t0 == 0xffffffff80000000
    // Check sign extension to 128-bits.
    srli(t1, t0, 64)
    //prgchk reg t1 == 0xffffffffffffffff

    lui t0, 0x70000
    //prgchk reg t0 == 0x0000000070000000
    srli(t1, t0, 64)
    //prgchk reg t1 == 0 

    // Load max value 0xfffff
    lui t3, 0xfffff
    //prgchk reg t3 == 0xfffffffffffff000
    srli(t4, t3, 64)
    //prgchk reg t4 == 0xffffffffffffffff

    // Load garbage and then lui 0, check if zeroed correctly.
    liu(t0, 0xffffffffffffffff)
    slli(t0, t0, 64)
    liu(t1, 0xffffffffffffffff)
    or t0, t0, t1

    lui t0, 0
    //prgchk reg t0 == 0
    srli(t0, t0, 64)
    //prgchk reg t0 == 0

    // Load a few random values
    lui t1, 0x12345
    //prgchk reg t1 == 0x0000000012345000
    srli(t1, t1, 64)
    //prgchk reg t1 == 0

    lui t2, 1
    //prgchk reg t2 == 0x0000000000001000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0

    // Check no-op on zero
    lui zero, 0xfffff
    //prgchk reg zero == 0
    srli(t0, zero, 64)
    //prgchk reg t0 == 0
    j exit
