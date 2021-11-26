#include "insns.S" 
#include "utils.S"

.section .data
    bigtest: .octa 0xb3ac109c8a412d90ef2a3664165c497a
    tst:     .octa 0xfffffffffffffffffffffffffff89765
    tst2:    .octa 0x7ff00000000000000000000000000035

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Trivial base checks
    li t0, 7
    sltiu t1, t0, 5
    //prgchk reg t1 == 0
    srli(t1, t1, 64)
    //prgchk reg t1 == 0

    li t0, 35
    sltiu t1, t0, 2047
    //prgchk reg t1 == 1
    srli(t1, t1, 64)
    //prgchk reg t1 == 0

    // Check that comparison is unsigned.
    li t0, 62
    sltiu t1, t0, -1
    //prgchk reg t1 == 1
    srli(t1, t1, 64)
    //prgchk reg t1 == 0

    // Check with equal values.
    li t0, 2001
    sltiu t1, t0, 2001
    //prgchk reg t1 == 0
    srli(t1, t1, 64)
    //prgchk reg t1 == 0

    // Check with max immediate
    li t0, 2000
    sltiu t1, t0, 2047
    //prgchk reg t1 == 1
    srli(t1, t1, 64)
    //prgchk reg t1 == 0
    
    li t0, 8900
    sltiu t1, t0, 2047
    //prgchk reg t1 == 0
    srli(t1, t1, 64)
    //prgchk reg t1 == 0

    // Check with min immediate
    la t0, bigtest
    lq(t0, 0, t0)
    sltiu t1, t0, -2048
    //prgchk reg t1 == 1
    srli(t1, t1, 64)
    //prgchk reg t1 == 0

    // Check all cases
    // rs1_hi >= imm_hi && rs1_lo >= imm_lo
    sltiu t1, t0, 568
    //prgchk reg t1 == 0
    srli(t1, t1, 64)
    //prgchk reg t1 == 0

    // rs1_hi >= imm_h && rs1_lo < imm_lo && heq
    la t0, tst
    lq(t0, 0, t0)
    sltiu t1, t0, -2041
    //prgchk reg t1 == 1
    srli(t1, t1, 64)
    //prgchk reg t1 == 0

    // rs1_hi >= imm_hi && rs1_lo < imm_lo && !heq
    la t0, tst2
    lq(t0, 0, t0)
    //prgchk reg t0 == 0x0000000000000035
    srli(t1, t0, 64)
    //prgchk reg t1 == 0x7ff0000000000000
    sltiu t1, t0, 54
    //prgchk reg t1 == 0
    srli(t1, t1, 64)
    //prgchk reg t1 == 0

    // rs1_hi < imm_hi && rs1_lo < imm_lo
    li t0, 35
    sltiu t1, t0, -2000 
    //prgchk reg t1 == 1
    srli(t1, t1, 64)
    //prgchk reg t1 == 0

    // rs1_hi < imm_hi && rs1_lo >= imm_lo
    liu(t0, 0xffffffffffffffff)
    sltiu t1, t0, -2000
    //prgchk reg t1 == 1
    srli(t1, t1, 64)
    //prgchk reg t1 == 0
    j exit
