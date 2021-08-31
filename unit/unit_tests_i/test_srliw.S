#include "insns.S" 
#include "utils.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
# We're in bare metal, so set stack at the end of physical memory
la      sp, _memory_end
j main

main:
    // Check sign extensions.
    liu(t0, 0x80000000)
    srliw t1, t0, 0
    //prgchk reg t1 == 0xffffffff80000000
    srli(t1, t1, 64)
    //prgchk reg t1 == 0xffffffffffffffff

    liu(t0, 0x7fedfedf)
    srliw t1, t0, 0
    //prgchk reg t1 == 0x7fedfedf
    srli(t1, t1, 64)
    //prgchk reg t1 == 0

    liu(t0, 0x1234567800000000)
    srliw t1, t0, 12
    //prgchk reg t1 == 0
    srli(t1, t1, 64)
    //prgchk reg t1 == 0

    // Incremental shifts from 0 to 31.
    li t0, 0xdeadbeef
    srliw t2, t0, 0
    //prgchk reg t2 == 0xffffffffdeadbeef
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    srliw t2, t0, 1
    //prgchk reg t2 == 0x6f56df77
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srliw t2, t0, 2
    //prgchk reg t2 == 0x37ab6fbb
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srliw t2, t0, 3
    //prgchk reg t2 == 0x1bd5b7dd
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srliw t2, t0, 4
    //prgchk reg t2 == 0xdeadbee
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srliw t2, t0, 5
    //prgchk reg t2 == 0x6f56df7
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srliw t2, t0, 6
    //prgchk reg t2 == 0x37ab6fb
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srliw t2, t0, 7
    //prgchk reg t2 == 0x1bd5b7d
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srliw t2, t0, 8
    //prgchk reg t2 == 0xdeadbe
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srliw t2, t0, 9
    //prgchk reg t2 == 0x6f56df
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srliw t2, t0, 10
    //prgchk reg t2 == 0x37ab6f
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srliw t2, t0, 11
    //prgchk reg t2 == 0x1bd5b7
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srliw t2, t0, 12
    //prgchk reg t2 == 0xdeadb
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srliw t2, t0, 13
    //prgchk reg t2 == 0x6f56d
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srliw t2, t0, 14
    //prgchk reg t2 == 0x37ab6
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srliw t2, t0, 15
    //prgchk reg t2 == 0x1bd5b
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srliw t2, t0, 16
    //prgchk reg t2 == 0xdead
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srliw t2, t0, 17
    //prgchk reg t2 == 0x6f56
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srliw t2, t0, 18
    //prgchk reg t2 == 0x37ab
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srliw t2, t0, 19
    //prgchk reg t2 == 0x1bd5
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srliw t2, t0, 20
    //prgchk reg t2 == 0xdea
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srliw t2, t0, 21
    //prgchk reg t2 == 0x6f5
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srliw t2, t0, 22
    //prgchk reg t2 == 0x37a
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srliw t2, t0, 23
    //prgchk reg t2 == 0x1bd
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srliw t2, t0, 24
    //prgchk reg t2 == 0xde
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srliw t2, t0, 25
    //prgchk reg t2 == 0x6f
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srliw t2, t0, 26
    //prgchk reg t2 == 0x37
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srliw t2, t0, 27
    //prgchk reg t2 == 0x1b
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srliw t2, t0, 28
    //prgchk reg t2 == 0xd
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srliw t2, t0, 29
    //prgchk reg t2 == 0x6
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srliw t2, t0, 30
    //prgchk reg t2 == 0x3
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    srliw t2, t0, 31
    //prgchk reg t2 == 0x1
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
j exit
