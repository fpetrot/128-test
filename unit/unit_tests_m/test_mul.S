#include "insns.S" 
#include "utils.S"

.section .data
    big1:   .octa 0x55fbabad285eb8bfde577df24a0c25b3
    big2:   .octa 0x7c4574e203312d7c2eccfc6e195e28ec
    big3:   .octa 0xabcdef0123456789abcdef
    big4:   .octa 0x8765432158978abcdef445d8e7d44a51
    maxval: .octa 0xffffffffffffffffffffffffffffffff

.section .text.init,"ax",@progbits
.global _start
_start:
    // Small trivial multiplication.
    li s0, 3
    li s1, 7
    mul s2, s0, s1
    //prgchk reg s2 == 21

    // Multiplication two large positive integers.
    la s0, big1
    lq s0, 0(s0)

    la s1, big2
    lq s1, 0(s1)

    mul s2, s0, s1
    //prgchk reg s2 == 0x9594d996781404338780bdfc7bd0b904


    // Check mul by zero
    mov s1, zero
    mul s2, s0, s1
    //prgchk reg s2 == 0


    // -1 squared
    li s0, -1
    li s1, -1
    mul s2, s0, s1
    //prgchk reg s2 == 1


    // -1 times a number
    li s0, -1
    li s1, 42
    mul s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffffd6

    
    la s0, big3
    lq s0, 0(s0)
    
    li s1, -1
    mul s2, s0, s1
    //prgchk reg s2 == 0xffffffffff543210fedcba9876543211


    la s0, big1
    lq s0, 0(s0)

    la s1, big4
    lq s1, 0(s1)

    mul s2, s0, s1
    //prgchk reg s2 == 0x740c53144fa1da317a92392cadf9aba3


    // Max value squared (or -1^2 if signed).
    la s0, maxval
    lq s0, 0(s0)

    mul s1, s0, s0
    //prgchk reg s1 == 0x00000000000000000000000000000001
    j exit
