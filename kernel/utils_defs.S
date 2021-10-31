#pragma once

#define load(rd, imm, rs1) lq(rd, imm, rs1)
#define store(rs2, imm, rs1) sq(rs2, imm, rs1)
#define TYPE_OFF 16
#define TYPE_SHFT 4
#define TYPE_NALIGN 16

// Macro to remplace li pseudoinstruction that doesn't sign-extends 64-bit values to 128-bits ( ~ load immediate unsigned).
#define liu(rd, imm64) li rd, imm64; slli(rd, rd, 64); srli(rd, rd, 64)
#define mov(rd, rs) addi rd, rs, 0
// Quad load-global macro
#define lqg(rd, symb) la rd, symb; lq(rd, 0, rd);
// Load unsigned dword global macro
#define ldug(rd, symb) la rd, symb; ldu(rd, 0, rd);