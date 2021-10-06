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
    slli (t0, t0, 96)
    or    t2, t1, t0
    // first check read and write
    csrw mscratch, t2
    csrr t3, mscratch
    //prgchk reg t3 == 0x00000000cafebabe
    srli(t3, t3, 64)
    //prgchk reg t3 == 0xdeadbeef00000000
    // check swap
    slli (t5, t1, 32)
    srli (t4, t0, 32)
    or    t2, t5, t4
    csrrw t4, mscratch, t2
    //prgchk reg t4 == 0x00000000cafebabe
    srli(t4, t4, 64)
    //prgchk reg t4 == 0xdeadbeef00000000
    csrr t3, mscratch
    //prgchk reg t3 == 0xcafebabe00000000
    srli(t3, t3, 64)
    //prgchk reg t3 == 0x00000000deadbeef
    csrrsi   zero, mscratch, 15
    csrr t3, mscratch
    //prgchk reg t3 == 0xcafebabe0000000f
    srli(t3, t3, 64)
    //prgchk reg t3 == 0x00000000deadbeef
    csrrci   zero, mscratch, 10
    csrr t3, mscratch
    //prgchk reg t3 == 0xcafebabe00000005
    srli(t3, t3, 64)
    //prgchk reg t3 == 0x00000000deadbeef
    j exit
