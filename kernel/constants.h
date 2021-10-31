#pragma once

#ifndef __ASSEMBLER__
// C constants here
#endif

/** Size of the initial machine stack, in bytes. */
#define MACHINE_STACK_SIZE 8192

// Constants for both C and asm go here
#define VM_BARE 0
#define VM_SV44 12
#define VM_SV54 13

#define MSTATUS_UIE     (1 << 0)
#define MSTATUS_SIE     (1 << 1)
#define MSTATUS_MIE     (1 << 3)
#define MSTATUS_UPIE    (1 << 4)
#define MSTATUS_SPIE    (1 << 5)
#define MSTATUS_MPIE    (1 << 7)
#define MSTATUS_SPP     (1 << 8)
#define MSTATUS_MPP_M   (0b11 << 11)
#define MSTATUS_MPP_S   (0b01 << 11)
#define MSTATUS_MPP_U   (0b00 << 11)

#define PMPCFG_R        (1 << 0)
#define PMPCFG_W        (1 << 1)
#define PMPCFG_X        (1 << 2)
#define PMPCFG_A_OFF    (0b00 << 3)
#define PMPCFG_A_TOR    (0b01 << 3)
#define PMPCFG_A_NA4    (0b10 << 3)
#define PMPCFG_A_NAPOT  (0b11 << 3)
#define PMPCFG_L        (1 << 7)