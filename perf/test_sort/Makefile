include ../config.mk

TEST_SIZE ?= 20000

all: sort128 sort64 sort32

sort128.o: sort.S data.S
	$(CROSS_GCC) $(CFLAGS) $(CFLAGS_128) -DTYPE_SIZE=128 -c $< -o $@
	
sort64.o: sort.S data.S
	$(CROSS_GCC) $(CFLAGS) $(CFLAGS_64) -DTYPE_SIZE=64 -c $< -o $@

sort32.o: sort.S data.S
	$(CROSS_GCC) $(CFLAGS) $(CFLAGS_32) -DTYPE_SIZE=32 -c $< -o $@

sort128: sort128.o
	${CROSS_LD} -g -T ../common/link.ld $^ -o $@
	
sort64: sort64.o
	${CROSS_LD} -g -T ../common/link.ld $^ -o $@

sort32: sort32.o
	${CROSS_LD_32} -g -T ../common/link.ld $^ -o $@

run:
	@echo "Generating data..."
	@./gen_data.py $(TEST_SIZE) $(TYPE_SIZE)
	@echo "Compiling..."
	$(MAKE) -s sort$(TYPE_SIZE)
	@echo "Running sort on data..."
	@LC_ALL=C perf stat -e duration_time $(QEMU$(TYPE_SIZE)) -nographic -bios none -machine virt -m 512M -kernel sort$(TYPE_SIZE)
	#@perf stat $(QEMU$(TYPE_SIZE)) -nographic -bios none -machine virt -m 512M -kernel sort$(TYPE_SIZE)
	
runm:
	@echo "Generating data..."
	@./gen_data.py $(TEST_SIZE) $(TYPE_SIZE)
	@echo "Compiling..."
	$(MAKE) -s sort$(TYPE_SIZE)
	@echo "Running sort on data..."
	@LC_ALL=C perf stat -ddd -x ';' -o perf.csv $(QEMU$(TYPE_SIZE)) -nographic -bios none -machine virt -m 512m -kernel sort$(TYPE_SIZE)

run128:
	@$(MAKE) clean run TYPE_SIZE=128

run64:
	@$(MAKE) clean run TYPE_SIZE=64

run32:
	@$(MAKE) clean run TYPE_SIZE=32
	
runm128:
	@$(MAKE) -s clean
	@$(MAKE) -s runm TYPE_SIZE=128

runm64:
	@$(MAKE) -s clean
	@$(MAKE) -s runm TYPE_SIZE=64

runm32:
	@$(MAKE) -s clean
	@$(MAKE) -s runm TYPE_SIZE=32

.PHONY: clean
clean:
	rm -f *.o data.S
realclean : clean
	sort128 sort64 sort32
