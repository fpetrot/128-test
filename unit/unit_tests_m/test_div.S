#include "insns.S" 
#include "utils.S"

.section .data
    minsigned: .octa 0x80000000000000000000000000000000
    maxsigned: .octa 0x7fffffffffffffffffffffffffffffff
    bigpos:    .octa 0x02a9ecc5731f44dc1ca96c45bf8f0a73
    bigneg:    .octa 0xc1ccc8c9241b6c162df95af70f44ab38
    big1:      .octa 0x12ac4fbab56a8e2f3abf62cf9bea2755
    big2:      .octa 0x7eb2989c668be9406b8745fa
    big3:      .octa 0x77d45ce1cd8ef7b2
    big4:      .octa 0x63aba2da

.section .text.init,"ax",@progbits
.global _start
_start:
    // Check trucature towards 0
    li s0, 3
    li s1, -2
    div s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffffff


    // Check signedness of division.
    li s0, -2048
    li s1, -1
    div s2, s0, s1
    //prgchk reg s2 == 2048

    // Check division of lowest signed value (no overflow).
    la s0, minsigned
    lq s0, 0(s0)

    li s1, 2

    div s2, s0, s1
    //prgchk reg s2 == 0xc0000000000000000000000000000000


    // Check overflow behavior (min value / -1)
    li s1, -1

    div s2, s0, s1
    //prgchk reg s2 == 0x80000000000000000000000000000000


    // Check div by zero behavior
    liu(s1, 0)
    
    div s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffff


    // Check various big divisions.
    la s0, bigneg
    lq s0, 0(s0)

    la s1, bigpos
    lq s1, 0(s1)

    div s2, s0, s1
    //prgchk reg s2 == 0xffffffffffffffffffffffffffffffe9


    // Check various divisor sizes.
    lqg(s0, big1)
    lqg(s1, big2)
    div s2, s0, s1
    //prgchk reg s2 == 0x25bae629
 

    lqg(s1, big3)
    div s2, s0, s1


    lqg(s1, big4)
    div s2, s0, s1
    //prgchk reg s2 == 0x2ff60f26e1ccda1e0ae1e9dc

    // Check a few small divisions.
    li s0, 37
    li s1, 5
    div s2, s0, s1
    //prgchk reg s2 == 7


    li s0, 2879
    li s1, 42
    div s2, s0, s1
    //prgchk reg s2 == 68


    li s0, 1234567
    li s1, 98
    div s2, s0, s1
    //prgchk reg s2 == 12597

    j exit
