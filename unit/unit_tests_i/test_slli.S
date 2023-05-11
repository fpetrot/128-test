#include "insns.S" 
#include "utils.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Shifting all bits out through the left.
    li t0, 0xffffffffffffffff
    slli(t0, t0, 64)
    slli(t0, t0, 64)
    //prgck reg t0 == 0
    srli(t0, t0, 64)
    srli(t0, t0, 64)
    //prgck reg t0 == 0

    // Max shift amount (7 bits => 127 max shift)
    li t0, 0xffffffffffffffff
    slli(t0, t0, 127)
    //prgchk reg t0 == 0
    srli(t0, t0, 64)
    //prchk reg t0 == 0x8000000000000000

    // Check left shifts from 0 to 64 on lower 64 bits.
    li t0, 0xfedcba9876543210
    //prgcheck reg t0 == 0xfedcba9876543210
    slli(t1, t0, 0)
    //prgcheck reg t1 == 0xfedcba9876543210
    slli(t1, t0, 1)
    //prgcheck reg t1 == 0xfdb97530eca86420
    slli(t1, t0, 2)
    //prgcheck reg t1 == 0xfb72ea61d950c840
    slli(t1, t0, 3)
    //prgcheck reg t1 == 0xf6e5d4c3b2a19080
    slli(t1, t0, 4)
    //prgcheck reg t1 == 0xedcba98765432100
    slli(t1, t0, 5)
    //prgcheck reg t1 == 0xdb97530eca864200
    slli(t1, t0, 6)
    //prgcheck reg t1 == 0xb72ea61d950c8400
    slli(t1, t0, 7)
    //prgcheck reg t1 == 0x6e5d4c3b2a190800
    slli(t1, t0, 8)
    //prgcheck reg t1 == 0xdcba987654321000
    slli(t1, t0, 9)
    //prgcheck reg t1 == 0xb97530eca8642000
    slli(t1, t0, 10)
    //prgcheck reg t1 == 0x72ea61d950c84000
    slli(t1, t0, 11)
    //prgcheck reg t1 == 0xe5d4c3b2a1908000
    slli(t1, t0, 12)
    //prgcheck reg t1 == 0xcba9876543210000
    slli(t1, t0, 13)
    //prgcheck reg t1 == 0x97530eca86420000
    slli(t1, t0, 14)
    //prgcheck reg t1 == 0x2ea61d950c840000
    slli(t1, t0, 15)
    //prgcheck reg t1 == 0x5d4c3b2a19080000
    slli(t1, t0, 16)
    //prgcheck reg t1 == 0xba98765432100000
    slli(t1, t0, 17)
    //prgcheck reg t1 == 0x7530eca864200000
    slli(t1, t0, 18)
    //prgcheck reg t1 == 0xea61d950c8400000
    slli(t1, t0, 19)
    //prgcheck reg t1 == 0xd4c3b2a190800000
    slli(t1, t0, 20)
    //prgcheck reg t1 == 0xa987654321000000
    slli(t1, t0, 21)
    //prgcheck reg t1 == 0x530eca8642000000
    slli(t1, t0, 22)
    //prgcheck reg t1 == 0xa61d950c84000000
    slli(t1, t0, 23)
    //prgcheck reg t1 == 0x4c3b2a1908000000
    slli(t1, t0, 24)
    //prgcheck reg t1 == 0x9876543210000000
    slli(t1, t0, 25)
    //prgcheck reg t1 == 0x30eca86420000000
    slli(t1, t0, 26)
    //prgcheck reg t1 == 0x61d950c840000000
    slli(t1, t0, 27)
    //prgcheck reg t1 == 0xc3b2a19080000000
    slli(t1, t0, 28)
    //prgcheck reg t1 == 0x8765432100000000
    slli(t1, t0, 29)
    //prgcheck reg t1 == 0xeca864200000000
    slli(t1, t0, 30)
    //prgcheck reg t1 == 0x1d950c8400000000
    slli(t1, t0, 31)
    //prgcheck reg t1 == 0x3b2a190800000000
    slli(t1, t0, 32)
    //prgcheck reg t1 == 0x7654321000000000
    slli(t1, t0, 33)
    //prgcheck reg t1 == 0xeca8642000000000
    slli(t1, t0, 34)
    //prgcheck reg t1 == 0xd950c84000000000
    slli(t1, t0, 35)
    //prgcheck reg t1 == 0xb2a1908000000000
    slli(t1, t0, 36)
    //prgcheck reg t1 == 0x6543210000000000
    slli(t1, t0, 37)
    //prgcheck reg t1 == 0xca86420000000000
    slli(t1, t0, 38)
    //prgcheck reg t1 == 0x950c840000000000
    slli(t1, t0, 39)
    //prgcheck reg t1 == 0x2a19080000000000
    slli(t1, t0, 40)
    //prgcheck reg t1 == 0x5432100000000000
    slli(t1, t0, 41)
    //prgcheck reg t1 == 0xa864200000000000
    slli(t1, t0, 42)
    //prgcheck reg t1 == 0x50c8400000000000
    slli(t1, t0, 43)
    //prgcheck reg t1 == 0xa190800000000000
    slli(t1, t0, 44)
    //prgcheck reg t1 == 0x4321000000000000
    slli(t1, t0, 45)
    //prgcheck reg t1 == 0x8642000000000000
    slli(t1, t0, 46)
    //prgcheck reg t1 == 0xc84000000000000
    slli(t1, t0, 47)
    //prgcheck reg t1 == 0x1908000000000000
    slli(t1, t0, 48)
    //prgcheck reg t1 == 0x3210000000000000
    slli(t1, t0, 49)
    //prgcheck reg t1 == 0x6420000000000000
    slli(t1, t0, 50)
    //prgcheck reg t1 == 0xc840000000000000
    slli(t1, t0, 51)
    //prgcheck reg t1 == 0x9080000000000000
    slli(t1, t0, 52)
    //prgcheck reg t1 == 0x2100000000000000
    slli(t1, t0, 53)
    //prgcheck reg t1 == 0x4200000000000000
    slli(t1, t0, 54)
    //prgcheck reg t1 == 0x8400000000000000
    slli(t1, t0, 55)
    //prgcheck reg t1 == 0x800000000000000
    slli(t1, t0, 56)
    //prgcheck reg t1 == 0x1000000000000000
    slli(t1, t0, 57)
    //prgcheck reg t1 == 0x2000000000000000
    slli(t1, t0, 58)
    //prgcheck reg t1 == 0x4000000000000000
    slli(t1, t0, 59)
    //prgcheck reg t1 == 0x8000000000000000
    slli(t1, t0, 60)
    //prgcheck reg t1 == 0x0
    slli(t1, t0, 61)
    //prgcheck reg t1 == 0x0
    slli(t1, t0, 62)
    //prgcheck reg t1 == 0x0
    slli(t1, t0, 63)
    //prgcheck reg t1 == 0x0
    j exit
