#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Shifting all bits out through the left.
    li t0, 0xffffffffffffffff
    slli t0, t0, 127
    //prgck reg t0 == 0
    srli t0, t0, 127
    //prgck reg t0 == 0

    // Max shift amount (7 bits => 127 max shift)
    li t0, 0xffffffffffffffffffffffffffffffff
    slli t0, t0, 127
    //prgchk reg t0 == 0x80000000000000000000000000000000

    // Check left shifts from 0 to 64 on lower 64 bits.
    li t0, 0xfedcba9876543210
    slli t1, t0, 0
    //prgchk reg t1 == 0x0000000000000000fedcba9876543210
    slli t1, t0, 1
    //prgchk reg t1 == 0x0000000000000001fdb97530eca86420
    slli t1, t0, 2
    //prgchk reg t1 == 0x0000000000000003fb72ea61d950c840
    slli t1, t0, 3
    //prgchk reg t1 == 0x0000000000000007f6e5d4c3b2a19080
    slli t1, t0, 4
    //prgchk reg t1 == 0x000000000000000fedcba98765432100
    slli t1, t0, 5
    //prgchk reg t1 == 0x000000000000001fdb97530eca864200
    slli t1, t0, 6
    //prgchk reg t1 == 0x000000000000003fb72ea61d950c8400
    slli t1, t0, 7
    //prgchk reg t1 == 0x000000000000007f6e5d4c3b2a190800
    slli t1, t0, 8
    //prgchk reg t1 == 0x00000000000000fedcba987654321000
    slli t1, t0, 9
    //prgchk reg t1 == 0x00000000000001fdb97530eca8642000
    slli t1, t0, 10
    //prgchk reg t1 == 0x00000000000003fb72ea61d950c84000
    slli t1, t0, 11
    //prgchk reg t1 == 0x00000000000007f6e5d4c3b2a1908000
    slli t1, t0, 12
    //prgchk reg t1 == 0x0000000000000fedcba9876543210000
    slli t1, t0, 13
    //prgchk reg t1 == 0x0000000000001fdb97530eca86420000
    slli t1, t0, 14
    //prgchk reg t1 == 0x0000000000003fb72ea61d950c840000
    slli t1, t0, 15
    //prgchk reg t1 == 0x0000000000007f6e5d4c3b2a19080000
    slli t1, t0, 16
    //prgchk reg t1 == 0x000000000000fedcba98765432100000
    slli t1, t0, 17
    //prgchk reg t1 == 0x000000000001fdb97530eca864200000
    slli t1, t0, 18
    //prgchk reg t1 == 0x000000000003fb72ea61d950c8400000
    slli t1, t0, 19
    //prgchk reg t1 == 0x000000000007f6e5d4c3b2a190800000
    slli t1, t0, 20
    //prgchk reg t1 == 0x00000000000fedcba987654321000000
    slli t1, t0, 21
    //prgchk reg t1 == 0x00000000001fdb97530eca8642000000
    slli t1, t0, 22
    //prgchk reg t1 == 0x00000000003fb72ea61d950c84000000
    slli t1, t0, 23
    //prgchk reg t1 == 0x00000000007f6e5d4c3b2a1908000000
    slli t1, t0, 24
    //prgchk reg t1 == 0x0000000000fedcba9876543210000000
    slli t1, t0, 25
    //prgchk reg t1 == 0x0000000001fdb97530eca86420000000
    slli t1, t0, 26
    //prgchk reg t1 == 0x0000000003fb72ea61d950c840000000
    slli t1, t0, 27
    //prgchk reg t1 == 0x0000000007f6e5d4c3b2a19080000000
    slli t1, t0, 28
    //prgchk reg t1 == 0x000000000fedcba98765432100000000
    slli t1, t0, 29
    //prgchk reg t1 == 0x000000001fdb97530eca864200000000
    slli t1, t0, 30
    //prgchk reg t1 == 0x000000003fb72ea61d950c8400000000
    slli t1, t0, 31
    //prgchk reg t1 == 0x000000007f6e5d4c3b2a190800000000
    slli t1, t0, 32
    //prgchk reg t1 == 0x00000000fedcba987654321000000000
    slli t1, t0, 33
    //prgchk reg t1 == 0x00000001fdb97530eca8642000000000
    slli t1, t0, 34
    //prgchk reg t1 == 0x00000003fb72ea61d950c84000000000
    slli t1, t0, 35
    //prgchk reg t1 == 0x00000007f6e5d4c3b2a1908000000000
    slli t1, t0, 36
    //prgchk reg t1 == 0x0000000fedcba9876543210000000000
    slli t1, t0, 37
    //prgchk reg t1 == 0x0000001fdb97530eca86420000000000
    slli t1, t0, 38
    //prgchk reg t1 == 0x0000003fb72ea61d950c840000000000
    slli t1, t0, 39
    //prgchk reg t1 == 0x0000007f6e5d4c3b2a19080000000000
    slli t1, t0, 40
    //prgchk reg t1 == 0x000000fedcba98765432100000000000
    slli t1, t0, 41
    //prgchk reg t1 == 0x000001fdb97530eca864200000000000
    slli t1, t0, 42
    //prgchk reg t1 == 0x000003fb72ea61d950c8400000000000
    slli t1, t0, 43
    //prgchk reg t1 == 0x000007f6e5d4c3b2a190800000000000
    slli t1, t0, 44
    //prgchk reg t1 == 0x00000fedcba987654321000000000000
    slli t1, t0, 45
    //prgchk reg t1 == 0x00001fdb97530eca8642000000000000
    slli t1, t0, 46
    //prgchk reg t1 == 0x00003fb72ea61d950c84000000000000
    slli t1, t0, 47
    //prgchk reg t1 == 0x00007f6e5d4c3b2a1908000000000000
    slli t1, t0, 48
    //prgchk reg t1 == 0x0000fedcba9876543210000000000000
    slli t1, t0, 49
    //prgchk reg t1 == 0x0001fdb97530eca86420000000000000
    slli t1, t0, 50
    //prgchk reg t1 == 0x0003fb72ea61d950c840000000000000
    slli t1, t0, 51
    //prgchk reg t1 == 0x0007f6e5d4c3b2a19080000000000000
    slli t1, t0, 52
    //prgchk reg t1 == 0x000fedcba98765432100000000000000
    slli t1, t0, 53
    //prgchk reg t1 == 0x001fdb97530eca864200000000000000
    slli t1, t0, 54
    //prgchk reg t1 == 0x003fb72ea61d950c8400000000000000
    slli t1, t0, 55
    //prgchk reg t1 == 0x007f6e5d4c3b2a190800000000000000
    slli t1, t0, 56
    //prgchk reg t1 == 0x00fedcba987654321000000000000000
    slli t1, t0, 57
    //prgchk reg t1 == 0x01fdb97530eca8642000000000000000
    slli t1, t0, 58
    //prgchk reg t1 == 0x03fb72ea61d950c84000000000000000
    slli t1, t0, 59
    //prgchk reg t1 == 0x07f6e5d4c3b2a1908000000000000000
    slli t1, t0, 60
    //prgchk reg t1 == 0x0fedcba9876543210000000000000000
    slli t1, t0, 61
    //prgchk reg t1 == 0x1fdb97530eca86420000000000000000
    slli t1, t0, 62
    //prgchk reg t1 == 0x3fb72ea61d950c840000000000000000
    slli t1, t0, 63
    //prgchk reg t1 == 0x7f6e5d4c3b2a19080000000000000000
    slli t1, t0, 64
    //prgchk reg t1 == 0xfedcba98765432100000000000000000
    slli t1, t0, 65
    //prgchk reg t1 == 0xfdb97530eca864200000000000000000
    slli t1, t0, 66
    //prgchk reg t1 == 0xfb72ea61d950c8400000000000000000
    slli t1, t0, 67
    //prgchk reg t1 == 0xf6e5d4c3b2a190800000000000000000
    slli t1, t0, 68
    //prgchk reg t1 == 0xedcba987654321000000000000000000
    slli t1, t0, 69
    //prgchk reg t1 == 0xdb97530eca8642000000000000000000
    slli t1, t0, 70
    //prgchk reg t1 == 0xb72ea61d950c84000000000000000000
    slli t1, t0, 71
    //prgchk reg t1 == 0x6e5d4c3b2a1908000000000000000000
    slli t1, t0, 72
    //prgchk reg t1 == 0xdcba9876543210000000000000000000
    slli t1, t0, 73
    //prgchk reg t1 == 0xb97530eca86420000000000000000000
    slli t1, t0, 74
    //prgchk reg t1 == 0x72ea61d950c840000000000000000000
    slli t1, t0, 75
    //prgchk reg t1 == 0xe5d4c3b2a19080000000000000000000
    slli t1, t0, 76
    //prgchk reg t1 == 0xcba98765432100000000000000000000
    slli t1, t0, 77
    //prgchk reg t1 == 0x97530eca864200000000000000000000
    slli t1, t0, 78
    //prgchk reg t1 == 0x2ea61d950c8400000000000000000000
    slli t1, t0, 79
    //prgchk reg t1 == 0x5d4c3b2a190800000000000000000000
    slli t1, t0, 80
    //prgchk reg t1 == 0xba987654321000000000000000000000
    slli t1, t0, 81
    //prgchk reg t1 == 0x7530eca8642000000000000000000000
    slli t1, t0, 82
    //prgchk reg t1 == 0xea61d950c84000000000000000000000
    slli t1, t0, 83
    //prgchk reg t1 == 0xd4c3b2a1908000000000000000000000
    slli t1, t0, 84
    //prgchk reg t1 == 0xa9876543210000000000000000000000
    slli t1, t0, 85
    //prgchk reg t1 == 0x530eca86420000000000000000000000
    slli t1, t0, 86
    //prgchk reg t1 == 0xa61d950c840000000000000000000000
    slli t1, t0, 87
    //prgchk reg t1 == 0x4c3b2a19080000000000000000000000
    slli t1, t0, 88
    //prgchk reg t1 == 0x98765432100000000000000000000000
    slli t1, t0, 89
    //prgchk reg t1 == 0x30eca864200000000000000000000000
    slli t1, t0, 90
    //prgchk reg t1 == 0x61d950c8400000000000000000000000
    slli t1, t0, 91
    //prgchk reg t1 == 0xc3b2a190800000000000000000000000
    slli t1, t0, 92
    //prgchk reg t1 == 0x87654321000000000000000000000000
    slli t1, t0, 93
    //prgchk reg t1 == 0x0eca8642000000000000000000000000
    slli t1, t0, 94
    //prgchk reg t1 == 0x1d950c84000000000000000000000000
    slli t1, t0, 95
    //prgchk reg t1 == 0x3b2a1908000000000000000000000000
    slli t1, t0, 96
    //prgchk reg t1 == 0x76543210000000000000000000000000
    slli t1, t0, 97
    //prgchk reg t1 == 0xeca86420000000000000000000000000
    slli t1, t0, 98
    //prgchk reg t1 == 0xd950c840000000000000000000000000
    slli t1, t0, 99
    //prgchk reg t1 == 0xb2a19080000000000000000000000000
    slli t1, t0, 100
    //prgchk reg t1 == 0x65432100000000000000000000000000
    slli t1, t0, 101
    //prgchk reg t1 == 0xca864200000000000000000000000000
    slli t1, t0, 102
    //prgchk reg t1 == 0x950c8400000000000000000000000000
    slli t1, t0, 103
    //prgchk reg t1 == 0x2a190800000000000000000000000000
    slli t1, t0, 104
    //prgchk reg t1 == 0x54321000000000000000000000000000
    slli t1, t0, 105
    //prgchk reg t1 == 0xa8642000000000000000000000000000
    slli t1, t0, 106
    //prgchk reg t1 == 0x50c84000000000000000000000000000
    slli t1, t0, 107
    //prgchk reg t1 == 0xa1908000000000000000000000000000
    slli t1, t0, 108
    //prgchk reg t1 == 0x43210000000000000000000000000000
    slli t1, t0, 109
    //prgchk reg t1 == 0x86420000000000000000000000000000
    slli t1, t0, 110
    //prgchk reg t1 == 0x0c840000000000000000000000000000
    slli t1, t0, 111
    //prgchk reg t1 == 0x19080000000000000000000000000000
    slli t1, t0, 112
    //prgchk reg t1 == 0x32100000000000000000000000000000
    slli t1, t0, 113
    //prgchk reg t1 == 0x64200000000000000000000000000000
    slli t1, t0, 114
    //prgchk reg t1 == 0xc8400000000000000000000000000000
    slli t1, t0, 115
    //prgchk reg t1 == 0x90800000000000000000000000000000
    slli t1, t0, 116
    //prgchk reg t1 == 0x21000000000000000000000000000000
    slli t1, t0, 117
    //prgchk reg t1 == 0x42000000000000000000000000000000
    slli t1, t0, 118
    //prgchk reg t1 == 0x84000000000000000000000000000000
    slli t1, t0, 119
    //prgchk reg t1 == 0x08000000000000000000000000000000
    slli t1, t0, 120
    //prgchk reg t1 == 0x10000000000000000000000000000000
    slli t1, t0, 121
    //prgchk reg t1 == 0x20000000000000000000000000000000
    slli t1, t0, 122
    //prgchk reg t1 == 0x40000000000000000000000000000000
    slli t1, t0, 123
    //prgchk reg t1 == 0x80000000000000000000000000000000
    slli t1, t0, 124
    //prgchk reg t1 == 0x00000000000000000000000000000000
    slli t1, t0, 125
    //prgchk reg t1 == 0x00000000000000000000000000000000
    slli t1, t0, 126
    //prgchk reg t1 == 0x00000000000000000000000000000000
    j exit
