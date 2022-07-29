#
# make rules
#

.EXPORT_ALL_VARIABLES:

CROSS_COMPILE      ?= riscv128-unknown-elf-
MARCH              ?= rv128imafdc
MABI               ?= llp128d
QEMU               ?= qemu-system-riscv64

.PHONY: all
all: 
	$(MAKE) libfemto	
	$(MAKE) global-tests	

.PHONY: check
check:
	$(MAKE) check-global-tests

.PHONY: clean
clean:
	rm -fr build

#
# To view commands use: make V=1
#

ifdef V
cmd = @mkdir -p $2 ; echo "$3"; $3
else
cmd = @echo "$1"; mkdir -p $2 ; $3
endif

.PHONY: libfemto
libfemto:
	$(MAKE) -C libfemto

.PHONY: global-tests
global-tests: libfemto
	$(MAKE) -C global-tests

.PHONY: check-global-tests
check-global-tests: global-tests
	$(MAKE) -C global-tests check
