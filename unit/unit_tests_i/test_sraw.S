#include "insns.S" 
#include "utils.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
# We're in bare metal, so set stack at the end of physical memory
la      sp, _memory_end
j main

main:
    // Carry of zero sign bit
    li t0, 0x7fffffff
    li t1, 16
    sraw t2, t0, t1
    //prgchk reg t2 == 0x00007fff

    // Check usage of only low 5 bits.
    li t0, 0xcafebabe
    li t1, 48 // should give a shift of 16
    sraw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffcafe
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff

    // Incremental shifts from 0 to 31 of known value.
    li t0, 0xdeadbeef
    li t1, 0
    sraw t2, t0, t1
    //prgchk reg t2 == 0xffffffffdeadbeef
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 1
    sraw t2, t0, t1
    //prgchk reg t2 == 0xffffffffef56df77
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 2
    sraw t2, t0, t1
    //prgchk reg t2 == 0xfffffffff7ab6fbb
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 3
    sraw t2, t0, t1
    //prgchk reg t2 == 0xfffffffffbd5b7dd
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 4
    sraw t2, t0, t1
    //prgchk reg t2 == 0xfffffffffdeadbee
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 5
    sraw t2, t0, t1
    //prgchk reg t2 == 0xfffffffffef56df7
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 6
    sraw t2, t0, t1
    //prgchk reg t2 == 0xffffffffff7ab6fb
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 7
    sraw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffbd5b7d
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 8
    sraw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffdeadbe
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 9
    sraw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffef56df
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 10
    sraw t2, t0, t1
    //prgchk reg t2 == 0xfffffffffff7ab6f
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 11
    sraw t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffbd5b7
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 12
    sraw t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffdeadb
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 13
    sraw t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffef56d
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 14
    sraw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffff7ab6
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 15
    sraw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffbd5b
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 16
    sraw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffdead
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 17
    sraw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffef56
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 18
    sraw t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffff7ab
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 19
    sraw t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffbd5
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 20
    sraw t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffdea
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 21
    sraw t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffef5
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 22
    sraw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffff7a
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 23
    sraw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffbd
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 24
    sraw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffde
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 25
    sraw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffef
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 26
    sraw t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffff7
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 27
    sraw t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffb
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 28
    sraw t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffd
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 29
    sraw t2, t0, t1
    //prgchk reg t2 == 0xfffffffffffffffe
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 30
    sraw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffff
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    li t1, 31
    sraw t2, t0, t1
    //prgchk reg t2 == 0xffffffffffffffff
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
j exit