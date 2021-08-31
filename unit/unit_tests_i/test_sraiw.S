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
    sraiw t1, t0, 0
    //prgchk reg t1 == 0xffffffff80000000
    srli(t1, t1, 64)
    //prgchk reg t1 == 0xffffffffffffffff

    liu(t0, 0x7fedfedf)
    sraiw t1, t0, 0
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
    sraiw t2, t0, 0
    //prgchk reg t2 == 0xffffffffdeadbeef
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraiw t2, t0, 1
    //prgchk reg t2 == 0xffffffffef56df77
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraiw t2, t0, 2
    //prgchk reg t2 == 0xfffffffff7ab6fbb
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraiw t2, t0, 3
    //prgchk reg t2 == 0xfffffffffbd5b7dd
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraiw t2, t0, 4
    //prgchk reg t2 == 0xfffffffffdeadbee
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraiw t2, t0, 5
    //prgchk reg t2 == 0xfffffffffef56df7
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraiw t2, t0, 6
    //prgchk reg t2 == 0xffffffffff7ab6fb
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraiw t2, t0, 7
    //prgchk reg t2 == 0xffffffffffbd5b7d
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraiw t2, t0, 8
    //prgchk reg t2 == 0xffffffffffdeadbe
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraiw t2, t0, 9
    //prgchk reg t2 == 0xffffffffffef56df
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraiw t2, t0, 10
    //prgchk reg t2 == 0xfffffffffff7ab6f
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraiw t2, t0, 11
    //prgchk reg t2 == 0xfffffffffffbd5b7
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraiw t2, t0, 12
    //prgchk reg t2 == 0xfffffffffffdeadb
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraiw t2, t0, 13
    //prgchk reg t2 == 0xfffffffffffef56d
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraiw t2, t0, 14
    //prgchk reg t2 == 0xffffffffffff7ab6
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraiw t2, t0, 15
    //prgchk reg t2 == 0xffffffffffffbd5b
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraiw t2, t0, 16
    //prgchk reg t2 == 0xffffffffffffdead
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraiw t2, t0, 17
    //prgchk reg t2 == 0xffffffffffffef56
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraiw t2, t0, 18
    //prgchk reg t2 == 0xfffffffffffff7ab
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraiw t2, t0, 19
    //prgchk reg t2 == 0xfffffffffffffbd5
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraiw t2, t0, 20
    //prgchk reg t2 == 0xfffffffffffffdea
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraiw t2, t0, 21
    //prgchk reg t2 == 0xfffffffffffffef5
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraiw t2, t0, 22
    //prgchk reg t2 == 0xffffffffffffff7a
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraiw t2, t0, 23
    //prgchk reg t2 == 0xffffffffffffffbd
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraiw t2, t0, 24
    //prgchk reg t2 == 0xffffffffffffffde
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraiw t2, t0, 25
    //prgchk reg t2 == 0xffffffffffffffef
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraiw t2, t0, 26
    //prgchk reg t2 == 0xfffffffffffffff7
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraiw t2, t0, 27
    //prgchk reg t2 == 0xfffffffffffffffb
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraiw t2, t0, 28
    //prgchk reg t2 == 0xfffffffffffffffd
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraiw t2, t0, 29
    //prgchk reg t2 == 0xfffffffffffffffe
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraiw t2, t0, 30
    //prgchk reg t2 == 0xffffffffffffffff
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
    sraiw t2, t0, 31
    //prgchk reg t2 == 0xffffffffffffffff
    srli(t2, t2, 64)
    //prgchk reg t2 == 0xffffffffffffffff
j exit