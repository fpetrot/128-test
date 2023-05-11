#include "insns.S" 
#include "utils.S"

.section .text.init,"ax",@progbits
.globl _start
_start:
    // Check RV128 is running
    csrr t0, misa
    srli(t1, t0, 126)
    //prgchk reg t1 == 3

    // Minimal pmp settings
    // Just the opposite of Unix file permissions!
#define PMP_NAPOT 0x18
#define PMP_R     0x01
#define PMP_W     0x02
#define PMP_X     0x04

    li t0, -1
    csrw pmpaddr0, t0
    li t0, PMP_NAPOT | PMP_R | PMP_W | PMP_X
    csrw pmpcfg0, t0

    la t0, backm
    csrw mtvec, t0

    // Set MPP to supervisor
    csrr t0, mstatus
    li t1, ~0x1800 // mask
    and t1, t1, t0
    li t0, 0x0800  // supervisor
    or t1, t1, t0
    csrw mstatus, t1
    // Change to supervisor mode
    la t0, 1f
    csrw mepc, t0
    mret
1:
    // Check UXL is set to RV128
    csrr t0, sstatus
    srli(t1, t0, 32)
    andi t1, t1, 0x3
    //prgchk reg t1 == 0x3
    // Make sure SD is zero
    srli(t1, t0, 127)
    //prgchk reg t1 == 0

    // Mark FPU dirty to check for SD
    .equiv   MSTATUS_FS, 0x00006000
    li  t0,  MSTATUS_FS
    csrs     sstatus, t0
    // Do some fun useless computation
    fmadd.s  f3, f2, f1, f0
    fmax.s   f0, f1, f2
    // Check SD has changed where expected
    csrr t0, sstatus
    srli(t1, t0, 127)
    //prgchk reg t1 == 1
    // Mark FPU clean (2 in FS place)
    li  t0, ~0x00004000
    csrc     sstatus, t0
    csrr t0, sstatus
    srli(t1, t0, 127)
    //prgchk reg t1 == 0

    // Let's go back to machine mode to exit
    ecall

    // mtvec bit 1:0 indicate mode, 00 is Direct, what
    // we want in this simple test
    .align 4
backm:
    j exit
