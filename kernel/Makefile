CROSS_GCC=riscv64-elf-gcc
CROSS_LD=riscv64-elf-ld
CFLAGS=-I../common/include -O0 -g -march=rv64imafdc -mabi=lp64d -DTYPE_SIZE=128
LDFLAGS=--no-relax -g -T link.ld
QEMU_128=../../qemu-128/build_128/qemu-system-riscv128

TARGET=kernel.bin
ASM_SRCS=boot.S utils.S start.S trap.S paging.S main.S io_uart.S pmp.S
C_SRCS=data.c

ASM_OBJS=$(addsuffix .o, $(basename $(ASM_SRCS)))
C_OBJS=$(addsuffix .o, $(basename $(C_SRCS)))

kernel.bin: $(ASM_OBJS) $(C_OBJS)
	$(CROSS_LD) $(LDFLAGS) $^ -o $@

$(ASM_OBJS): $(ASM_SRCS)
	$(CROSS_GCC) $(CFLAGS) -c $(addsuffix .S, $(basename $@)) -o $@

$(C_OBJS): $(C_SRCS)
	$(CROSS_GCC) $(CFLAGS) -c $(addsuffix .c, $(basename $@)) -o $@

run: kernel.bin
	$(QEMU_128) -nographic -bios none -smp 4 -machine virt -kernel $<

.PHONY: clean
clean:
	rm -rf $(TARGET) $(ASM_OBJS) $(C_OBJS)