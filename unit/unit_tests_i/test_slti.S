#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Check that comparison is actually signed.
    li s0, -1
    slti s1, s0, 38
    //prgchk reg s1 == 1


    // Compare with self.
    li s0, 1954
    slti s1, s0, 1954
    //prgchk reg s1 == 0


    // Compare max immediate
    li s0, 2000
    slti s1, s0, 2047
    //prgchk reg s1 == 1


    li s0, 2058
    slti s1, s0, 2047
    //prgchk reg s1 == 0


    // Compare min immediate
    li s0, -2047
    slti s1, s0, -2048
    //prgchk reg s1 == 0


    li s0, -2048
    slti s1, s0, -2048
    //prgchk reg s1 == 0


    li s0, -2049
    slti s1, s0, -2048
    //prgchk reg s1 == 1


    // Test with subtraction overflow (negative - positive -> positive)
    li s0, 0x80000000000000000000000000000000
    //prgchk reg s0 == 0x80000000000000000000000000000000

    slti s1, s0, 1
    //prgchk reg s1 == 1


    // Test with subtraction overflow (positive - negative -> negative)
    li s0, 0x7fffffffffffffffffffffffffffffff
    //prgchk reg s0 == 0x7fffffffffffffffffffffffffffffff

    slti s1, s0, -1
    //prgchk reg s1 == 0

    j exit
