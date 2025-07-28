// See LICENSE for license details.

#include "femto.h"
#include "arch/riscv/csr.h"
#include "arch/riscv/trap.h"
#include "arch/riscv/encoding.h"
#include "arch/riscv/machine.h"

static pmp_info_t pmp_info = {
    .width = -1,
    .count = -1,
    .granularity = -1
};

static void trap_save_cause(uintptr_t* regs, uintptr_t mcause, uintptr_t mepc)
{
    write_csr(mepc, mepc + 4);
}

pmp_info_t pmp_probe()
{
#if 0
    trap_fn save;

    if (pmp_info.count >= 0) {
        return pmp_info;
    }

    /* loop through PMPs checking we can set any bits */
    save = get_trap_fn();
    set_trap_fn(trap_save_cause);
    pmp_info.count = 0;
    for (size_t i = 0; i < PMPADDR_COUNT; i++) {
        uintptr_t addr, addrsave = read_csr_enum(csr_pmpaddr0 + i);
        write_csr_enum(csr_pmpaddr0 + i, -1UL);
        addr = read_csr_enum(csr_pmpaddr0 + i);
        write_csr_enum(csr_pmpaddr0 + i, addrsave);
        if (addr) {
            pmp_info.count++;
            if (i == 0) {
                pmp_info.width = (sizeof(addr) << 3) - clz(addr) + 2;
                pmp_info.granularity = ctz(addr) + 2;
            }
        } else {
            if (i == 0) {
                pmp_info.width = 0;
                pmp_info.granularity = 0;
            }
            break;
        }
    }
    set_trap_fn(save);

    return pmp_info;
#endif
}

int pmp_entry_width()
{
    if (pmp_info.width < 0) {
        pmp_probe();
    }
    return pmp_info.width;
}

int pmp_entry_granularity()
{
    if (pmp_info.granularity < 0) {
        pmp_probe();
    }
    return pmp_info.granularity;
}

int pmp_entry_count()
{
    if (pmp_info.count < 0) {
        pmp_probe();
    }
    return pmp_info.count;
}

void pmp_clear_all()
{
    trap_fn save = get_trap_fn();
    set_trap_fn(trap_save_cause);
    for (size_t i = 0; i < PMPCFG_COUNT; i++) {
        write_csr_enum(csr_pmpcfg0 + i, 0);
    }
    for (size_t i = 0; i < PMPADDR_COUNT; i++) {
        write_csr_enum(csr_pmpaddr0 + i, 0);
    }
    set_trap_fn(save);
}

void pmp_allow_all()
{
    const uintptr_t pmpc = PMP_NAPOT | PMP_R | PMP_W | PMP_X;

    if (pmp_entry_count() == 0) {
        return;
    }

    pmp_clear_all();

    /* borrowed from bbl  */
    asm volatile ("la t0, 1f\n\t"
                  "csrrw t0, mtvec, t0\n\t"
                  "csrw pmpaddr0, %1\n\t"
                  "csrw pmpcfg0, %0\n\t"
                  ".align 2\n\t"
                  "1: csrw mtvec, t0"
                  : : "r" (pmpc), "r" (-1UL) : "t0");
}

int pmp_entry_set(unsigned n, uint8_t prot, uint64_t addr, uint64_t len)
{
#if 0
    /* check parameters */
    if (n >= PMPADDR_COUNT || len < 4 || !ispow2(len)) {
        return -1;
    }

    /* calculate PMP config register and offset */
    int pmpcfg_csr = (__riscv_xlen == 32) ? csr_pmpcfg0 + (n >> 2) :
                     (__riscv_xlen == 64) ? csr_pmpcfg0 + (n >> 2) & ~1 : -1;
    int pmpcfg_shift = (__riscv_xlen == 32) ? (n & 3) << 3 :
                       (__riscv_xlen == 64) ? (n & 7) << 3 : -1;
    if (pmpcfg_csr < 0 || pmpcfg_shift < 0) {
        return -1;
    }

    /* encode config */
    prot |= (len == 4) ? PMP_NA4 : PMP_NAPOT;
    uintptr_t pmpcfg = ((uintptr_t)prot) << pmpcfg_shift;
    uintptr_t cfgmask = ~(0xff << pmpcfg_shift);

    /* encode address */
    int pmpaddr_csr = csr_pmpaddr0 + n;
    uintptr_t pmpmask = (1UL << (ctz(len) - PMP_SHIFT)) - 1;
    uintptr_t pmpaddr = ((addr >> PMP_SHIFT) & ~pmpmask) | (pmpmask >> 1);

    /* write csrs */
    pmpcfg |= (read_csr_enum(pmpcfg_csr) & cfgmask) | pmpcfg;
    write_csr_enum(pmpcfg_csr, pmpcfg);
    write_csr_enum(pmpaddr_csr, pmpaddr);

    return 0;
#endif
}
