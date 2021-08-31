#include "insns.S" 
#include "utils.S"

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

#ifndef REPEATS
#define REPEATS 1
#endif

.section .rodata
    okay_str: .asciz "Check okay\n"
    bad_str:  .asciz "Check failed\n"
    alert_str: .asciz "OOOOOOOOOOOOOOOOOOOOOOO\n"

    label_fw: .dword label_bw
    label_bw: .dword label_fw

.section .bss
    buf_putint: .fill 256, 1, 0
    
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

// Search an unsigned value in bst
// bool search(const bst_node* bst, uint value)
#define BST_SEARCH_STACKSPACE 2
.global bst_search
bst_search:
    addi sp, sp, -BST_SEARCH_STACKSPACE * TYPE_OFF
    store(ra, 0 * TYPE_OFF, sp)
    store(s0, 1 * TYPE_OFF, sp)

    mv s0, a0

    bnez s0, bst_srch_nonnull
    li a0, 0
    j bst_srch_end

bst_srch_nonnull:
    load(t0, 0, s0)
    bltu a1, t0, bst_srch_lt
    bgtu a1, t0, bst_srch_gt

    // Value found (is current node)
    li a0, 1
    j bst_srch_end

bst_srch_lt:
    load(a0, TYPE_OFF, s0)

    jal bst_search

    j bst_srch_end

bst_srch_gt: 
    load(a0, 2 * TYPE_OFF, s0)

    jal bst_search

    j bst_srch_end

bst_srch_end:
    load(s0, 1 * TYPE_OFF, sp)
    load(ra, 0 * TYPE_OFF, sp)
    addi sp, sp, BST_SEARCH_STACKSPACE * TYPE_OFF
    ret

#define SAC_STACKSPACE 4
search_and_check:
    addi sp, sp, -SAC_STACKSPACE * TYPE_OFF
    store(ra, 0 * TYPE_OFF, sp)
    store(s0, 1 * TYPE_OFF, sp)
    store(s1, 2 * TYPE_OFF, sp)
    store(s2, 3 * TYPE_OFF, sp)

    li s0, 0
j main_check_forchk
main_check_forbdy:
    la t0, search_tab
    slli t1, s0, TYPE_SHFT
    add t0, t0, t1
    load(a1, 0, t0)

    la a0, bst_root

    jal bst_search

    la t0, res_tab
    add t0, t0, s0
    lbu t0, 0(t0)

    bne a0, t0, main_check_fail

    addi s0, s0, 1
main_check_forchk:
    la t0, search_size
    load(t0, 0, t0)
    bltu s0, t0, main_check_forbdy

    j main_check_succ
main_check_fail:
    la a0, bad_str
    jal puts
    mv a0, s0
    jal putint
    j main_end
main_check_succ:
    la a0, okay_str
    jal puts
main_end:
    load(s2, 3 * TYPE_OFF, sp)
    load(s1, 2 * TYPE_OFF, sp)
    load(s0, 1 * TYPE_OFF, sp)
    load(ra, 0 * TYPE_OFF, sp)
    addi sp, sp, SAC_STACKSPACE * TYPE_OFF
    ret

#define MAIN_STACKSPACE 2
.global main
main:
    addi sp, sp, -SAC_STACKSPACE * TYPE_OFF
    store(ra, 0 * TYPE_OFF, sp)
    store(s0, 1 * TYPE_OFF, sp)

    li s0, 0
    j mainloop_chk
mainloop_bdy:
    jal search_and_check

    addi s0, s0, 1

mainloop_chk:
    la t0, repeat_cnt
    load(t0, 0, t0)
    bltu s0, t0, mainloop_bdy

    load(s0, 1 * TYPE_OFF, sp)
    load(ra, 0 * TYPE_OFF, sp)
    addi sp, sp, SAC_STACKSPACE * TYPE_OFF