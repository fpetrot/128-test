#include "insns.S" 
#include "utils.S"

.section .data
    big1:   .octa 0xffffffffffff543210fedcba98765433
    big2:   .octa 0x55fbabad285eb8bfde577df24a0c25b3
    big3:   .octa 0xffffffffffedcba9876f543210543211
    maxval: .octa 0xffffffffffffffffffffffffffffffff

.section .text.init,"ax",@progbits
.global _start
_start:
    // Small, positive result 
    li t0, 3
    li t1, 7
    mulh t2, t0, t1
    //prgchk reg t2 == 0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0

    // Small, negative result
    la t0, big1
    lq(t0, 0, t0)

    liu(t1, 358)
    mulh t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffff
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff

    // Big, negative result
    la t1, big2
    lq(t1, 0, t1)

    mulh t2, t0, t1
    //prgchk reg t2 == 0xb98485445a4bdc56
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffc64b

    // Big, positive result (neg * neg)
    la t1, big3
    lq(t1, 0, t1)

    mulh t2, t0, t1
    //prgchk reg t2 == 0xc379aaab8
    srli(t2, t2, 64)
    //prgchk reg t2 == 0

    // -1 * 1
    li t0, 1
    li t1, -1
    mulh t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffff
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff

    // Max unsigned value squared : -1^2.
    la t0, maxval
    lq(t0, 0, t0)

    mulh t1, t0, t0
    //prgchk reg t1 == 0
    srli(t1, t1, 64)
    //prgchk reg t1 == 0
    j exit
