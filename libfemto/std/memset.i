# 0 "memset.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "memset.c"


# 1 "/tmp/riscv-toolchain-build/lib/gcc/riscv128-unknown-elf/12.1.0/include/stddef.h" 1 3 4
# 145 "/tmp/riscv-toolchain-build/lib/gcc/riscv128-unknown-elf/12.1.0/include/stddef.h" 3 4

# 145 "/tmp/riscv-toolchain-build/lib/gcc/riscv128-unknown-elf/12.1.0/include/stddef.h" 3 4
typedef long long int ptrdiff_t;
# 214 "/tmp/riscv-toolchain-build/lib/gcc/riscv128-unknown-elf/12.1.0/include/stddef.h" 3 4
typedef long long unsigned int size_t;
# 329 "/tmp/riscv-toolchain-build/lib/gcc/riscv128-unknown-elf/12.1.0/include/stddef.h" 3 4
typedef int wchar_t;
# 424 "/tmp/riscv-toolchain-build/lib/gcc/riscv128-unknown-elf/12.1.0/include/stddef.h" 3 4
typedef struct {
  long long __max_align_ll __attribute__((__aligned__(__alignof__(long long))));
  long double __max_align_ld __attribute__((__aligned__(__alignof__(long double))));
# 435 "/tmp/riscv-toolchain-build/lib/gcc/riscv128-unknown-elf/12.1.0/include/stddef.h" 3 4
} max_align_t;
# 4 "memset.c" 2


# 5 "memset.c"
void *memset(void *dest, int c, size_t n)
{
    char *p = dest;
    while (n-- > 0) {
        *(char*)dest++ = c;
    }
    return p;
}
