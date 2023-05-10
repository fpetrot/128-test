#include "insns.S" 
#include "utils.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // mscratch/h does not produce any side effect, so
    // this set of test is only to check that the csr insns
    // have the behavior we expect
    li   t0, 0xdeadbeef // The non animal right activist constant
    li   t1, 0xcafebabe // The non politically correct constant
    slli t0, t0, 96
    or    t2, t1, t0
    // first check read and write
    csrw mscratch, t2
    csrr t3, mscratch
    //prgchk reg t3 == 0xdeadbeef0000000000000000cafebabe
    // check swap
    slli t5, t1, 32
    or    t2, t5, t4
    csrrw t4, mscratch, t2
    //prgchk reg t4 == 0xdeadbeef0000000000000000cafebabe
    csrr t3, mscratch
    //prgchk reg t3 == 0x00000000deadbeefcafebabe00000000
    csrrsi   zero, mscratch, 15
    csrr t3, mscratch
    //prgchk reg t3 == 0x00000000deadbeefcafebabe0000000f
    csrrci   zero, mscratch, 10
    csrr t3, mscratch
    //prgchk reg t3 == 0x00000000deadbeefcafebabe00000005
    j exit
