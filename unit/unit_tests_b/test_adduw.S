#include "exit.S"
.section .data
    dwarray: .word 1, 2, 3, 5, 7, 11, 13, 17, 0xffff
.section .text.init,"ax",@progbits
.globl _start
_start:
    li t0, 0xae36d53f51a671836aba36a5d5d76824
    li t1, 0xa79b71e63793aaa39dbab87660386b3b
    add.uw s0, t0, t1
    //prgchk reg s0 == 0xa79b71e63793aaa39dbab877360fd35f

    li t2, 0xbf859750de311d51fcf2cdbdecfe2c00
    li t3, 0xb75e5d09084915ae23142b35a23a3991
    add.uw s1, t2, t3
    //prgchk reg s1 == 0xb75e5d09084915ae23142b368f386591

    li t4, 0x9ab89e16aaf84537677e7b46104f34e5
    li t5, 0xf5f7db207647c4329415954eeabaade4
    add.uw s2, t4, t5
    //prgchk reg s2 == 0xf5f7db207647c4329415954efb09e2c9

    li t6, 0xb378a417ad18889a8b9280922bee38dd
    add.uw s3, s2, t6
    //prgchk reg s3 == 0xb378a417ad18889a8b92809326f81ba6

    j exit
