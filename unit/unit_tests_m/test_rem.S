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

    minsgn: .octa 0x80000000000000000000000000000000
    minone: .octa 0xffffffffffffffffffffffffffffffff

.section .text.init,"ax",@progbits
.global _start
_start:
    la t0, big1
    lq(t0, 0, t0)

    la t1, big2
    lq(t1, 0, t1)

    rem t2, t0, t1
    //prgchk reg t2 == 0x7b18ad49488b569a
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x40ff

    // Check trucature towards 0
    li t0, 3
    li t1, -2
    rem t2, t0, t1
    //prgchk reg t2 == 1
    srli(t2, t2, 64)
    //prgchk reg t2 == 0

    // Check signedness of division.
    li t0, -2048
    li t1, -1
    rem t2, t0, t1
    //prgchk reg t2 == 0

    // Check different divisor sizes
    lqg(t0, big4)

    lqg(t1, div1)
    rem t2, t0, t1
    //prgchk reg t2 == 0xffffffff9fb7bfc2
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff

    lqg(t1, div2)
    rem t2, t0, t1
    //prgchk reg t2 == 0x0241c351efac54ae
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff

    lqg(t1, div3)
    rem t2, t0, t1
    //prgchk reg t2 == 0xbf6056b034ce3f72
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xfffffffffcb69b69

    lqg(t1, div4)
    rem t2, t0, t1
    //prgchk reg t2 == 0x6034e4b6c81ebfcc
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xcf3e53431e02fa94

    // Check div by zero behavior
    liu(t1, 0)
    rem t2, t0, t1
    //prgchk reg t2 == 0x6034e4b6c81ebfcc
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xcf3e53431e02fa94

    // Check overflow behavior.
    lqg(t0, minsgn)
    lqg(t1, minone)
    rem t2, t0, t1
    //prgchk reg t2 == 0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0
    j exit
