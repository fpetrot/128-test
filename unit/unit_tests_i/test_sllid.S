#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    li t0, 0xf0ffffffffffffff
    
    sllid t1, t0, 4
    //prgchk reg t1 == 0x00000000000000000ffffffffffffff0


    li t0, 0x0080ffffffffffff
    sllid t1, t0, 8
    //prgchk reg t1 == 0xffffffffffffffff80ffffffffffff00

    li t0, 0x76543210abcdefaa
    sllid t1, t0, 4
    //prgchk reg t1 == 0x00000000000000006543210abcdefaa0


    sllid t1, t0, 1
    //prgchk reg t1 == 0xffffffffffffffffeca86421579bdf54


    sllid t1, t0, 13
    //prgchk reg t1 == 0xffffffffffffffff86421579bdf54000


    sllid t1, t0, 0
    //prgchk reg t1 == 0x000000000000000076543210abcdefaa


    sllid t1, t0, 63
    //prgchk reg t1 == 0

    li t0, 1
    sllid t1, t0, 63
    //prgchk reg t1 == 0xffffffffffffffff8000000000000000

    j exit
