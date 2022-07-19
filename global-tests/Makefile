CROSS_COMPILE      ?= riscv128-unknown-elf-

AR                 = $(CROSS_COMPILE)ar

CFLAGS             = -mcmodel=medany -ffunction-sections -fdata-sections -ffast-math -ffreestanding -nostdinc

LDFLAGS            = -nostartfiles -static -lgcc -Wl,--nmagic -Wl,--gc-sections -nostdlib
INCLUDES           = -I../env/common -I../libfemto/include

#
# Compiler configurations and target environment definitions
#

subdirs            = global

libs               = libfemto

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

all: global-tests 

clean:
	rm -fr ../build/obj/env
	rm -fr ../build/obj/global-tests
	rm -fr ../build/bin/global-tests
	rm -fr ../build/exp/global-tests

check: global-tests
	./execute_tests.sh

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

../build/obj/global-tests/%.o: %.c
	$(call cmd,CC.$(MARCH) $@,$(@D),$(CC_rv128) $(CFLAGS_rv128) $(CFLAGS) \
	$(INCLUDES) -c $^ -o $@)

../build/obj/global-tests/%.o: %.s
	$(call cmd,AS.$(MARCH) $@,$(@D),$(CC_rv128) $(CFLAGS_rv128) $(CFLAGS) \
	$(INCLUDES) -c $^ -o $@)

../build/obj/env/%.o: ../env/%.c
	$(call cmd,CC.$(MARCH) $@,$(@D),$(CC_rv128) $(CFLAGS_rv128) $(CFLAGS) \
	$(INCLUDES) -c $^ -o $@)

../build/obj/env/%.o: ../env/%.s
	$(call cmd,AS.$(MARCH) $@,$(@D),$(CC_rv128) $(CFLAGS_rv128) $(CFLAGS) \
	$(INCLUDES) -c $^ -o $@)

#
# Build system functions to generate build rules for all subdirs
#

#sub_makes := $(foreach dir,$(subdirs),$(wildcard ${dir}/*/rules.mk))
sub_makes := $(shell find . -name rules.mk)
$(foreach makefile,$(sub_makes),$(eval include $(makefile)))
sub_dirs := $(foreach m,$(sub_makes),$(m:/rules.mk=))
module_name = $(lastword $(subst /, ,$(1)))
module_objs = $(addprefix ../build/obj/global-tests/,$(addprefix $(2)/,$($(1)_objs)))
config_arch = $(word 1,$(subst :, ,$(1)))
config_env = $(word 2,$(subst :, ,$(1)))

define rule =
../build/bin/global-tests/$(4)/$(1): \
../build/obj/env/$(4)/crt.o ../build/obj/env/$(4)/setup.o $(2)
	$$(call cmd,LD.$(MARCH) $$@,$$(@D),$(CC_rv128) $(CFLAGS_rv128) $$(CFLAGS) \
	$$(LDFLAGS) -T ../env/$(4)/default.lds $$^ ../build/lib/libfemto.a -o $$@) -lm -lgcc
endef

define module =
program_names += $(foreach cfg,$(targets),../build/bin/global-tests/$(call config_env,$(cfg))/$(1))

$(foreach cfg,$(targets),$(eval $(call rule,$(1),$(call \
  module_objs,$(1),$(2),$(call config_arch,$(cfg))),$(call \
  config_arch,$(cfg)),$(call config_env,$(cfg)))))
endef

$(foreach d,$(sub_dirs),$(foreach t,$($(call module_name,$(d))_bin),$(eval $(call module,$(t),$(call module_name,$(d))))))

global-tests: $(program_names)
	mkdir -p ../build/exp/global-tests
	cp */*.exp ../build/exp/global-tests

