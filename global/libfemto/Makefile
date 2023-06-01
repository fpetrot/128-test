CROSS_COMPILE      ?= riscv128-unknown-elf-

AR                 = $(CROSS_COMPILE)ar

CFLAGS             = -mcmodel=medany -ffunction-sections -fdata-sections -ffast-math -ffreestanding -nostdinc

LDFLAGS            = -nostartfiles -static -lgcc -Wl,--nmagic -Wl,--gc-sections -nostdlib
INCLUDES           = -I../env/common -Iinclude

libfemto_dirs      = std drivers arch/riscv
libfemto_src       = $(sort $(foreach d,$(libfemto_dirs),$(wildcard $(d)/*.c)))
libfemto_asm       = $(sort $(foreach d,$(libfemto_dirs),$(wildcard $(d)/*.s)))
libfemto_objs      = $(patsubst %.s,%.o,$(libfemto_asm)) \
                     $(patsubst %.c,%.o,$(libfemto_src))

#
# Compiler configurations and target environment definitions
#
MARCH              ?= rv128imac
MABI               ?= llp128
CC_rv128           = $(CROSS_COMPILE)gcc
CFLAGS_rv128       = -g -march="$(MARCH)" -mabi="$(MABI)"  -I../env/common/rv128
CXPATH              := $(shell command -v $(CC_rv128) | sed -e 's/bin.*//')/$(CROSS_COMPILE:-=)
LDFLAGS_rv128      = -L$(CXPATH)/lib/$(MARCH)/$(MABI) -lm

targets            = rv128:virt

#
# make rules
#

all: libfemto 

libfemto: ../build/lib/libfemto.a
     
clean:
	rm -fr ../build/lib 
	rm -fr ../build/obj/lib

#
# To view commands use: make V=1
#

ifdef V
cmd = @mkdir -p $2 ; echo "$3"; $3
else
cmd = @echo "$1"; mkdir -p $2 ; $3
endif

#
# Build system functions to generate pattern rules for all configs
#

../build/obj/lib/%.o: %.c
	$(call cmd,CC.$(MARCH) $@,$(@D),$(CC_rv128) $(CFLAGS_rv128) $(CFLAGS) \
	$(INCLUDES) -c $^ -o $@)

../build/obj/lib/%.o: %.s
	$(call cmd,AS.$(MARCH) $@,$(@D),$(CC_rv128) $(CFLAGS_rv128) $(CFLAGS) \
	$(INCLUDES) -c $^ -o $@)

#
# Build system functions to generate library rules for all configs
#

../build/lib/libfemto.a: $(addprefix ../build/obj/lib/,$(libfemto_objs))
	$(call cmd,$(1).$(2) $@,$(@D),$(AR) cr $@ $^)


