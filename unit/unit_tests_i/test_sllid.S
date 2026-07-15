#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    li s0, 0xf0ffffffffffffff
    
    sllid s1, s0, 4
    //prgchk reg s1 == 0x00000000000000000ffffffffffffff0


    li s0, 0x0080ffffffffffff
    sllid s1, s0, 8
    //prgchk reg s1 == 0xffffffffffffffff80ffffffffffff00

    li s0, 0x76543210abcdefaa
    sllid s1, s0, 4
    //prgchk reg s1 == 0x00000000000000006543210abcdefaa0


    sllid s1, s0, 1
    //prgchk reg s1 == 0xffffffffffffffffeca86421579bdf54


    sllid s1, s0, 13
    //prgchk reg s1 == 0xffffffffffffffff86421579bdf54000


    sllid s1, s0, 0
    //prgchk reg s1 == 0x000000000000000076543210abcdefaa


    sllid s1, s0, 63
    //prgchk reg s1 == 0

    li s0, 1
    sllid s1, s0, 63
    //prgchk reg s1 == 0xffffffffffffffff8000000000000000

    j exit
