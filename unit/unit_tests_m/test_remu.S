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

    remu t2, t0, t1
    //prgchk reg t2 == 0x7b18ad49488b569a
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x40ff

    // Div by one.
    li t1, 1
    remu t2, t0, t1
    //prgchk reg t2 == 0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0

    // Div by self.
    remu t2, t0, t0
    //prgchk reg t2 == 0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0

    // Divisor > Dividend
    la t0, big3
    lq(t0, 0, t0)

    la t1, big4
    lq(t1, 0, t1)

    remu t2, t0, t1
    //prgchk reg t2 == 0x9a213226c599ce3b
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x2d7154484023d54

    // Simple small division (no remainder)
    liu(t0, 21)
    liu(t1, 3)
    remu t2, t0, t1
    //prgchk reg t2 == 0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0

    liu(t0, 37)
    liu(t1, 5)
    remu t2, t0, t1
    //prgchk reg t2 == 2
    srli(t2, t2, 64)
    //prgchk reg t2 == 0

    // Check different divisor sizes
    la t0, big4
    lq(t0, 0, t0)

    la t1, div1
    lq(t1, 0, t1)
    remu t2, t0, t1
    //prgchk reg t2 == 0x69531fa0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0

    la t1, div2
    lq(t1, 0, t1)
    remu t2, t0, t1
    //prgchk reg t2 == 0x492deca597a8fc57
    srli(t2, t2, 64)
    //prgchk reg t2 == 0

    la t1, div3
    lq(t1, 0, t1)
    remu t2, t0, t1
    //prgchk reg t2 == 0x2790fff455a8b7fa
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x2fda549

    la t1, div4
    lq(t1, 0, t1)
    remu t2, t0, t1
    //prgchk reg t2 == 0x4cfd9075740a9934
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x47d9102172350ae9

    // Check div by zero behavior
    liu(t1, 0)
    remu t2, t0, t1
    //prgchk reg t2 == 0x6034e4b6c81ebfcc
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xcf3e53431e02fa94
    j exit
