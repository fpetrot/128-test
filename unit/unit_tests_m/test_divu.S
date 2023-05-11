#include "insns.S" 
#include "utils.S"

.section .data
    big1: .octa 0x7c4574e203312d7c2eccfc6e195e28ec
    big2: .octa 0x123456789abcdefabcdef
    big3: .octa 0x2d7154484023d549a213226c599ce3b
    big4: .octa 0xcf3e53431e02fa946034e4b6c81ebfcc

    div1: .octa 0x000000000000000000000000abcdef12
    div2: .octa 0x0000000000000000fedcba0987654321
    div3: .octa 0x000000001234567842434546787541fe
    div4: .octa 0x87654321abcdefab1337544154142698

.section .text.init,"ax",@progbits
.global _start
_start:
    la t0, big1
    lq(t0, 0, t0)

    la t1, big2
    lq(t1, 0, t1)

    divu t2, t0, t1
    //prgchk reg t2 == 0x6d390bbaa4ce
    srli(t2, t2, 64)
    //prgchk reg t2 == 0

    // Div by one.
    li t1, 1
    divu t2, t0, t1
    //prgchk reg t2 == 0x2eccfc6e195e28ec
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x7c4574e203312d7c

    // Div by self.
    divu t2, t0, t0
    //prgchk reg t2 == 1
    srli(t2, t2, 64)
    //prgchk reg t2 == 0

    // Divison > Dividend
    la t0, big3
    lq(t0, 0, t0)

    la t1, big4
    lq(t1, 0, t1)

    divu t2, t0, t1
    //prgchk reg t2 == 0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0

    // Simple small division (no remainder)
    liu(t0, 21)
    liu(t1, 3)
    divu t2, t0, t1
    //prgchk reg t2 == 7
    srli(t2, t2, 64)
    //prgchk reg t2 == 0

    liu(t0, 37)
    liu(t1, 5)
    divu t2, t0, t1
    //prgchk reg t2 == 7
    srli(t2, t2, 64)
    //prgchk reg t2 == 0

    // Chek different divisor sizes
    la t0, big4
    lq(t0, 0, t0)

    la t1, div1
    lq(t1, 0, t1)
    divu t2, t0, t1
    //prgchk reg t2 == 0x6495d65af81253e6
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x134ce7715

    la t1, div2
    lq(t1, 0, t1)
    divu t2, t0, t1
    //prgchk reg t2 == 0xd02b2d3b9780c9d5
    srli(t2, t2, 64)
    //prgchk reg t2 == 0

    la t1, div3
    lq(t1, 0, t1)
    divu t2, t0, t1
    //prgchk reg t2 == 0xb625c7317
    srli(t2, t2, 64)
    //prgchk reg t2 == 0

    la t1, div4
    lq(t1, 0, t1)
    divu t2, t0, t1
    //prgchk reg t2 == 1
    srli(t2, t2, 64)
    //prgchk reg t2 == 0

    // Check div by zero behavior
    liu(t1, 0)
    divu t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffff
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    j exit
