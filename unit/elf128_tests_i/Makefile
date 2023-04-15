elf128_test_or : elf128_test_or.o
	riscv128-unknown-elf-ld -T ../common/link.ld elf128_test_or.o -o elf128_test_or
elf128_test_or.o : elf128_test_or.S
	cpp -I ../common/include/ elf128_test_or.S  | riscv128-unknown-elf-as -g -o elf128_test_or.o -
