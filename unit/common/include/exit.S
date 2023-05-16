#pragma once

#include "insns.S"

.section .data
    putint_buf: .fill 4096, 1, 0
.section .text

.global exit
exit:
    li  t0, 0x100000
    li  t1, 0xde003333
    sw  t1, 0(t0)
    wfi
j       exit

// Macro to remplace li pseudoinstruction that doesn't sign-extends 64-bit values to 128-bits ( ~ load immediate unsigned).
#define liu(rd, imm64) li rd, imm64; slli(rd, rd, 64); srli(rd, rd, 64)
#define mov(rd, rs) addi rd, rs, 0
// Quad load-global macro
#define lqg(rd, symb) la rd, symb; lq(rd, 0, rd);
// Load unsigned dword global macro
#define ldug(rd, symb) la rd, symb; ldu(rd, 0, rd);