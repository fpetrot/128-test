#include "insns.S" 
#include "utils.S"

.section .data
    big1:   .octa 0x55fbabad285eb8bfde577df24a0c25b3
    big2:   .octa 0x7c4574e203312d7c2eccfc6e195e28ec
    big3:   .octa 0xffffffffffff543210fedcba98765433
    maxval: .octa 0xffffffffffffffffffffffffffffffff
    big4:   .octa 0x1234567890abcdef0000000000000000
    big5:   .octa 0x0000000000000000fedcba0987654321

.section .text.init,"ax",@progbits
.global _start
_start:
    // Test of multiplication of a few large constants.
    lqg(s0, big1)
    lqg(s1, big2)

    mulhu s2, s0, s1
    //prgchk reg s2 == 0x29bd3b3f18443fa32129d92ab00f39f7

    lqg(s0, big4)
    lqg(s1, big5)
    mulhu s2, s0, s1
    //prgchk reg s2 == 0x121fa000a3723a57

    mulhu s2, s0, s0
    //prgchk reg s2 == 0x14b66dc328828bca6475f09a2f2a521

    mulhu s2, s1, s1
    //prgchk reg s2 == 0

    // Multiply large by small (with sign bit one : check unsigned mult).
    lqg(s0, big3)

    li s1, 358
    mulhu s2, s0, s1
    //prgchk reg s2 == 0x165

    // Max value squared
    la s0, maxval
    lq s0, 0(s0)

    mulhu s1, s0, s0
    //prgchk reg s1 == 0xfffffffffffffffffffffffffffffffe
    srli(s1, s1, 64)
    //prgchk reg s1 == 0x

    // Mul by zero absorption
    lqg(s0, big1)
    liu(s1, 0)

    mulhu s2, s0, s1
    //prgchk reg s2 == 0

    // Big value by max value.
    lqg(s0, big1)
    lqg(s1, maxval)

    mulhu s2, s0, s1
    //prgchk reg s2 == 0x55fbabad285eb8bfde577df24a0c25b2

    // Negative * -1, but unsigned upper bits.
    lqg(s0, big3)
    lqg(s1, maxval)
    mulhu s2, s0, s1
    //prgchk reg s2 == 0xffffffffffff543210fedcba98765432
    j exit
