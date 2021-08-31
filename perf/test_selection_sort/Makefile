SHELL=/bin/bash  # To have access to 'time'
ASMFLAGS=-x assembler-with-cpp
include ../config.mk

#default values
TABSIZE  ?= 40000
TYPESIZE ?= 128

RVLD=$(CROSS_LD_$(TYPESIZE))
RVGCC=$(CROSS_GCC_$(TYPESIZE))
RVCFLAGS=$(CFLAGS_$(TYPESIZE))

a.$(TYPESIZE).out : crt.o check.o lib.o
	$(RVLD) -g -T link.ld $^ -o $@
crt.o : crt.s data.s
	$(RVGCC) $(ASMFLAGS) $(RVCFLAGS) -c $<
check.o : check.c data.s
	$(RVGCC) $(RVCFLAGS) -mcmodel=medany -O3 -fno-math-errno -Wall -Werror -ffreestanding -c $<
data.s: generate_data.py FORCE
	python3 $< $(TABSIZE) $(TYPESIZE) > $@
check.c : check.in.c FORCE
	if test $(TYPESIZE) -eq 128 ; then TYPE="__int128"; elif test $(TYPESIZE) -eq 64 ; then TYPE="int64_t"; elif test $(TYPESIZE) -eq 32 ; then TYPE="int32_t"; fi; \
	sed -e "s/@TABSIZE@/$(TABSIZE)/" -e "s/@TYPE@/$${TYPE}/" $< > $@
lib.o : lib.c
	$(RVGCC) $(RVCFLAGS) -mcmodel=medany -O3 -fno-math-errno -Wall -Werror -ffreestanding -c $<

clean : ; rm -f *.out *.time *.log *.o data.s check.c a.*.out
realclean : clean; rm -f *.svg

FORCE:

run:
	$(MAKE) clean TABSIZE=$(TABSIZE) TYPESIZE=$(TYPESIZE) a.$(TYPESIZE).out
	$(QEMU$(TYPESIZE)) -nographic -bios none -machine virt -m 512M -kernel a.$(TYPESIZE).out

run128 :
	$(MAKE) clean TABSIZE=$(TABSIZE) TYPESIZE=128 run
run64:
	$(MAKE) clean TABSIZE=$(TABSIZE) TYPESIZE=64 run
run32:
	$(MAKE) clean TABSIZE=$(TABSIZE) TYPESIZE=32 run
