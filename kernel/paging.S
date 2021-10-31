#include "insns.S"
#include "utils_defs.S"

#include "constants.h"

#define PTE_FLAG_V (1 << 0)
#define PTE_FLAG_R (1 << 1)
#define PTE_FLAG_W (1 << 2)
#define PTE_FLAG_X (1 << 3)
#define PTE_FLAG_U (1 << 4)
#define PTE_FLAG_G (1 << 5)
#define PTE_FLAG_A (1 << 6)
#define PTE_FLAG_D (1 << 7)

#define PAGE_SIZE 16384
#define PAGE_SIZE_SHFT 14
#define PTE_SHIFT 4
#define PTE_FLAGS_MASK 0b1111111111
#define VPN_MASK 0b1111111111
#define VPN2_SHIFT 34
#define VPN2_MASK (VPN_MASK << VPN2_SHIFT)
#define VPN1_SHIFT 24
#define VPN1_MASK (VPN_MASK << VPN1_SHIFT)
#define VPN0_SHIFT 14
#define VPN0_MASK (VPN_MASK << VPN0_SHIFT)
#define KERNEL_MMAP_FLAGS (PTE_FLAG_R | PTE_FLAG_W | PTE_FLAG_X | PTE_FLAG_A)

#define SATP_MODE 12 /* SV44 experimental mode */
#define SATP_PPN_MASK 0x3ffffffffffff
#define SATP_MODE_MASK 0xff
#define SATP_MODE_SHIFT 120

#define PTE_XWR_MASK (PTE_FLAG_R | PTE_FLAG_W | PTE_FLAG_X)
#define PTE_PPN2_MASK 0xfffffffc0000000
#define PTE_PPN2_SHFT 30
#define PTE_PPN1_MASK 0x3ff00000
#define PTE_PPN1_SHFT 20
#define PTE_PPN0_MASK 0xffc00
#define PTE_PPN0_SHFT 10
#define PTE_FLAG_BITS 10
#define PHYS_ADDR_MASK 0xffffffffffffffff

#define VADDR_PGOFF_MASK 0b11111111111111

.section .rodata
    pgtable_setup_start_msg: .asciz "Setting up kernel page table...\n"
    pgtable_setup_end_msg: .asciz "Kernel page table setup complete.\n"
    no_free_phys_pages_msg: .asciz "No physical pages left for allocation (OoM ?)"

.section .data
.global k_pgtable_ptr
k_pgtable_ptr:
    .octa 0

alloc_cnt: .octa 0

free_page_head:
    .octa 0

.section .text
// void init_paging(void)
// Initializes the linked list of free physical pages.
.global init_paging
init_paging:
    la t0, _free_memory_start
    la t1, _memory_end
    j .Lip_wchk // while ( t0 + PAGE_SIZE < mem_end)
.Lip_wbdy:
    li t2, PAGE_SIZE
    add t3, t0, t2
    sq(t3, 0, t0)

    mv t0, t3
.Lip_wchk:
    li t2, PAGE_SIZE
    add t3, t0, t2
    bltu t3, t1, .Lip_wbdy

    // set tail pointer to NULL
    sq(zero, 0, t0)

    // free_page_head <- _free_mem_start (set head of linked list)
    la t0, _free_memory_start
    la t1, free_page_head
    sq(t0, 0, t1)

    ret

// void* alloc_phys_page(void)
// Allocates and returns a physical page, returns NULL if none was found.
#define ALLOC_PHYS_PAGE_SS 2
.global alloc_phys_page
alloc_phys_page:
    addi sp, sp, -TYPE_OFF * ALLOC_PHYS_PAGE_SS
    sq(ra, 0 * TYPE_OFF, sp)
    sq(s0, 1 * TYPE_OFF, sp)

    la t0, free_page_head
    lq(a0, 0, t0) // a0 (retval) <- free_page_head
    bnez a0, .Lalloc_phys_page_freeleft
    la a0, no_free_phys_pages_msg
    jal panic
