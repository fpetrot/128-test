include ../config.mk

# Automated Makefile for 32/64/128 bit assembly comparison benchmarks.
# Warning : do NOT use the strings _32, _64 or _128 in filenames and use the .S extension for the assembly source.

EXEC_BASE=ts_search
SRCS=ts_search.S data.S

TARGET_BITS=_32 _64 _128
OBJ_TARGETS=$(addsuffix .o, $(foreach base, $(basename $(SRCS)), $(addprefix $(base), $(TARGET_BITS))))
EXEC_TARGETS=$(addprefix $(EXEC_BASE), $(TARGET_BITS))

BST_SIZE ?= 25000
SEARCH_COUNT ?= 10000
REPEATS ?= 20

ts_search_128.o: ts_search.S
	$(CROSS_GCC) $(CFLAGS) $(CFLAGS_128) -DTYPE_SIZE=128 -c $< -o $@
	
ts_search_64.o: ts_search.S
	$(CROSS_GCC) $(CFLAGS) $(CFLAGS_64) -DTYPE_SIZE=64 -c $< -o $@

ts_search_32.o: ts_search.S
	$(CROSS_GCC) $(CFLAGS) $(CFLAGS_32) -DTYPE_SIZE=32 -c $< -o $@

ts_search_128: ts_search_128.o data_128.o
	${CROSS_LD} -g -T ../common/link.ld $^ -o $@
	
ts_search_64: ts_search_64.o data_64.o
	${CROSS_LD} -g -T ../common/link.ld $^ -o $@

ts_search_32: ts_search_32.o data_32.o
	${CROSS_LD_32} -g -T ../common/link.ld $^ -o $@

data.S:
	./generate_data.py $(TYPE_SIZE) $(BST_SIZE) $(SEARCH_COUNT) $(REPEATS)

data_128.o: data.S
	$(CROSS_GCC_128) $(CFLAGS) $(CFLAGS_128) -c data.S -o $@

data_64.o: data.S
	$(CROSS_GCC_64) $(CFLAGS) $(CFLAGS_64) -c data.S -o $@

data_32.o: data.S
	$(CROSS_GCC_32) $(CFLAGS) $(CFLAGS_32) -c data.S -o $@

run:
	@echo "Generating data..."
	@./generate_data.py $(TYPE_SIZE) $(BST_SIZE) $(SEARCH_COUNT) $(REPEATS)
	@echo "Compiling..."
	$(MAKE) $(EXEC_BASE)_$(TYPE_SIZE)
	@echo "Searching binary tree..."
	perf stat -e duration_time $(QEMU$(TYPE_SIZE)) -nographic -bios none -machine virt -m 512M -kernel $(EXEC_BASE)_$(TYPE_SIZE)

runm:
	@echo "Generating data..."
	@./generate_data.py $(TYPE_SIZE) $(BST_SIZE) $(SEARCH_COUNT) $(REPEATS)
	@echo "Compiling..."
	$(MAKE) $(EXEC_BASE)_$(TYPE_SIZE)
	@echo "Searching binary tree..."
	@LC_ALL=C perf stat -ddd -x ';' -o perf.csv $(QEMU$(TYPE_SIZE)) -nographic -bios none -machine virt -m 512M -kernel $(EXEC_BASE)_$(TYPE_SIZE)

	
run128:
	@$(MAKE) -s run TYPE_SIZE=128

run64:
	@$(MAKE) -s run TYPE_SIZE=64

run32:
	@$(MAKE) -s run TYPE_SIZE=32
	
runm128:
	@$(MAKE) -s runm TYPE_SIZE=128

runm64:
	@$(MAKE) -s runm TYPE_SIZE=64

runm32:
	@$(MAKE) -s runm TYPE_SIZE=32

.PHONY: clean
clean:
	rm -f *.o $(EXEC_TARGETS) data.S

FORCE: ;
