#include "exit.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Check with null-immediate.
addr1:
    auipc t0, 0
    la t1, addr1
    //prgchk gdb $t0 == $t1
    
addr2:
    auipc t0, 1
    la t1, addr2
    li t2, 0x1000
    add t1, t1, t2
    //prgchk gdb $t0 == $t1

addr3:
    auipc t0, 0xfffff
    la t1, addr3
    li t2, 0xfffffffffffffffffffffffffffff000
    add t1, t1, t2
    //prgchk gdb $t0 == $t1

addr4:
    auipc t0, 0x80000
    la t1, addr4
    li t2, 0xffffffffffffffffffffffff80000000
    add t1, t1, t2
    //prgchk gdb $t0 == $t1

addr5:
    auipc t0, 0x76543
    la t1, addr5
    li t2, 0x76543000
    add t1, t1, t2
    //prgchk gdb $t0 == $t1

addr6:
    auipc t0, 0xdeadb
    la t1, addr6
    li t2, 0xffffffffffffffffffffffffdeadb000
    add t1, t1, t2
    //prgchk gdb $t0 == $t1

addr7:
    auipc t0, 0
    la t1, after_skip
    jalr zero, t1, 0
    //prgchk err Shouldn't be here
    nop
    .skip 4194304, 0
after_skip:
    la t1, addr7
    //prgchk gdb $t0 == $t1
    j exit
