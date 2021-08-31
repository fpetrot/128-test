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
    li t0, 3
    li t1, -2
    div t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffff
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff

    // Check signedness of division.
    li t0, -2048
    li t1, -1
    div t2, t0, t1
    //prgchk reg t2 == 2048

    // Check division of lowest signed value (no overflow).
    la t0, minsigned
    lq(t0, 0, t0)

    li t1, 2

    div t2, t0, t1
    //prgchk reg t2 == 0x0000000000000000
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xc000000000000000

    // Check overflow behavior (min value / -1)
    li t1, -1

    div t2, t0, t1
    //prgchk reg t2 == 0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x8000000000000000

    // Check div by zero behavior
    liu(t1, 0)
    
    div t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffff
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff

    // Check various big divisions.
    la t0, bigneg
    lq(t0, 0, t0)

    la t1, bigpos
    lq(t1, 0, t1)

    div t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffe9
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff

    // Check various divisor sizes.
    lqg(t0, big1)
    lqg(t1, big2)
    div t2, t0, t1
    //prgchk reg t2 == 0x25bae629
    srli(t2, t2, 64)
    //prgchk reg t2 == 0

    lqg(t1, big3)
    div t2, t0, t1
    //prgchk reg t2 == 0x27e48121461b8189
    srli(t2, t2, 64)
    //prgchk reg t2 == 0

    lqg(t1, big4)
    div t2, t0, t1
    //prgchk reg t2 == 0xe1ccda1e0ae1e9dc
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x2ff60f26

    // Check a few small divisions.
    li t0, 37
    li t1, 5
    div t2, t0, t1
    //prgchk reg t2 == 7
    srli(t2, t2, 64)
    //prgchk reg t2 == 0

    li t0, 2879
    li t1, 42
    div t2, t0, t1
    //prgchk reg t2 == 68
    srli(t2, t2, 64)
    //prgchk reg t2 == 0

    li t0, 1234567
    li t1, 98
    div t2, t0, t1
    //prgchk reg t2 == 12597
    srli(t2, t2, 64)
    //prgchk reg t2 == 0
j exit