#include "insns.S" 
#include "utils.S"

.section .rodata
    w1:     .dword 0xfedcba0987654321
    w2:     .dword 0x1234567890abcdef
    w3:     .dword 0x42
    w4:     .dword 0x7896745188547411
    w5:     .dword 0xffffffffffffffff
    w6:     .dword 0xffffffffffffffd6
    minsgn: .dword 0x8000000000000000

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Various basic divisions
    ld t0, w1
    ld t1, w2
    divud(t2, t0, t1)
    //prgchk reg t2 == 0xd
    srli(t2, t2, 64)
    //prgchk reg t2 == 0

    divud(t2, t1, t0)
    //prgchk reg t2 == 0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0

    ld t1, w3
    divud(t2, t0, t1)
    //prgchk reg t2 == 0x3dc8e74820d2baf
    srli(t2, t2, 64)
    //prgchk reg t2 == 0
    
    // Divide by self.
    divud(t2, t0, t0)
    //prgchk reg t2 == 1
    srli(t2, t2, 64)
    //prgchk reg t2 == 0

    // Divide by -1
    ld t0, w1
    ld t1, w5
    divud(t2, t0, t1)
    //prgchk reg t2 == 0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0

    ld t0, w4
    divud(t2, t0, t1)
    //prgchk reg t2 == 0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0

    ld t0, w6
    divud(t2, t0, t1)
    //prgchk reg t2 == 0
    srli(t2, t2, 64)
    //prgchk reg t2 == 0

    // Check div by zero behavior
    ld t0, w1
    liu(t1, 0)
    divud(t2, t0, t1)
    //prgchk reg t2 == 0xffffffffffffffff
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    j exit
