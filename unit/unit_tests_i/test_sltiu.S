#include "exit.S"

.section .data
    bigtest: .octa 0xb3ac109c8a412d90ef2a3664165c497a
    tst:     .octa 0xfffffffffffffffffffffffffff89765
    tst2:    .octa 0x7ff00000000000000000000000000035

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Trivial base checks
    li s0, 7
    sltiu s1, s0, 5
    //prgchk reg s1 == 0


    li s0, 35
    sltiu s1, s0, 2047
    //prgchk reg s1 == 1


    // Check that comparison is unsigned.
    li s0, 62
    sltiu s1, s0, -1
    //prgchk reg s1 == 1


    // Check with equal values.
    li s0, 2001
    sltiu s1, s0, 2001
    //prgchk reg s1 == 0


    // Check with max immediate
    li s0, 2000
    sltiu s1, s0, 2047
    //prgchk reg s1 == 1

    
    li s0, 8900
    sltiu s1, s0, 2047
    //prgchk reg s1 == 0


    // Check with min immediate
    li s0, 0xb3ac109c8a412d90ef2a3664165c497a
    //prgchk reg s0 == 0xb3ac109c8a412d90ef2a3664165c497a
    sltiu s1, s0, -2048
    //prgchk reg s1 == 1


    // Check all cases
    // rs1_hi >= imm_hi && rs1_lo >= imm_lo
    sltiu s1, s0, 568
    //prgchk reg s1 == 0


    // rs1_hi >= imm_h && rs1_lo < imm_lo && heq
    li s0, 0xfffffffffffffffffffffffffff89765
    //prgchk reg s0 == 0xfffffffffffffffffffffffffff89765
    sltiu s1, s0, -2041
    //prgchk reg s1 == 1


    // rs1_hi >= imm_hi && rs1_lo < imm_lo && !heq
    li s0, 0x7ff00000000000000000000000000035
    //prgchk reg s0 == 0x7ff00000000000000000000000000035
    sltiu s1, s0, 54
    //prgchk reg s1 == 0


    // rs1_hi < imm_hi && rs1_lo < imm_lo
    li s0, 35
    sltiu s1, s0, -2000 
    //prgchk reg s1 == 1


    // rs1_hi < imm_hi && rs1_lo >= imm_lo
    li s0, 0xffffffffffffffff
    sltiu s1, s0, -2000
    //prgchk reg s1 == 1

    j exit
