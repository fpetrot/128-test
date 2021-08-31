#include "insns.S"
#include "utils.S"
#include "multisize_helper.S"

/** 
 *  Largest-Prime Factor performance test
 *  Uses a brute force algorthm to fin the largest prime factor of 
 *  a somewhat large integer. Mainly tests integer division and multiplication.
 */
 
#ifndef TEST_IN
#warning TEST_IN input macro not defined, using default !
#define TEST_IN 12345
#endif

.section .bss
    buf_putint: .fill 256, 1, 0
    
.section .rodata
    str_arr: .asciz " => "

.section .text.init,"ax",@progbits
.globl _start
_start:
# We're in bare metal, so set stack at the end of physical memory
la      sp, _memory_end
j main

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
    addi sp, sp, -TYPE_OFF
    store(ra, 0, sp)
    addi sp, sp, -TYPE_OFF
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
    addi sp, sp, TYPE_OFF
    load(ra, 0, sp)
    addi sp, sp, TYPE_OFF
    ret

// void putint(uint v)
putint:
    addi sp, sp, -TYPE_OFF
    store(ra, 0, sp)

    la t0, buf_putint
    addi t0, t0, 256

pi_dw_bdy:
    li t1, 10
    remu t2, a0, t1

    // Compute ASCII digit and store it to buf.
    addi t2, t2, '0'
    andi t2, t2, 0xff
    addi t0, t0, -1
    sb t2, 0(t0)

    divu a0, a0, t1

pi_dw_cnd:
    bnez a0, pi_dw_bdy

    mv a0, t0
    jal puts

    load(ra, 0, sp)
    addi sp, sp, TYPE_OFF
    ret

// bool is_prime(uint val)
is_prime:
    addi sp, sp, -TYPE_OFF
    store(ra, 0, sp)

    li t0, 2
j is_prime_forchk
is_prime_forbdy:
    rem t1, a0, t0
    bnez t1, is_prime_nondiv

    li a0, 0
    j is_prime_ret

is_prime_nondiv:
    addi t0, t0, 1
is_prime_forchk:
    mul t1, t0, t0
    ble t1, a0, is_prime_forbdy

    li a0, 1 

is_prime_ret:
    load(ra, 0, sp)
    addi sp, sp, TYPE_OFF
    ret

// uint next_prime(uint val)
next_prime:
    addi sp, sp, -TYPE_OFF
    store(ra, 0, sp)
    addi sp, sp, -TYPE_OFF
    store(s0, 0, sp)

    addi s0, a0, 1
    j next_prime_wchk
next_prime_wbdy:
    addi s0, s0, 1

next_prime_wchk:
    mv a0, s0
    jal is_prime
    beqz a0, next_prime_wbdy

    mv a0, s0

    load(s0, 0, sp)
    addi sp, sp, TYPE_OFF
    load(ra, 0, sp)
    addi sp, sp, TYPE_OFF
    ret

// uint lpf(uint val)
lpf:
    addi sp, sp, -TYPE_OFF
    store(ra, 0, sp)
    addi sp, sp, -TYPE_OFF
    store(s0, 0, sp)
    addi sp, sp, -TYPE_OFF
    store(s1, 0, sp)
    addi sp, sp, -TYPE_OFF
    store(s2, 0, sp)

    li s0, 1
    mv s2, s0
    mv s1, a0
    j lpf_wchk
lpf_wbdy:
    mv a0, s2
    jal next_prime

    rem t0, s1, a0
    bnez t0, lpf_nodiv

    mv s0, a0
lpf_nodiv:
    mv s2, a0
lpf_wchk:
    blt s2, s1, lpf_wbdy

    mv a0, s0
    
    load(s2, 0, sp)
    addi sp, sp, TYPE_OFF
    load(s1, 0, sp)
    addi sp, sp, TYPE_OFF
    load(s0, 0, sp)
    addi sp, sp, TYPE_OFF
    load(ra, 0, sp)
    addi sp, sp, TYPE_OFF
    ret

main:
    addi sp, sp, -TYPE_OFF
    store(ra, 0, sp)

    li a0, TEST_IN
    jal putint
    la a0, str_arr
    jal puts
    
    li a0, TEST_IN
    jal lpf
    jal putint
    li a0, '\n'
    jal putchar

    load(ra, 0, sp)
    addi sp, sp, TYPE_OFF
j exit
