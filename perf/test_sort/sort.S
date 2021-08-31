#include "insns.S" 
#include "utils.S"
#include "data.S"

#if TYPE_SIZE == 128
    #define load(rd, imm, rs1) lq(rd, imm, rs1)
    #define store(rs2, imm, rs1) sq(rs2, imm, rs1)
    #define TYPE_OFF 16
    #define TYPE_SHFT 4
#elif TYPE_SIZE == 64
    #define load(rd, imm, rs1) ld rd, imm(rs1)
    #define store(rs2, imm, rs1) sd rs2, imm(rs1)
    #define TYPE_OFF 8
    #define TYPE_SHFT 3
#elif TYPE_SIZE == 32
    #define load(rd, imm, rs1) lw rd, imm(rs1)
    #define store(rs2, imm, rs1) sw rs2, imm(rs1)
    #define TYPE_OFF 4
    #define TYPE_SHFT 2
#else
    #error "TYPE_SIZE must be 128, 64 or 32"
#endif

.section .rodata
    okay_str: .asciz "Check okay\n"
    bad_str:  .asciz "Check failed\n"

#define UART_BASE 0x10000000
#define UART_TXFIFO 0
putchar:
    andi t0, a0, 0xff
    li t1, UART_BASE
    li t2, UART_TXFIFO
    slli t2, t2, 4
    add t1, t1, t2
    sw t0, 0(t1)

    ret

.global putstr128
puts:
    addi sp, sp, -16
    store(ra, 0, sp)
    addi sp, sp, -16
    store(s0, 0, sp)

    mv s0, a0

    j putstr_cndchk
putstr_body:
    lb a0, 0(s0)
    jal putchar

    addi s0, s0, 1
putstr_cndchk:
    lbu t0, 0(s0)
    bnez t0, putstr_body

    load(s0, 0, sp)
    addi sp, sp, 16
    load(ra, 0, sp)
    addi sp, sp, 16
    ret


.section .text.init,"ax",@progbits
.globl _start
_start:
# We're in bare metal, so set stack at the end of physical memory
la      sp, _memory_end
j main

// void sort(uint128_t* tab, uint128_t tab_size)
// uint128_t switches <=> t0
// uint128_t i <=> t1
sort:
    addi sp, sp, -TYPE_OFF
    store(ra, 0, sp)
    
do_while_body:
    li t0, 0
    li t1, 0
    j for_condchk
for_body:
    // t2 <- &tab[i], t3 <- tab[i]
    slli t2, t1, TYPE_SHFT
    add t2, t2, a0
    load(t3, 0, t2)

    // t4 <- &tab[i + 1], t5 <- tab[i + 1]
    addi t4, t2, TYPE_OFF
    load(t5, 0, t4)

    ble t3, t5, if_switch_false
    // Switch the values
    store(t3, 0, t4)
    store(t5, 0, t2)

    addi t0, t0, 1

if_switch_false:
    addi t1, t1, 1

for_condchk:
    addi t2, a1, -1
    blt t1, t2, for_body

    // do-while condition check
    bnez t0, do_while_body

    load(ra, 0, sp)
    addi sp, sp, TYPE_OFF

    ret
    
// bool check(uint128_t* tab, uint128_t tab_size)
check:
    addi sp, sp, -TYPE_OFF
    store(ra, 0, sp)

    li t0, 0
    j check_forcond
check_forbody:
    slli t1, t0, TYPE_SHFT
    add t1, a0, t1
    load(t2, 0, t1)

    addi t1, t1, TYPE_OFF
    load(t3, 0, t1)

    ble t2, t3, check_cond_okay
    li a0, 0
    j check_ret

check_cond_okay:
    addi t0, t0, 1
check_forcond:
    addi t1, a1, -1
    blt t0, t1, check_forbody

    li a0, 1
check_ret:
    load(ra, 0, sp)
    addi sp, sp, TYPE_OFF
    ret

main:
    addi sp, sp, -TYPE_OFF
    store(ra, 0, sp)

    la a0, tab_start
    la a1, tab_size
    load(a1, 0, a1)
    jal sort

    la a0, tab_start
    la a1, tab_size
    load(a1, 0, a1)
    jal check

    bnez a0, load_ok 
    la a0, bad_str
    j load_after
load_ok:
    la a0, okay_str
load_after:
    jal puts

    load(ra, 0, sp)
    addi sp, sp, TYPE_OFF
j exit
