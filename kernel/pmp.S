#include "utils_defs.S"
#include "insns.S"

#include "constants.h"

.global setup_pmp
setup_pmp:
    // Create an all encompassing PMP rule allowng RWX.
    csrw pmpcfg0, zero
    csrw pmpcfg1, zero
    csrw pmpcfg2, zero
    csrw pmpcfg3, zero

    xor t0, t0, t0
    addi t0, t0, -1
    csrw pmpaddr0, t0

    li t0, PMPCFG_R | PMPCFG_W | PMPCFG_X | PMPCFG_A_TOR | PMPCFG_L
    csrw pmpcfg0, t0

    ret