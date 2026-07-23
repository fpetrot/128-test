#include "exit.S"
.section .data
    dwarray: .word 1, 2, 3, 5, 7, 11, 13, 17, 0xffff
.section .text.init,"ax",@progbits
.globl _start
_start:
    li t0, 0xae36d53f51a671836aba36a5d5d76824
    li t1, 0xa79b71e63793aaa39dbab87660386b3b
    li t2, 0xbf859750de311d51fcf2cdbdecfe2c00
    li t3, 0xb75e5d09084915ae23142b35a23a3991
    li t4, 0x9ab89e16aaf84537677e7b46104f34e5
    li t5, 0xf5f7db207647c4329415954eeabaade4
    li t6, 0xb378a417ad18889a8b9280922bee38dd

    add.ud s0, t0, t1
    //prgchk reg s0 == 0xa79b71e63793aaa40874ef1c360fd35f
    add.ud s1, t2, t3
    //prgchk reg s1 == 0xb75e5d09084915af2006f8f38f386591
    add.ud s2, t4, t5
    //prgchk reg s2 == 0xf5f7db207647c432fb941094fb09e2c9
    add.ud s3, s2, t6
    //prgchk reg s3 == 0xb378a417ad18889b8726912726f81ba6
    j exit
