#pragma once

#include "insns.S"
#include "utils.S"

#define UART_BASE 0x10000000
#define UART_TXFIFO 0

.global putchar128
putchar128:
    andi t0, a0, 0xff
    liu(t1, UART_BASE)
    liu(t2, UART_TXFIFO)
    slli t2, t2, 4
    add t1, t1, t2
    sw t0, 0(t1)

    ret

.global putstr128
putstr128:
    addi sp, sp, -16
    sq(ra, 0, sp)
    addi sp, sp, -16
    sq(s0, 0, sp)

    mov(s0, a0)

    j putstr_cndchk
putstr_body:
    lb a0, 0(s0)
    jal putchar128

    addi s0, s0, 1
    
putstr_cndchk:
    lbu t0, 0(s0)
    bnez t0, putstr_body

    lq(s0, 0, sp)
    addi sp, sp, 16
    lq(ra, 0, sp)
    addi sp, sp, 16
    ret


// (uint128, uint128) soft_remdiv(uint128 val, uint128 div) 
// returns (val / div, val % div)
soft_remdiv:
    mov(t0, zero)
    mov(t1, a0)
    j remdiv_condchk
remdiv_body:
    sub t1, t1, a1
    addi t0, t0, 1

remdiv_condchk:
    bgeu t1, a1, remdiv_body
    
    mv a0, t0
    mv a1, t1

    ret

.global putint_u128
putint_u128:
    addi sp, sp, -16
    sq(ra, 0, sp)
    addi sp, sp, -16
    sq(s0, 0, sp)
    addi sp, sp, -16
    sq(s1, 0, sp)

    mov(s0, a0)
    li s1, 4095
    
    // putint_buf[4095] = '\0'
    la t0, putint_buf
    add t0, t0, s1
    mov(t1, zero)
    sb t1, 0(t0)
    
    j putint_u128_whilechk
putint_u128_whilebody:
    mov(a0, s0)
    liu(a1, 10)
    jal soft_remdiv
    mov(s0, a0)
    addi t0, a1, '0'

    addi s1, s1, -1
    la t1, putint_buf
    add t1, t1, s1
    sb t0, 0(t1)

putint_u128_whilechk:
    mov(t0, zero)
    bne s0, t0, putint_u128_whilebody
    
    la a0, putint_buf
    add a0, a0, s1
    jal putstr128
    
    lq(s1, 0, sp)
    addi sp, sp, 16
    lq(s0, 0, sp)
    addi sp, sp, 16
    lq(ra, 0, sp)
    addi sp, sp, 16
    ret

.global putint_i128
putint_i128:
    addi sp, sp, -16
    sq(ra, 0, sp)
    addi sp, sp, -16
    sq(s0, 0, sp)

    bgez a0, putint_i128_noinv
    mv s0, a0

    li a0, '-'
    jal putchar128

    li t0, 0
    sub a0, t0, s0

putint_i128_noinv:
    jal putint_u128

    lq(s0, 0, sp)
    addi sp, sp, 16
    lq(ra, 0, sp)
    addi sp, sp, 16
    ret