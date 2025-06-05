#include "femto.h"

#ifdef __riscv
#include "arch/riscv/encoding.h"
#include "arch/riscv/machine.h"
#include "arch/riscv/trap.h"
#endif

#define MTIMECMP_BASE	0x4000
#define MTIME_BASE	0xbff8

void machine_handler(uintptr_t* regs, uintptr_t mcause, uintptr_t mepc)
{
#if 0
	printf("Caught a trap @0x%p\n", mepc);
#endif
	putchar('.');
	uint64_t time = *(volatile uint64_t *) (CLINT_BASE + MTIME_BASE);
	*(volatile uint64_t *) (CLINT_BASE + MTIMECMP_BASE) = time + 1000000;
}

/* Don't mess around with these defines, they are here just for beauty */
#define PAGE_SHIFT 12
#define PAGE_SIZE  (1 << PAGE_SHIFT)
#define SV39 8

/* Assumption:
 * code address starts at PA = VA = 0000_0000_8000_0000
 * code (according to objdump) fits in three 4K pages
 * using (randomly) PA = 0000_0000_8001_0000 as base address
 * for the page table and PA = 0000_0000_8002_0000 as base
 * address for code and data
 */

#define BASE_MACHINE_ADDR (uint64_t *)0x80000000
#define CODE_SIZE         (4 * PAGE_SIZE)
#define BASE_PHYS_ADDR    (uint64_t *)0x80020000

/* Given our code, we need a single page per level of the hierarchy
 * We make them consecutive in memory */
#define PAGE_TABLE_ADDR (uint64_t)0x80010000
volatile uint64_t *pt1g = (uint64_t *)(PAGE_TABLE_ADDR + 0 * PAGE_SIZE);
volatile uint64_t *pt2m = (uint64_t *)(PAGE_TABLE_ADDR + 1 * PAGE_SIZE);
volatile uint64_t *pt4k = (uint64_t *)(PAGE_TABLE_ADDR + 2 * PAGE_SIZE);

int main(int argc, char **argv)
{
	/*
	 * Copy everything to supervisor area
	 * As soon as satp is changed, the copy will be used
	 */
	memcpy(BASE_PHYS_ADDR, BASE_MACHINE_ADDR, CODE_SIZE);

	/*
	 * Set up PMP (Physical Memory Protection)
	 *
	 * PMP is optional; bit if implemented enforcement is mandatory
	 * and user-mode is prevented access to all memory by default.
	 * We should change this code to restrict user mode to its .text
	 * .rodata, .data, .bss and devices.
	 */
#ifdef __riscv
	if (pmp_entry_count() > 0) {
		pmp_allow_all();
	}
	set_trap_fn(machine_handler);
	set_csr(mie, MIP_MTIP);
	set_csr(mstatus, MSTATUS_MIE);
	uint64_t time = *(volatile uint64_t *) (CLINT_BASE + MTIME_BASE);
	*(volatile uint64_t *) (CLINT_BASE + MTIMECMP_BASE) = time + 1000000;
        uint64_t status;
        status = read_csr(mstatus);
        printf("mstatus=0x%016x\n", status);
	mode_set_and_continue(PRV_S);
	puts("riscv-supervisor-mode");
        status = read_csr(sstatus);
        printf("sstatus=0x%016x\n", status);
        uint64_t satp_value = ((uint64_t)SV39 << 60) | (((uint64_t)pt1g) >> 12);
        /* Page mapping =>
           0x8000 0000 -> 0x8000 0fff mapped to 0x8002 0000 -> 0x8002 0fff
           0x8000 1000 -> 0x8000 1fff mapped to 0x8002 1000 -> 0x8002 1fff
           ...
           0x8000 7000 -> 0x8000 7fff mapped to 0x8002 7000 -> 0x8002 7fff
           VPN[2]    VPN[1]    VPN[0]    page  offset
           000000010 000000000 000000000 000000000000 -> 000000010 000000000 000000000 111111111111
           1G page table entry : 2
           2M page table entry : 0
           4K page table entry : 0 to 7, included
           PPN[2]    PPN[1]    PPN[0]    page  offset
           000000010 000000000 000100000 000000000000 -> 000000010 000000000 000100000 111111111111
        */
        /* io gigapage mapping, necessary for the console */
        pt1g[0] = ((uint64_t)0x00000000 >> 2) | 0b1111;

        /* 4k memory mapping */
        pt1g[2] = ((uint64_t)pt2m >> 2) | 1;  /* next level address and valid bit */
        pt2m[0] = ((uint64_t)pt4k >> 2) | 1;  /* next level address and valid bit */
	for (int i = 0; i < 8; i++) {
                /* physical address with xwr rights and valid bit */
		pt4k[i] = (((uint64_t)BASE_PHYS_ADDR + i * PAGE_SIZE) >> 2) | 0b1111;
        }

	/* Crossing fingers, ... */
        write_csr(satp, satp_value);

	while (1) {
		asm("wfi");
	}

#else /* !__risc_v */
        puts("architecture-not-supported");
	exit(1);
#endif
}