.Lalloc_phys_page_freeleft:
    lq(t1, 0, a0) // t1 <- *free_page_head
    sq(t1, 0, t0) // free_page_head = *free_page_head (pop head)

    mv s0, a0
    la t0, alloc_cnt
    lq(t1, 0, t0)
    addi t1, t1, 1
    sq(t1, 0, t0)

    // Clear page contents
    mv a1, zero
    li a2, PAGE_SIZE
    jal memset

    mv a0, s0

    lq(s0, 1 * TYPE_OFF, sp)
    lq(ra, 0 * TYPE_OFF, sp)
    addi sp, sp, TYPE_OFF * ALLOC_PHYS_PAGE_SS
    ret

// void free_phys_page(void* page)
// Frees the physical page containing the given physical address
#define FREE_PHYS_PAGE_SS 1
.global free_phys_page
free_phys_page:
    addi sp, sp, -TYPE_OFF * FREE_PHYS_PAGE_SS
    store(ra, 0 * TYPE_OFF, sp)

    // Make sure lower bits are cleared.
    li t0, PAGE_SIZE - 1
    not t0, t0
    and t0, t0, a0

    la t1, free_page_head
    lq(t2, 0, t1)

    sq(t2, 0, t0) // Set new head's next.
    sq(t0, 0, t1) // Set new head.

    lq(ra, 0 * TYPE_OFF, sp)
    addi sp, sp, TYPE_OFF * FREE_PHYS_PAGE_SS
    ret

// void map(table_root, phys_addr, virt_addr, flags, level)
// Maps a physical address to a virtual one (16 KiB pages only for now, level is ignored)
// a0 = table_root, a1 = phys_addr, a2 = virt_addr, a3 = flags, a4 = level
#define MAP_ADDR_SS 7
.global map_addr
map_addr:
    addi sp, sp, -TYPE_OFF * MAP_ADDR_SS
    store(ra, 0 * TYPE_OFF, sp)
    store(s0, 1 * TYPE_OFF, sp)
    store(s1, 2 * TYPE_OFF, sp)
    store(s2, 3 * TYPE_OFF, sp)
    store(s3, 4 * TYPE_OFF, sp)
    store(s4, 5 * TYPE_OFF, sp)
    store(s5, 6 * TYPE_OFF, sp)

    // Save arguments, this function is not a leaf.
    mv s0, a0
    mv s1, a1
    mv s2, a2
    mv s3, a3
    mv s4, a4

    li t0, VPN_MASK
    // Extract VPN[2] => s5
    srli s5, s2, VPN2_SHIFT
    and s5, s5, t0

    // Load level 2 PTE.
    slli t0, s5, PTE_SHIFT
    add t0, t0, s0
    lq(t0, 0, t0)

    // Check V bit.
    andi t1, t0, 1
    bnez t1, .Lmap_addr_lvl2_already_allocd
    // PTE isn't valid : allocate it to a sub-table
    jal alloc_phys_page // Allocate new page for sub-table.
    srli t0, a0, PAGE_SIZE_SHFT
    slli t0, t0, PTE_FLAG_BITS
    ori t0, t0, 1       // Set V bit to 1.

    // Store new PTE to page table.
    slli t1, s5, PTE_SHIFT
    add t1, t1, s0
    sq(t0, 0, t1)

.Lmap_addr_lvl2_already_allocd:
    // Level 2 PTE value is in t0 : PPN to LVL1 PT
    srli t1, t0, PTE_FLAG_BITS  // Convert to pointer to lvl 1 base
    slli t1, t1, PAGE_SIZE_SHFT
    mv s0, t1      // Replace original root

    li t0, VPN_MASK
    // Extract VPN[1] => s5
    srli s5, s2, VPN1_SHIFT
    and s5, s5, t0

    // Load level 1 PTE.
    slli t0, s5, PTE_SHIFT
    add t0, t0, s0
    lq(t0, 0, t0)

    // Check V bit for level 1.
    andi t1, t0, 1
    bnez t1, .Lmap_addr_lvl1_already_allocd
    // PTE LVL1 isn't valid: allocate
    jal alloc_phys_page
    srli t0, a0, PAGE_SIZE_SHFT
    slli t0, t0, PTE_FLAG_BITS
    ori t0, t0, 1

    // Store new PTE.
    slli t1, s5, PTE_SHIFT
    add t1, t1, s0
    sq(t0, 0, t1)

