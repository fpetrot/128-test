.PHONY: all clean check

BLUE = \033[0;36m
NC = \033[0m

BUILD_DIR := $(shell pwd)/build
RV_ARIANE := $(shell pwd)/../../rv128_ariane_testharness

# Get every subdirectory containing a Makefile and generate a binary for each of these subdirectories
SUBDIRS := $(dir $(shell find */ -name Makefile))

all: $(SUBDIRS)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

clean:
	rm -fr $(BUILD_DIR)
	$(MAKE) -C polybench clean

check: $(SUBDIRS)
	pytest -n auto

.PHONY: $(SUBDIRS) 
$(SUBDIRS): $(BUILD_DIR) 
	@echo "\n$(BLUE)Compiling $@$(NC)\n"
	$(MAKE) -C $@ BSP_FPU=1 O=$(BUILD_DIR) RV_ARIANE=$(RV_ARIANE)

