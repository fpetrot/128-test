# Example of how to rewrite an elf64 test into an elf128 test

With the elf64 toolchain, gdb cannot access the upper part of the 128-bit general purpose registers.
Given that, our tests do computations on 128-bit and first check the lower 64 bits, then shift 64 bits to the right and check the 64 upper bits.

So a sequence for checking a result resembles that:
```asm
    or t1, t0, t1
    //prgchk reg t1 == 0x0ec94d28201e1869
    srli(t1, t1, 64)
    //prgchk reg t1 == 0x75033785b9ca9eec
```

Now that we have 128-bit gdb, we can directly write:
```asm
    or t1, t0, t1
    //prgchk reg t1 == 0x75033785b9ca9eec0ec94d28201e1869
```

We can also remove all macros making use of `.insn` that allowed us to have access to the 128-bit instructions.
```asm
    lq(t1, 0, t1)
```
Now becomes:
```asm
    lq t1, 0(t1)
```