.Lmap_addr_lvl1_already_allocd:
    // Level 1 PTE value is in t0 : PPN to LVL 0 PT
    srli t1, t0, PTE_FLAG_BITS  // Convert to pointer to lvl 0 base
    slli t1, t1, PAGE_SIZE_SHFT
    mv s0, t1      // Replace original root

    li t0, VPN_MASK
    // Extract VPN[0] => s5
    srli s5, s2, VPN0_SHIFT
    and s5, s5, t0

    // Get level 0 PTE pointer.
    slli t0, s5, PTE_SHIFT
    add t0, t0, s0
    // TODO : Check if PTE already exists / is valid, and free it / make error.

    // Build PTE in t1.
    xor t1, t1, t1
    ori t1, t1, PTE_FLAG_V // Set V bit
    or t1, t1, s3 // Set other bits from flags argument
    // Make PPN from given physical address.
    srli t2, s1, PAGE_SIZE_SHFT
    slli t2, t2, PTE_FLAG_BITS
    // Assemble flags and PPN into PTE.
    or t1, t1, t2

    // Store new PTE.
    sq(t1, 0, t0)

    load(s5, 6 * TYPE_OFF, sp)
    load(s4, 5 * TYPE_OFF, sp)
    load(s3, 4 * TYPE_OFF, sp)
    load(s2, 3 * TYPE_OFF, sp)
    load(s1, 2 * TYPE_OFF, sp)
    load(s0, 1 * TYPE_OFF, sp)
    load(ra, 0 * TYPE_OFF, sp)
    addi sp, sp, TYPE_OFF * MAP_ADDR_SS

    ret

// void* get_physical_address(void* vaddr, void* page_table)
// Manual page walk using satp returns NULL if address is not mapped
.global get_physical_address
get_physical_address:
    csrr t0, satp

    srli(t1, t0, SATP_MODE_SHIFT)
    andi t1, t1, SATP_MODE_MASK
    li t2, SATP_MODE
    beq t1, t2, .Lgpa_mode_ok
    li a0, 0
    j .Lgpa_end
.Lgpa_mode_ok:
    liu(t1, SATP_PPN_MASK)
    and t0, t0, t1 // Mask out ASID and MODE
    slli t0, t0, PAGE_SIZE_SHFT // Get real PTB address.

    // Extract VPN[2]
    srli t1, a0, VPN2_SHIFT
    li t2, VPN_MASK
    and t1, t1, t2

    // Get LVL2 PTE
    slli t1, t1, PTE_SHIFT
    add t1, t1, t0
    lq(t1, 0, t1)

    andi t2, t1, PTE_FLAG_V
    bnez t2, .Lgpa_lvl2_valid
    li a0, 0
    j .Lgpa_end
.Lgpa_lvl2_valid:
    andi t2, t1, PTE_XWR_MASK
    beqz t2, .Lgpa_lvl2_nonleaf

    // This is a leaf PTE for a 16 GiB page.
    // Get PPN[2] from PTE, and position it for vaddr.
    li t2, PTE_PPN2_MASK
    and t2, t2, t1
    srli(t2, t2, PTE_PPN2_SHFT)
    slli(t2, t2, VPN2_SHIFT)

    // Get page offset (= VPN1 | VPN0 | pgoff)
    li t3, VPN1_MASK | VPN0_MASK | VADDR_PGOFF_MASK
    and t3, t3, a0

    or t2, t2, t3

    // Mask out bits over 64, if any.
    liu(t3, PHYS_ADDR_MASK)
    and a0, t2, t3
    j .Lgpa_end

.Lgpa_lvl2_nonleaf:
    // Non-leaf PTE : PPN to next level, convert to pointer to next base
    srli t4, t1, PTE_FLAG_BITS  // Convert to pointer to lvl 1 base
    slli t4, t4, PAGE_SIZE_SHFT

    // Get VPN[1] from vaddr
    srli t1, a0, VPN1_SHIFT
    li t2, VPN_MASK
    and t1, t1, t2

    // Get LVL1 PTE
    slli t1, t1, PTE_SHIFT
    add t1, t1, t4
    lq(t1, 0, t1)

    andi t2, t1, PTE_FLAG_V
    bnez t2, .Lgpa_lvl1_valid
    li a0, 0
    j .Lgpa_end
