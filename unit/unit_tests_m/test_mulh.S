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
    li s0, 3
    li s1, 7
    mulh s2, s0, s1
    //prgchk reg s2 == 0
    srli(s2, s2, 64)
    //prgchk reg s2 == 0

    // Small, negative result
    la s0, big1
    lq s0, 0(s0)

    liu(s1, 358)
    mulh s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffffff

    // Big, negative result
    la s1, big2
    lq s1, 0(s1)

    mulh s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffc64bb98485445a4bdc56

    // Big, positive result (neg * neg)
    la s1, big3
    lq s1, 0(s1)

    mulh s2, s0, s1
    //prgchk reg s2 == 0xc379aaab8

    // -1 * 1
    li s0, 1
    li s1, -1
    mulh s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffffff

    // Max unsigned value squared : -1^2.
    la s0, maxval
    lq s0, 0(s0)

    mulh s1, s0, s0
    //prgchk reg s1 == 0
    srli(s1, s1, 64)
    //prgchk reg s1 == 0x
    j exit
