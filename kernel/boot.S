#include "utils_defs.S"
#include "insns.S"

#include "constants.h"

/*
 * Initial boot module, this is where the kernel takes over from the BIOS.
 * Here, we only setup a stack, enable interrupts, and jump to kernel_start,
 * ensuring we're in machine mode to continue initialization.
 */

.section .rodata
    splash_msg: .asciz "Kernel boot started\n"

.section .data
m_stack_base: .skip MACHINE_STACK_SIZE, 0
m_stack_top:  .skip TYPE_OFF, 0
.align 16

.section .text.init,"ax",@progbits
.globl _start
_start:
    la sp, m_stack_top

    // Throw all harts but one into a wfi loop during startup.
    csrr t0, mhartid
    bnez t0, park_hart

    // clear bss with zeroes for safety
    jal clear_bss
    jal setup_console_io

    // show a short startup message
    la a0, splash_msg
    jal puts

    // Clear satp just to be safe.
    csrw satp, zero

    // Setup mstatus to enable interrupts,
    // setup the trap vector, and make sure we're going into machine mode after mret.
    li t0, (0b11 << 11) | (1 << 7) | (1 << 3)
    csrw mstatus, t0
    la t0, kernel_start
    csrw mepc, t0
    la t0, trap_vector_asm
    csrw mtvec, t0
    li t0, (1 << 3) | (1 << 7) | (1 << 11)
    csrw mie, t0
    
    la ra, park_hart
    mret
j exit

clear_bss:
    la t0, _bss_start
    la t1, _bss_end

    j .Lcbss_chk
.Lcbss_bdy:
    sb zero, 0(t0)
    addi t0, t0, 1

.Lcbss_chk:
    blt t0, t1, .Lcbss_bdy
    ret

park_hart:
    wfi
    j park_hart
