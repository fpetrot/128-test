.EXPORT_ALL_VARIABLES:

EXEC_TIME = 3

.PHONY: all
all:
	$(MAKE) global

.PHONY: check
check:
	$(MAKE) testsuite-test
	$(MAKE) int128-check
	cd unit; ./prgchk_all.py
	$(MAKE) global-check

.PHONY: clean
clean:
	$(MAKE) -C global clean
	$(MAKE) -C int128 clean
	$(MAKE) -C testsuite clean

.PHONY: global
global:
	$(MAKE) -C global

.PHONY: global-check
global-check:
	$(MAKE) -C global check

.PHONY: testsuite-test
testsuite-test:
	$(MAKE) -C testsuite

.PHONY: int128-check
int128-check:
	$(MAKE) -C int128 check
