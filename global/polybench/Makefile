BLUE = \033[0;36m
NC = \033[0m

SOURCES=$(notdir $(shell find polybench-code -name "*.c" | grep -Ev "utilities|\.orig\.c"))
BINARIES=$(patsubst %.c,$(O)/%.x,$(SOURCES)) $(patsubst %.c,$(O)/%-host.x,$(SOURCES))

all: $(BINARIES)

$(O)/stub.o: stub.c
	$(MAKE) -f $(RV_ARIANE)/makefile.include TARGET=stub O=$(O) CFLAGS="-mcmodel=medany" \
		OBJS=stub.o stub.o

$(O)/polybench.o: $(O)/stub.o
	$(MAKE) -f $(RV_ARIANE)/makefile.include TARGET=polybench O=$(O) CFLAGS="-mcmodel=medany" \
		OBJS=polybench-code/utilities/polybench.o polybench-code/utilities/polybench.o
	cp polybench-code/utilities/polybench.o $(O)/polybench.o

$(O)/polybench-host.o:
	$(CC) -c polybench-code/utilities/polybench.c -o $(O)/polybench-host.o -DMINI_DATASET -lm -I$(shell pwd)/polybench-code/utilities

$(O)/%-host.x: $(O)/polybench-host.o
	@echo "\n$(BLUE)Compiling polybench/$* for the host$(NC)\n"
	$(CC) $(shell find . -name $*)/$*.c $^ -o $@ -DPOLYBENCH_DUMP_ARRAYS -DPOLYBENCH_DUMP_TARGET=stdout -DMINI_DATASET -lm -I$(shell pwd)/polybench-code/utilities

$(O)/%.x: $(O)/polybench.o
	@echo "\n$(BLUE)Compiling polybench/$*$(NC)\n"
	$(MAKE) -f $(RV_ARIANE)/makefile.include TARGET=$* O=$(O) \
		CFLAGS="-DPOLYBENCH_DUMP_ARRAYS -DMINI_DATASET -I$(shell pwd)/polybench-code/utilities -mcmodel=medany" \
		EXTRA_LDFLAGS="$(O)/polybench.o stub.o" EXTRA_LIBS="-lm" OBJS=$(shell find . -name $*)/$*.o

.PHONY: clean
clean:
	rm -f $(shell find . -name "*.o")
