#include "utils.S"
#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // mscratch/h does not produce any side effect, so
    // this set of test is only to check that the csr insns
    // have the behavior we expect
    li     s0, 0xdeadbeef // The non animal right activist constant
    li     s1, 0xcafebabe // The anti-feminism constant
    slli   s0, s0, 96
    or     s2, s1, s0
    // first check read and write
    csrw   mscratch, s2
    csrr   s3, mscratch
    //prgchk reg s3 == 0xdeadbeef0000000000000000cafebabe
    // check swap
    slli   s5, s1, 32
    srli   s4, s0, 32
    or     s2, s5, s4
    csrrw  s4, mscratch, s2
    //prgchk reg s4 == 0xdeadbeef0000000000000000cafebabe
    csrr   s3, mscratch
    //prgchk reg s3 == 0x00000000deadbeefcafebabe00000000
    csrrsi zero, mscratch, 15
    csrr   s3, mscratch
    //prgchk reg s3 == 0x00000000deadbeefcafebabe0000000f
    csrrci zero, mscratch, 10
    csrr   s3, mscratch
    //prgchk reg s3 == 0x00000000deadbeefcafebabe00000005
    j exit
