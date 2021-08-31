#include "insns.S" 
#include "utils.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
# We're in bare metal, so set stack at the end of physical memory
la      sp, _memory_end
j main

main:
    li t0, 0xf0ffffffffffffff
    
    sllid(t1, t0, 4)
    //prgchk reg t1 == 0x0ffffffffffffff0
    srli(t1, t1, 64)
    //prgchk reg t1 == 0

    li t0, 0x0080ffffffffffff
    sllid(t1, t0, 8)
    //prgchk reg t1 == 0x80ffffffffffff00
    srli(t1, t1, 64)
    //prgchk reg t1 == 0xffffffffffffffff

    li t0, 0x76543210abcdefaa
    sllid(t1, t0, 4)
    //prgchk reg t1 == 0x6543210abcdefaa0
    srli(t1, t1, 64)
    //prgchk reg t1 == 0

    sllid(t1, t0, 1)
    //prgchk reg t1 == 0xeca86421579bdf54
    srli(t1, t1, 64)
    //prgchk reg t1 == 0xffffffffffffffff

    sllid(t1, t0, 13)
    //prgchk reg t1 == 0x86421579bdf54000
    srli(t1, t1, 64)
    //prgchk reg t1 == 0xffffffffffffffff

    sllid(t1, t0, 0)
    //prgchk reg t1 == 0x76543210abcdefaa
    srli(t1, t1, 64)
    //prgchk reg t1 == 0

    sllid(t1, t0, 63)
    //prgchk reg t1 == 0
    srli(t1, t1, 64)
    //prgchk reg t1 == 0

    li t0, 1
    sllid(t1, t0, 63)
    //prgchk reg t1 == 0x8000000000000000
    srli(t1, t1, 64)
    //prgchk reg t1 == 0xffffffffffffffff
j exit