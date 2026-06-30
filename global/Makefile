.PHONY: all clean check

BLUE = \033[0;36m
NC = \033[0m

XLEN=128
BUILD_DIR := $(shell pwd)/build
RV_ARIANE := $(shell pwd)/../../rv$(XLEN)_ariane_testharness

# Get every subdirectory containing a Makefile and generate a binary for each of these subdirectories
SUBDIRS := $(dir $(shell find */ -name Makefile))

ifeq ($(XLEN),128)
	CPU = x-rv128
else
	CPU = rv64
endif

all: $(SUBDIRS)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

clean:
	rm -fr $(BUILD_DIR)
	$(MAKE) -C polybench clean

check: $(SUBDIRS)
	QEMU_CPU=$(CPU) pytest -n auto

.PHONY: $(SUBDIRS) 
$(SUBDIRS): $(BUILD_DIR) 
	@echo "\n$(BLUE)Compiling $@$(NC)\n"
	$(MAKE) -C $@ O=$(BUILD_DIR) RV_ARIANE=$(RV_ARIANE)

