#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Shifting all bits out through the left.
    li s0, 0xffffffffffffffff
    slli s0, s0, 127
    //prgck reg s0 == 0
    srli s0, s0, 127
    //prgck reg s0 == 0

    // Max shift amount (7 bits => 127 max shift)
    li s0, 0xffffffffffffffffffffffffffffffff
    slli s0, s0, 127
    //prgchk reg s0 == 0x80000000000000000000000000000000

    // Check left shifts from 0 to 64 on lower 64 bits.
    li s0, 0xfedcba9876543210
    slli s1, s0, 0
    //prgchk reg s1 == 0x0000000000000000fedcba9876543210
    slli s1, s0, 1
    //prgchk reg s1 == 0x0000000000000001fdb97530eca86420
    slli s1, s0, 2
    //prgchk reg s1 == 0x0000000000000003fb72ea61d950c840
    slli s1, s0, 3
    //prgchk reg s1 == 0x0000000000000007f6e5d4c3b2a19080
    slli s1, s0, 4
    //prgchk reg s1 == 0x000000000000000fedcba98765432100
    slli s1, s0, 5
    //prgchk reg s1 == 0x000000000000001fdb97530eca864200
    slli s1, s0, 6
    //prgchk reg s1 == 0x000000000000003fb72ea61d950c8400
    slli s1, s0, 7
    //prgchk reg s1 == 0x000000000000007f6e5d4c3b2a190800
    slli s1, s0, 8
    //prgchk reg s1 == 0x00000000000000fedcba987654321000
    slli s1, s0, 9
    //prgchk reg s1 == 0x00000000000001fdb97530eca8642000
    slli s1, s0, 10
    //prgchk reg s1 == 0x00000000000003fb72ea61d950c84000
    slli s1, s0, 11
    //prgchk reg s1 == 0x00000000000007f6e5d4c3b2a1908000
    slli s1, s0, 12
    //prgchk reg s1 == 0x0000000000000fedcba9876543210000
    slli s1, s0, 13
    //prgchk reg s1 == 0x0000000000001fdb97530eca86420000
    slli s1, s0, 14
    //prgchk reg s1 == 0x0000000000003fb72ea61d950c840000
    slli s1, s0, 15
    //prgchk reg s1 == 0x0000000000007f6e5d4c3b2a19080000
    slli s1, s0, 16
    //prgchk reg s1 == 0x000000000000fedcba98765432100000
    slli s1, s0, 17
    //prgchk reg s1 == 0x000000000001fdb97530eca864200000
    slli s1, s0, 18
    //prgchk reg s1 == 0x000000000003fb72ea61d950c8400000
    slli s1, s0, 19
    //prgchk reg s1 == 0x000000000007f6e5d4c3b2a190800000
    slli s1, s0, 20
    //prgchk reg s1 == 0x00000000000fedcba987654321000000
    slli s1, s0, 21
    //prgchk reg s1 == 0x00000000001fdb97530eca8642000000
    slli s1, s0, 22
    //prgchk reg s1 == 0x00000000003fb72ea61d950c84000000
    slli s1, s0, 23
    //prgchk reg s1 == 0x00000000007f6e5d4c3b2a1908000000
    slli s1, s0, 24
    //prgchk reg s1 == 0x0000000000fedcba9876543210000000
    slli s1, s0, 25
    //prgchk reg s1 == 0x0000000001fdb97530eca86420000000
    slli s1, s0, 26
    //prgchk reg s1 == 0x0000000003fb72ea61d950c840000000
    slli s1, s0, 27
    //prgchk reg s1 == 0x0000000007f6e5d4c3b2a19080000000
    slli s1, s0, 28
    //prgchk reg s1 == 0x000000000fedcba98765432100000000
    slli s1, s0, 29
    //prgchk reg s1 == 0x000000001fdb97530eca864200000000
    slli s1, s0, 30
    //prgchk reg s1 == 0x000000003fb72ea61d950c8400000000
    slli s1, s0, 31
    //prgchk reg s1 == 0x000000007f6e5d4c3b2a190800000000
    slli s1, s0, 32
    //prgchk reg s1 == 0x00000000fedcba987654321000000000
    slli s1, s0, 33
    //prgchk reg s1 == 0x00000001fdb97530eca8642000000000
    slli s1, s0, 34
    //prgchk reg s1 == 0x00000003fb72ea61d950c84000000000
    slli s1, s0, 35
    //prgchk reg s1 == 0x00000007f6e5d4c3b2a1908000000000
    slli s1, s0, 36
    //prgchk reg s1 == 0x0000000fedcba9876543210000000000
    slli s1, s0, 37
    //prgchk reg s1 == 0x0000001fdb97530eca86420000000000
    slli s1, s0, 38
    //prgchk reg s1 == 0x0000003fb72ea61d950c840000000000
    slli s1, s0, 39
    //prgchk reg s1 == 0x0000007f6e5d4c3b2a19080000000000
    slli s1, s0, 40
    //prgchk reg s1 == 0x000000fedcba98765432100000000000
    slli s1, s0, 41
    //prgchk reg s1 == 0x000001fdb97530eca864200000000000
    slli s1, s0, 42
    //prgchk reg s1 == 0x000003fb72ea61d950c8400000000000
    slli s1, s0, 43
    //prgchk reg s1 == 0x000007f6e5d4c3b2a190800000000000
    slli s1, s0, 44
    //prgchk reg s1 == 0x00000fedcba987654321000000000000
    slli s1, s0, 45
    //prgchk reg s1 == 0x00001fdb97530eca8642000000000000
    slli s1, s0, 46
    //prgchk reg s1 == 0x00003fb72ea61d950c84000000000000
    slli s1, s0, 47
    //prgchk reg s1 == 0x00007f6e5d4c3b2a1908000000000000
    slli s1, s0, 48
    //prgchk reg s1 == 0x0000fedcba9876543210000000000000
    slli s1, s0, 49
    //prgchk reg s1 == 0x0001fdb97530eca86420000000000000
    slli s1, s0, 50
    //prgchk reg s1 == 0x0003fb72ea61d950c840000000000000
    slli s1, s0, 51
    //prgchk reg s1 == 0x0007f6e5d4c3b2a19080000000000000
    slli s1, s0, 52
    //prgchk reg s1 == 0x000fedcba98765432100000000000000
    slli s1, s0, 53
    //prgchk reg s1 == 0x001fdb97530eca864200000000000000
    slli s1, s0, 54
    //prgchk reg s1 == 0x003fb72ea61d950c8400000000000000
    slli s1, s0, 55
    //prgchk reg s1 == 0x007f6e5d4c3b2a190800000000000000
    slli s1, s0, 56
    //prgchk reg s1 == 0x00fedcba987654321000000000000000
    slli s1, s0, 57
    //prgchk reg s1 == 0x01fdb97530eca8642000000000000000
    slli s1, s0, 58
    //prgchk reg s1 == 0x03fb72ea61d950c84000000000000000
    slli s1, s0, 59
    //prgchk reg s1 == 0x07f6e5d4c3b2a1908000000000000000
    slli s1, s0, 60
    //prgchk reg s1 == 0x0fedcba9876543210000000000000000
    slli s1, s0, 61
    //prgchk reg s1 == 0x1fdb97530eca86420000000000000000
    slli s1, s0, 62
    //prgchk reg s1 == 0x3fb72ea61d950c840000000000000000
    slli s1, s0, 63
    //prgchk reg s1 == 0x7f6e5d4c3b2a19080000000000000000
    slli s1, s0, 64
    //prgchk reg s1 == 0xfedcba98765432100000000000000000
    slli s1, s0, 65
    //prgchk reg s1 == 0xfdb97530eca864200000000000000000
    slli s1, s0, 66
    //prgchk reg s1 == 0xfb72ea61d950c8400000000000000000
    slli s1, s0, 67
    //prgchk reg s1 == 0xf6e5d4c3b2a190800000000000000000
    slli s1, s0, 68
    //prgchk reg s1 == 0xedcba987654321000000000000000000
    slli s1, s0, 69
    //prgchk reg s1 == 0xdb97530eca8642000000000000000000
    slli s1, s0, 70
    //prgchk reg s1 == 0xb72ea61d950c84000000000000000000
    slli s1, s0, 71
    //prgchk reg s1 == 0x6e5d4c3b2a1908000000000000000000
    slli s1, s0, 72
    //prgchk reg s1 == 0xdcba9876543210000000000000000000
    slli s1, s0, 73
    //prgchk reg s1 == 0xb97530eca86420000000000000000000
    slli s1, s0, 74
    //prgchk reg s1 == 0x72ea61d950c840000000000000000000
    slli s1, s0, 75
    //prgchk reg s1 == 0xe5d4c3b2a19080000000000000000000
    slli s1, s0, 76
    //prgchk reg s1 == 0xcba98765432100000000000000000000
    slli s1, s0, 77
    //prgchk reg s1 == 0x97530eca864200000000000000000000
    slli s1, s0, 78
    //prgchk reg s1 == 0x2ea61d950c8400000000000000000000
    slli s1, s0, 79
    //prgchk reg s1 == 0x5d4c3b2a190800000000000000000000
    slli s1, s0, 80
    //prgchk reg s1 == 0xba987654321000000000000000000000
    slli s1, s0, 81
    //prgchk reg s1 == 0x7530eca8642000000000000000000000
    slli s1, s0, 82
    //prgchk reg s1 == 0xea61d950c84000000000000000000000
    slli s1, s0, 83
    //prgchk reg s1 == 0xd4c3b2a1908000000000000000000000
    slli s1, s0, 84
    //prgchk reg s1 == 0xa9876543210000000000000000000000
    slli s1, s0, 85
    //prgchk reg s1 == 0x530eca86420000000000000000000000
    slli s1, s0, 86
    //prgchk reg s1 == 0xa61d950c840000000000000000000000
    slli s1, s0, 87
    //prgchk reg s1 == 0x4c3b2a19080000000000000000000000
    slli s1, s0, 88
    //prgchk reg s1 == 0x98765432100000000000000000000000
    slli s1, s0, 89
    //prgchk reg s1 == 0x30eca864200000000000000000000000
    slli s1, s0, 90
    //prgchk reg s1 == 0x61d950c8400000000000000000000000
    slli s1, s0, 91
    //prgchk reg s1 == 0xc3b2a190800000000000000000000000
    slli s1, s0, 92
    //prgchk reg s1 == 0x87654321000000000000000000000000
    slli s1, s0, 93
    //prgchk reg s1 == 0x0eca8642000000000000000000000000
    slli s1, s0, 94
    //prgchk reg s1 == 0x1d950c84000000000000000000000000
    slli s1, s0, 95
    //prgchk reg s1 == 0x3b2a1908000000000000000000000000
    slli s1, s0, 96
    //prgchk reg s1 == 0x76543210000000000000000000000000
    slli s1, s0, 97
    //prgchk reg s1 == 0xeca86420000000000000000000000000
    slli s1, s0, 98
    //prgchk reg s1 == 0xd950c840000000000000000000000000
    slli s1, s0, 99
    //prgchk reg s1 == 0xb2a19080000000000000000000000000
    slli s1, s0, 100
    //prgchk reg s1 == 0x65432100000000000000000000000000
    slli s1, s0, 101
    //prgchk reg s1 == 0xca864200000000000000000000000000
    slli s1, s0, 102
    //prgchk reg s1 == 0x950c8400000000000000000000000000
    slli s1, s0, 103
    //prgchk reg s1 == 0x2a190800000000000000000000000000
    slli s1, s0, 104
    //prgchk reg s1 == 0x54321000000000000000000000000000
    slli s1, s0, 105
    //prgchk reg s1 == 0xa8642000000000000000000000000000
    slli s1, s0, 106
    //prgchk reg s1 == 0x50c84000000000000000000000000000
    slli s1, s0, 107
    //prgchk reg s1 == 0xa1908000000000000000000000000000
    slli s1, s0, 108
    //prgchk reg s1 == 0x43210000000000000000000000000000
    slli s1, s0, 109
    //prgchk reg s1 == 0x86420000000000000000000000000000
    slli s1, s0, 110
    //prgchk reg s1 == 0x0c840000000000000000000000000000
    slli s1, s0, 111
    //prgchk reg s1 == 0x19080000000000000000000000000000
    slli s1, s0, 112
    //prgchk reg s1 == 0x32100000000000000000000000000000
    slli s1, s0, 113
    //prgchk reg s1 == 0x64200000000000000000000000000000
    slli s1, s0, 114
    //prgchk reg s1 == 0xc8400000000000000000000000000000
    slli s1, s0, 115
    //prgchk reg s1 == 0x90800000000000000000000000000000
    slli s1, s0, 116
    //prgchk reg s1 == 0x21000000000000000000000000000000
    slli s1, s0, 117
    //prgchk reg s1 == 0x42000000000000000000000000000000
    slli s1, s0, 118
    //prgchk reg s1 == 0x84000000000000000000000000000000
    slli s1, s0, 119
    //prgchk reg s1 == 0x08000000000000000000000000000000
    slli s1, s0, 120
    //prgchk reg s1 == 0x10000000000000000000000000000000
    slli s1, s0, 121
    //prgchk reg s1 == 0x20000000000000000000000000000000
    slli s1, s0, 122
    //prgchk reg s1 == 0x40000000000000000000000000000000
    slli s1, s0, 123
    //prgchk reg s1 == 0x80000000000000000000000000000000
    slli s1, s0, 124
    //prgchk reg s1 == 0x00000000000000000000000000000000
    slli s1, s0, 125
    //prgchk reg s1 == 0x00000000000000000000000000000000
    slli s1, s0, 126
    //prgchk reg s1 == 0x00000000000000000000000000000000
    j exit
