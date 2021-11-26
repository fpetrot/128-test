#include "insns.S" 
#include "utils.S"

.section .data
oftest1:   .octa 0x80000000000000000000000000000000
oftest2:   .octa 0x7fffffffffffffffffffffffffffffff

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Check that comparison is actually signed.
    li t0, -1
    slti t1, t0, 38
    //prgchk reg t1 == 1
    srli(t1, t1, 64)
    //prgchk reg t1 == 0

    // Compare with self.
    li t0, 1954
    slti t1, t0, 1954
    //prgchk reg t1 == 0
    srli(t1, t1, 64)
    //prgchk reg t1 == 0

    // Compare max immediate
    li t0, 2000
    slti t1, t0, 2047
    //prgchk reg t1 == 1
    srli(t1, t1, 64)
    //prgchk reg t1 == 0

    li t0, 2058
    slti t1, t0, 2047
    //prgchk reg t1 == 0
    srli(t1, t1, 64)
    //prgchk reg t1 == 0

    // Compare min immediate
    li t0, -2047
    slti t1, t0, -2048
    //prgchk reg t1 == 0
    srli(t1, t1, 64)
    //prgchk reg t1 == 0

    li t0, -2048
    slti t1, t0, -2048
    //prgchk reg t1 == 0
    srli(t1, t1, 64)
    //prgchk reg t1 == 0

    li t0, -2049
    slti t1, t0, -2048
    //prgchk reg t1 == 1
    srli(t1, t1, 64)
    //prgchk reg t1 == 0

    // Test with subtraction overflow (negative - positive -> posituve)
    la t0, oftest1
    lq(t0, 0, t0)
    slti t1, t0, 1
    //prgchk reg t1 == 1
    srli(t1, t1, 64)
    //prgchk reg t1 == 0

    // Test with subtraction overflow (positive - negative -> negative)
    la t0, oftest2
    lq(t0, 0, t0)
    slti t1, t0, -1
    //prgchk reg t1 == 0
    srli(t1, t1, 64)
    //prgchk reg t1 == 0
    j exit
