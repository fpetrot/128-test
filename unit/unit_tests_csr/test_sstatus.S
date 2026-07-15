#include "insns.S" 
#include "utils.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Check RV128 is running
    csrr s0, misa
    //prgchk reg s1 == 3

    // Minimal pmp settings
    // Just the opposite of Unix file permissions!
#define PMP_NAPOT 0x18
#define PMP_R     0x01
#define PMP_W     0x02
#define PMP_X     0x04

    li s0, -1
    csrw pmpaddr0, s0
    li s0, PMP_NAPOT | PMP_R | PMP_W | PMP_X
    csrw pmpcfg0, s0

    la s0, backm
    csrw mtvec, s0

    // Set MPP to supervisor
    csrr s0, mstatus
    li s1, ~0x1800 // mask
    and s1, s1, s0
    li s0, 0x0800  // supervisor
    or s1, s1, s0
    csrw mstatus, s1
    // Change to supervisor mode
    la s0, 1f
    csrw mepc, s0
    mret
1:
    // Check UXL is set to RV128
    csrr s0, sstatus
    andi s1, s1, 0x3
    // Make sure SD is zero
    //prgchk reg s1 == 0x00000000000000003000000000000000

    // Mark FPU dirty to check for SD
    .equiv   MSTATUS_FS, 0x00006000
    li  s0,  MSTATUS_FS
    csrs     sstatus, s0
    // Do some fun useless computation
    fmadd.s  f3, f2, f1, f0
    fmax.s   f0, f1, f2
    // Check SD has changed where expected
    csrr s0, sstatus
    //prgchk reg s1 == 1
    // Mark FPU clean (2 in FS place)
    li  s0, ~0x00004000
    csrc     sstatus, s0
    csrr s0, sstatus
    //prgchk reg s1 == 0

    // Let's go back to machine mode to exit
    ecall

    // mtvec bit 1:0 indicate mode, 00 is Direct, what
    // we want in this simple test
    .align 4
backm:
    j exit
