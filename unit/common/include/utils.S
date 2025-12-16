#pragma once

// Macro to remplace li pseudoinstruction that doesn't sign-extends
// 64-bit values to 128-bits ( ~ load immediate unsigned).
#define liu(rd, imm64) li rd, imm64; slli rd, rd, 64; srli rd, rd, 64
// Quad load-global macro
#define lqg(rd, symb) la rd, symb; lq(rd, 0, rd);
// Load unsigned dword global macro
#define ldug(rd, symb) la rd, symb; ldu(rd, 0, rd);
