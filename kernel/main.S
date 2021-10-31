#include "utils_defs.S"
#include "insns.S"

#include "constants.h"

.section .rodata
    splash_supervisor: .asciz "We made it to supervisor mode !\n"
    msg_vm: .asciz "Using virtual memory scheme : "

.section .text
get_vm_mode:
    csrr t0, satp
    li t1, 0xff
    slli(t1, t1, 120)
    and t0, t0, t1
    srli(a0, t0, 120)

    ret

.global jump_to_supervisor_mode
jump_to_supervisor_mode:
    jal setup_pmp

    li t0, MSTATUS_MPP_S | MSTATUS_SPIE
    csrw mstatus, t0

    la t1, s_main
    csrw mepc, t1

    mret

display_vm_msg:
    addi sp, sp, -16
    sq(ra, 0, sp)

    la a0, msg_vm
    jal puts

    jal get_vm_mode
    la t0, mode_names
    slli(a0, a0, 3)
    add t0, t0, a0
    ld a0, 0(t0)
    jal puts
    jal put_newline

    lq(ra, 0, sp)
    addi sp, sp, 16
    ret

s_main:
    la a0, splash_supervisor
    jal puts

    jal display_vm_msg

.Lecho_loop:
    jal getchar
    jal putchar

    j .Lecho_loop
    
.Lidle_loop:
    wfi
    j .Lidle_loop