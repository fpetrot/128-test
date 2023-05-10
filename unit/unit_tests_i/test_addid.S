#include "insns.S" 
#include "utils.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Test sign-extend with 1 
    liu t0, 0xfedcba9876543210
    //prgchk reg t0 == 0x0000000000000000fedcba9876543210
    
    addid t1, t0, 2047
    //prgchk reg t1 == 0xfffffffffffffffffedcba9876543a0f

    liu t0, 0x1234567890abcdef

    addid t1, t0, 2047
    //prgchk reg t1 == 0x00000000000000001234567890abd5ee

    // Minimum negative value
    addid t1, t0, -2048
    //prgchk reg t1 == 0x00000000000000001234567890abc5ef

    // Add zero (sign bit = 0)
    addid t1, t0, 0
    //prgchk reg t1 == 0x00000000000000001234567890abcdef

    // Add zero (sign bit = 1)
    liu t0, 0x8000000000000000

    addid t1, t0, 0
    //prgchk reg t1 == 0xffffffffffffffff8000000000000000

    // No-op when adding to r0
    addid zero, t0, 2047
    //prgchk reg zero == 0
    j exit
