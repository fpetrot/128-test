#include "insns.S" 
#include "utils.S"

.section .rodata
    big1:   .octa 0x55fbabad285eb8bfde577df24a0c25b3
    big2:   .octa 0x7c4574e203312d7c2eccfc6e195e28ec
    big3:   .octa 0xffffffffffff543210fedcba98765433
    maxval: .octa 0xffffffffffffffffffffffffffffffff
    big4:   .octa 0x1234567890abcdef0000000000000000
    big5:   .octa 0x0000000000000000fedcba0987654321

.section .text.init,"ax",@progbits
.globl _start
_start:
# We're in bare metal, so set stack at the end of physical memory
la      sp, _memory_end
j main

main:
    // Test of multiplication of a few large constants.
    lqg(t0, big1)
    lqg(t1, big2)

    mulhsu t2, t0, t1
    //prgchk reg t2 == 0x2129d92ab00f39f7
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x29bd3b3f18443fa3

    lqg(t0, big4)
    lqg(t1, big5)
    mulhsu t2, t0, t1
    //prgchk reg t2 == 0x121fa000a3723a57
    srli(t2, t2, 64)
    //prgchk reg t2 == 0

    mulhsu t2, t0, t0
    //prgchk reg t2 == 0xa6475f09a2f2a521
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x14b66dc328828bc

    mulhsu t2, t1, t1
    //prgchk reg t2 == 0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0

    // Multiply large by small
    lqg(t0, big3)

    li t1, 358
    mulhsu t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffff
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff

    // Max value squared
    lqg(t0, maxval)

    mulhsu t1, t0, t0
    //prgchk reg t1 == 0xffffffffffffffff
    srli(t1, t1, 64)
    //prgchk reg t1 == 0xffffffffffffffff

    // Mul by zero absorption
    lqg(t0, big1)
    liu(t1, 0)

    mulhsu t2, t0, t1
    //prgchk reg t2 == 0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0

    // Big value by max value.
    lqg(t0, big1)
    lqg(t1, maxval)

    mulhsu t2, t0, t1
    //prgchk reg t2 == 0xde577df24a0c25b2
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x55fbabad285eb8bf

    mulhsu t2, t1, t0
    //prgchk reg t2 == 0xffffffffffffffff
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff

    // Negative * -1.
    lqg(t0, big3)
    lqg(t1, maxval)
    mulhsu t2, t0, t1
    //prgchk reg t2 == 0x10fedcba98765433
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffff5432

    mulhsu t2, t1, t0
    //prgchk reg t2 == 0xffffffffffffffff
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
j exit