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
    li t0, 3
    li t1, 7
    mul t2, t0, t1
    //prgchk reg t2 == 21

    // Multiplication two large positive integers.
    la t0, big1
    lq t0, 0(t0)

    la t1, big2
    lq t1, 0(t1)

    mul t2, t0, t1
    //prgchk reg t2 == 0x9594d996781404338780bdfc7bd0b904


    // Check mul by zero
    mov t1, zero
    mul t2, t0, t1
    //prgchk reg t2 == 0


    // -1 squared
    li t0, -1
    li t1, -1
    mul t2, t0, t1
    //prgchk reg t2 == 1


    // -1 times a number
    li t0, -1
    li t1, 42
    mul t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffffffffffffffffffd6

    
    la t0, big3
    lq t0, 0(t0)
    
    li t1, -1
    mul t2, t0, t1
    //prgchk reg t2 == 0xffffffffff543210fedcba9876543211


    la t0, big1
    lq t0, 0(t0)

    la t1, big4
    lq t1, 0(t1)

    mul t2, t0, t1
    //prgchk reg t2 == 0x740c53144fa1da317a92392cadf9aba3


    // Max value squared (or -1^2 if signed).
    la t0, maxval
    lq t0, 0(t0)

    mul t1, t0, t0
    //prgchk reg t1 == 0x00000000000000000000000000000001
    j exit
