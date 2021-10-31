#include "insns.S"
#include "utils_defs.S"

.altmacro
.macro disp_gp i
    mv a0, x\i
    jal putint_hex
    jal put_newline
.endm

.section .rodata
    trap_msg: .asciz "Trapped !\n"
    msg_trapregs:   .asciz "Trap info register values :\n"
    msg_mcause:     .asciz "mcause  =   0x"
    msg_mepc:       .asciz "mepc    =   0x"
    msg_mtval:      .asciz "mtval   =   0x"
    msg_mhartid:    .asciz "mhartid =   0x"
    msg_mstatus:    .asciz "mstatus =   0x"
    msg_gpregs:     .asciz "GPR Values : \n"
    panic_default_msg: .asciz "The kernel has panicked ! Hanging...\n"

    name_x1: .asciz "ra"
    name_x2: .asciz "sp"
    name_x3: .asciz "gp"


.section .text
// __noreturn void panic(const char* msg)
.global panic
panic:
    beqz a0, .Lpanic_nomsg
    jal puts
    jal put_newline
.Lpanic_nomsg:
    la a0, panic_default_msg
    jal puts
.Lpanic_hang:
    j .Lpanic_hang

.option norvc
.global trap_vector_asm
.align 4 // We must align the trap_vector to an instruction length.
trap_vector_asm:
    csrw satp, zero

    la a0, trap_msg
    jal puts

    la a0, msg_trapregs
    jal puts

    la a0, msg_mepc
    jal puts
    csrr a0, mepc
    li a1, 128
    jal putint_hex
    jal put_newline

    la a0, msg_mcause
    jal puts
    csrr a0, mcause
    li a1, 128
    jal putint_hex
    jal put_newline

    la a0, msg_mtval
    jal puts
    csrr a0, mtval
    li a1, 128
    jal putint_hex
    jal put_newline

    la a0, msg_mhartid
    jal puts
    csrr a0, mhartid
    li a1, 128
    jal putint_hex
    jal put_newline

    la a0, msg_mstatus
    jal puts
    csrr a0, mstatus
    li a1, 128
    jal putint_hex
    jal put_newline

    j exit

.Ltrap_loop:
    wfi
    j .Ltrap_loop