.Lgpa_lvl1_valid:
    andi t2, t1, PTE_XWR_MASK
    beqz t2, .Lgpa_lvl1_nonleaf

    // This is a leaf PTE for a 16 MiB page.
    // Get PPN[2] | PPN[1] from PTE, and position it for vaddr.
    li t2, PTE_PPN2_MASK | PTE_PPN1_MASK
    and t2, t2, t1
    srli(t2, t2, PTE_PPN1_SHFT)
    slli(t2, t2, VPN1_SHIFT)

    // Get page offset (= VPN0 | pgoff)
    li t3, VPN0_MASK | VADDR_PGOFF_MASK
    and t3, t3, a0

    or t2, t2, t3

    // Mask out bits over 64, if any.
    liu(t3, PHYS_ADDR_MASK)
    and a0, t2, t3
    j .Lgpa_end

.Lgpa_lvl1_nonleaf:
    // Non-leaf PTE : PPN to next level, convert to pointer to next base
    srli t4, t1, PTE_FLAG_BITS  // Convert to pointer to lvl 1 base
    slli t4, t4, PAGE_SIZE_SHFT

    // Extract VPN0
    srli t1, a0, VPN0_SHIFT
    li t2, VPN_MASK
    and t1, t1, t2

    // Get LVL0 PTE
    slli t1, t1, PTE_SHIFT
    add t1, t1, t4
    lq(t1, 0, t1)

    andi t2, t1, PTE_FLAG_V
    bnez t2, .Lgpa_lvl0_valid
    li a0, 0
    j .Lgpa_end

.Lgpa_lvl0_valid:
    andi t2, t1, PTE_XWR_MASK
    beqz t2, .Lgpa_lvl0_nonleaf

    // This is a leaf PTE for a 16 KiB page
    liu(t2, PTE_PPN2_MASK | PTE_PPN1_MASK | PTE_PPN0_MASK)
    and t2, t2, t1
    srli(t2, t2, PTE_FLAG_BITS)
    slli(t2, t2, PAGE_SIZE_SHFT)

    // Get page offset from vaddr
    li t3, VADDR_PGOFF_MASK
    and t3, t3, a0

    or t2, t2, t3

    // Mask out bits over 64, if any.
    li t3, PHYS_ADDR_MASK
    and a0, t2, t3
    j .Lgpa_end
    
.Lgpa_lvl0_nonleaf:
    // Level zero page with no flags (non-leaf) : error !
    li a0, 0
    j .Lgpa_end

.Lgpa_end:
    ret


// For kernel memory map, we map the whole memory space 1:1, using a single 16 GiB page
#define SETUP_KERNEL_PAGES_SS 2
.global setup_kernel_pages
setup_kernel_pages:
    addi sp, sp, -TYPE_OFF * SETUP_KERNEL_PAGES_SS
    sq(ra, 0 * TYPE_OFF, sp)
    sq(s0, 1 * TYPE_OFF, sp)

    la a0, pgtable_setup_start_msg
    jal puts

    // Allocate page for root kernel page table.
    jal alloc_phys_page
    mv s0, a0

    la t0, k_pgtable_ptr
    sq(s0, 0, t0)

    // Make a single 1:1 16 GiB page mapping for kernel.
    xor t1, t1, t1
    li t2, KERNEL_MMAP_FLAGS | PTE_FLAG_V
    or t1, t1, t2
    sq(t1, 0, s0)

    // Setup satp
    srli(t0, s0, PAGE_SIZE_SHFT)
    li t1, SATP_MODE
    slli(t1, t1, SATP_MODE_SHIFT)
    or t0, t0, t1

    csrw satp, t0

    lq(s0, 1 * TYPE_OFF, sp)
    lq(ra, 0 * TYPE_OFF, sp)
    addi sp, sp, TYPE_OFF * SETUP_KERNEL_PAGES_SS
    ret
