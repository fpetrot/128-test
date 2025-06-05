#include "femto.h"
#include "arch/riscv/csr.h"
#include "arch/riscv/trap.h"
#include "arch/riscv/encoding.h"
#include "arch/riscv/machine.h"

extern int __go;

/* Not so poor's man lock */
void lock(unsigned int *l)
{
    asm volatile("   li t0, 1 \n\t"
                 "1: lw t1, (a0) \n\t"
                 "   bnez t1, 1b \n\t"
                 "   amoswap.w.aq t1, t0, (a0) \n\t"
                 "   bnez t1, 1b \n\t");
}

void unlock(unsigned int *l)
{
    asm volatile("   amoswap.w.rl x0, x0, (a0)\n");
}

void cpun_workload(unsigned int id)
{
    static unsigned int biglock = 0;

    while (1) {
        lock(&biglock);
        printf("Workload number %d\n", id);
        for (volatile int i = 0; i < 1000; i++) {
            /* Not much */
        }
        unlock(&biglock);
    }
}

int main(int argc, char **argv)
{
    /* No CPU will execute this before CPU0 does */
    if (__go == 0) {
        printf("CPU0 booting\n");
        __go = 1;
    }
    unsigned int id = read_csr(mhartid);
    cpun_workload(id);
    wfi();
}
