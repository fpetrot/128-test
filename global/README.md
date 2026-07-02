# global tests

Some unit test write in C that can be compiled with newlib (using riscvbarelib).
Also include polybench tests (in global-tests/polybench).

## make

- 'make' will compile all tests with riscvbarelib.
- 'make check' to run the tests.
- 'make clean' to delete outputs.

## utils

you can use `gen_exp.sh` to generate expected values when the test cannot be compared on a host implementation.

### tips

you can use 'qemu-system-riscv64 -nographic -bios none -cpu x-rv128 -accel tcg,thread=single -machine virt -kernel file -d plugin -plugin /work/qemu-riscv/build/contrib/plugins/libexeclog.so' to compare with the trace of cva6.
