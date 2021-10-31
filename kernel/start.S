#include "insns.S"
#include "utils_defs.S"

.section .rodata
splash_msg: .asciz "Kernel booted, starting up...\n"
idle_msg: .asciz "Startup finished, entering idle loop\n"
sswitch_msg: .asciz "Switching to supervisor mode...\n"

.section .text
.global kernel_start
kernel_start:
    la a0, splash_msg
    jal puts

    // Kernel setup here.
    jal init_paging
    
    jal setup_kernel_pages
    
    la a0, sswitch_msg
    jal puts
    
    jal jump_to_supervisor_mode

    la a0, idle_msg
    jal puts
.Lkernel_idle:
    wfi
    j .Lkernel_idle

