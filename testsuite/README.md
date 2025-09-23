# Dejagnu testsuite

Done by Paul Vernin, Emmanuel Fezeu Youmbi and Wiam Karmouni
Date : 2023

The original tests, by Frédéric Pétrot and Fabien Portas, where using python hacks on gdb generated messages.
 
`make test` will execute Dejagnu `runtest riscv.exp`. The script will test all asm files (`*.s`) of the subdirectory `testsuite`.

`make clean` pour delete les fichiers compilés et les fichiers générés par objdump.
