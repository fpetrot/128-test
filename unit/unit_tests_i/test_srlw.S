#include "insns.S" 
#include "utils.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Check usage of only low 5 bits.
    li t0, 0xcafebabe
    li t1, 48 // should give a shift of 16
    srlw t2, t0, t1
    //prgchk reg t2 == 0xcafe
    srli(t2, t2, 64)
    //prgchk reg t2 == 0

    li t0, 0xdeadbeef
    li t1, 0
    srlw t2, t0, t1
    //prgchk reg t2 == 0xffffffffdeadbeef
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 1
    srlw t2, t0, t1
    //prgchk reg t2 == 0x6f56df77
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 2
    srlw t2, t0, t1
    //prgchk reg t2 == 0x37ab6fbb
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 3
    srlw t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7dd
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 4
    srlw t2, t0, t1
    //prgchk reg t2 == 0xdeadbee
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 5
    srlw t2, t0, t1
    //prgchk reg t2 == 0x6f56df7
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 6
    srlw t2, t0, t1
    //prgchk reg t2 == 0x37ab6fb
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 7
    srlw t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7d
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 8
    srlw t2, t0, t1
    //prgchk reg t2 == 0xdeadbe
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 9
    srlw t2, t0, t1
    //prgchk reg t2 == 0x6f56df
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 10
    srlw t2, t0, t1
    //prgchk reg t2 == 0x37ab6f
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 11
    srlw t2, t0, t1
    //prgchk reg t2 == 0x1bd5b7
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 12
    srlw t2, t0, t1
    //prgchk reg t2 == 0xdeadb
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 13
    srlw t2, t0, t1
    //prgchk reg t2 == 0x6f56d
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 14
    srlw t2, t0, t1
    //prgchk reg t2 == 0x37ab6
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 15
    srlw t2, t0, t1
    //prgchk reg t2 == 0x1bd5b
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 16
    srlw t2, t0, t1
    //prgchk reg t2 == 0xdead
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 17
    srlw t2, t0, t1
    //prgchk reg t2 == 0x6f56
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 18
    srlw t2, t0, t1
    //prgchk reg t2 == 0x37ab
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 19
    srlw t2, t0, t1
    //prgchk reg t2 == 0x1bd5
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 20
    srlw t2, t0, t1
    //prgchk reg t2 == 0xdea
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 21
    srlw t2, t0, t1
    //prgchk reg t2 == 0x6f5
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 22
    srlw t2, t0, t1
    //prgchk reg t2 == 0x37a
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 23
    srlw t2, t0, t1
    //prgchk reg t2 == 0x1bd
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 24
    srlw t2, t0, t1
    //prgchk reg t2 == 0xde
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 25
    srlw t2, t0, t1
    //prgchk reg t2 == 0x6f
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 26
    srlw t2, t0, t1
    //prgchk reg t2 == 0x37
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 27
    srlw t2, t0, t1
    //prgchk reg t2 == 0x1b
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 28
    srlw t2, t0, t1
    //prgchk reg t2 == 0xd
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 29
    srlw t2, t0, t1
    //prgchk reg t2 == 0x6
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 30
    srlw t2, t0, t1
    //prgchk reg t2 == 0x3
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    li t1, 31
    srlw t2, t0, t1
    //prgchk reg t2 == 0x1
    srli(t2, t2, 64)
    //prgchk reg t2 == 0x0
    j exit
