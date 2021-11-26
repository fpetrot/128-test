include ../config.mk

TEST_VALUE ?= 14321017
CFLAGS += -DTEST_IN=$(TEST_VALUE)

all: lpf128 lpf64 lpf32

lpf128.o: lpf.S
	$(CROSS_GCC) $(CFLAGS) $(CFLAGS_128) -DTYPE_SIZE=128 -c $< -o $@
	
lpf64.o: lpf.S
	$(CROSS_GCC) $(CFLAGS) $(CFLAGS_64) -DTYPE_SIZE=64 -c $< -o $@

lpf32.o: lpf.S
	$(CROSS_GCC) $(CFLAGS) $(CFLAGS_32) -DTYPE_SIZE=32 -c $< -o $@

lpf128: lpf128.o
	${CROSS_LD} -g -T ../common/link.ld $^ -o $@
	
lpf64: lpf64.o
	${CROSS_LD} -g -T ../common/link.ld $^ -o $@

lpf32: lpf32.o
	${CROSS_LD_32} -g -T ../common/link.ld $^ -o $@

run:
	$(MAKE) -s lpf$(TYPE_SIZE)
	@perf stat -e duration_time $(QEMU$(TYPE_SIZE)) -nographic -bios none -machine virt -m 512M -kernel lpf$(TYPE_SIZE)
	
run128:
	$(MAKE) run TYPE_SIZE=128

run64:
	$(MAKE) run TYPE_SIZE=64

run32:
	$(MAKE) run TYPE_SIZE=32
	
.PHONY: clean
clean:
	rm -f *.o
realclean: clean
	rm lpf128  lpf32  lpf64
