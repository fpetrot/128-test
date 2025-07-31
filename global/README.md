# global tests

Some unit test write in C that can be compile with libfemto or newlib (some tests exist only on one of these modes).
Also include [riscv-probe](https://github.com/fpetrot/riscv-probe.git) tests  with polybench tests (in global-tests/example).


## make
- 'make' will compile the libfemto (if not compiled), then compile all tests with libfemto and newlib.
- 'make check' to check the result of the output for libfemto and newlib. (you can change testing time by changeing **EXEC_TIME**).
- 'make bin' to make binaries (see make\_binary).
- 'make clean' to delete outputs.

## utils
you can use:
- compare\_res.sh: to show all tests that failed then view differences with vimdiff
- make\_binary.sh: to create binary files for cva6 (only newlib bin will be used, you can find output in build/obj)
- utils/global\_var.h: parameters for polybench tests (if compile in int, float, double, printf modifier...)

## build dir
- bin: binaries files for libfemto, newlib and binaries to use for cva6
- dump: result of objdump for newlib binaries
- exp: expected result for testsi (\_new.exp means result for newlib) . If no result is provided you will have \_temp.exp file (the output of the binary), and if you have a wrong output you will have \_err.exp file.

### tips
you can use 'qemu-system-riscv64  -nographic -bios none -cpu x-rv128 -accel tcg,thread=single -machine virt -kernel file -d plugin -plugin /home/fred/qemu-riscv128/build-elf128/contrib/plugins/libexeclog.so' to compare with the trace of cva6.
