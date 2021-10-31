#include <stdint.h>

#include "constants.h"

/** Human-readble name for virtual memory schemes. */
const char *const mode_names[] = {
    [VM_BARE] = "Bare",
    [VM_SV44] = "Sv44",
    [VM_SV54] = "Sv54"
};

const char *const register_abi_names[32] = {
    "zero",
    "ra",
    "sp",
    "gp",
    "tp",
    "t0",
    "t1",
    "t2",
    "s0",
    "s1",
    "a0",
    "a1",
    "a2",
    "a3",
    "a4",
    "a5",
    "a6",
    "a7",
    "s2",
    "s3",
    "s4",
    "s5",
    "s6",
    "s7",
    "s8",
    "s9",
    "s10",
    "s11",
    "t3",
    "t4",
    "t5",
    "t6"
};