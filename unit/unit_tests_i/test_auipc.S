#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Check with null-immediate.
addr1:
    auipc s0, 0
    la s1, addr1
    //prgchk gdb $s0 == $s1
    
addr2:
    auipc s0, 1
    la s1, addr2
    li s2, 0x1000
    add s1, s1, s2
    //prgchk gdb $s0 == $s1

addr3:
    auipc s0, 0xfffff
    la s1, addr3
    li s2, 0xfffffffffffffffffffffffffffff000
    add s1, s1, s2
    //prgchk gdb $s0 == $s1

addr4:
    auipc s0, 0x80000
    la s1, addr4
    li s2, 0xffffffffffffffffffffffff80000000
    add s1, s1, s2
    //prgchk gdb $s0 == $s1

addr5:
    auipc s0, 0x76543
    la s1, addr5
    li s2, 0x76543000
    add s1, s1, s2
    //prgchk gdb $s0 == $s1

addr6:
    auipc s0, 0xdeadb
    la s1, addr6
    li s2, 0xffffffffffffffffffffffffdeadb000
    add s1, s1, s2
    //prgchk gdb $s0 == $s1

addr7:
    auipc s0, 0
    la s1, after_skip
    jalr zero, s1, 0
    //prgchk err Shouldn't be here
    nop

    .skip 4194304, 0

after_skip:
    la s1, addr7
    //prgchk gdb $s0 == $s1
    // Indirect jump, the exit symbol is to far for j because of the enormous skip
    la s0, exit
    jalr x0, s0, 0
