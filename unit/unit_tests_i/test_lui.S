#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:    
    // Check sign extension to 128-bits.
    lui s0, 0x80000
    //prgchk reg s0 == 0xffffffffffffffffffffffff80000000

    lui s0, 0x70000
    //prgchk reg s0 == 0x00000000000000000000000070000000

    // Load max value 0xfffff
    lui s3, 0xfffff
    //prgchk reg s3 == 0xfffffffffffffffffffffffffffff000

    // Load garbage and then lui 0, check if zeroed correctly.
    li s0, 0xffffffffffffffffffffffffffffffff

    lui s0, 0
    //prgchk reg s0 == 0

    // Load a few random values
    lui s1, 0x12345
    //prgchk reg s1 == 0x00000000000000000000000012345000

    lui s2, 1
    //prgchk reg s2 == 0x00000000000000000000000000001000

    // Check no-op on zero
    lui zero, 0xfffff
    //prgchk reg zero == 0
    j exit
