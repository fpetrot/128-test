#include "insns.S" 
#include "utils.S"
#define cslli(rd, imm)    .insn ci 0b10, 0b000, rd, imm
#define csrli(rd, s, imm) .half  0b100 ## s ## 00 ## rd ## imm ## 01
#define csrai(rd, s, imm) .half  0b100 ## s ## 01 ## rd ## imm ## 01

.section .text.init,"ax",@progbits
.globl _start
_start:
add x0, x0, x0
# Illegal insn, for real
#.half 0x0000
# c.nop 0
.half 0x0001
.half 0x0005
cslli(x6, 0)
j exit
cslli(x6, 1)
cslli(x6, 2)
cslli(x6, 3)
cslli(x6, 4)
cslli(x6, 5)
cslli(x6, 6)
cslli(x6, 7)
cslli(x6, 8)
cslli(x6, 9)
cslli(x6, 10)
cslli(x6, 11)
cslli(x6, 12)
cslli(x6, 13)
cslli(x6, 14)
cslli(x6, 15)
cslli(x6, 16)
cslli(x6, 17)
cslli(x6, 18)
cslli(x6, 19)
cslli(x6, 20)
cslli(x6, 21)
cslli(x6, 22)
cslli(x6, 23)
cslli(x6, 24)
cslli(x6, 25)
cslli(x6, 26)
cslli(x6, 27)
cslli(x6, 28)
cslli(x6, 29)
cslli(x6, 30)
cslli(x6, 31)
cslli(x6,-1)
cslli(x6,-2)
cslli(x6,-3)
cslli(x6,-4)
cslli(x6,-5)
cslli(x6,-6)
cslli(x6,-7)
cslli(x6,-8)
cslli(x6,-9)
cslli(x6,-10)
cslli(x6,-11)
cslli(x6,-12)
cslli(x6,-13)
cslli(x6,-14)
cslli(x6,-15)
cslli(x6,-16)
cslli(x6,-17)
cslli(x6,-18)
cslli(x6,-19)
cslli(x6,-20)
cslli(x6,-21)
cslli(x6,-22)
cslli(x6,-23)
cslli(x6,-24)
cslli(x6,-25)
cslli(x6,-26)
cslli(x6,-27)
cslli(x6,-28)
cslli(x6,-29)
cslli(x6,-30)
cslli(x6,-31)
cslli(x6, -32)
add x0, x0, x0
csrli(011,0,00000)
csrli(011,0,00001)
csrli(011,0,00010)
csrli(011,0,00011)
csrli(011,0,00100)
csrli(011,0,00101)
csrli(011,0,00110)
csrli(011,0,00111)
csrli(011,0,01000)
csrli(011,0,01001)
csrli(011,0,01010)
csrli(011,0,01011)
csrli(011,0,01100)
csrli(011,0,01101)
csrli(011,0,01110)
csrli(011,0,01111)
csrli(011,0,10000)
csrli(011,0,10001)
csrli(011,0,10010)
csrli(011,0,10011)
csrli(011,0,10100)
csrli(011,0,10101)
csrli(011,0,10110)
csrli(011,0,10111)
csrli(011,0,11000)
csrli(011,0,11001)
csrli(011,0,11010)
csrli(011,0,11011)
csrli(011,0,11100)
csrli(011,0,11101)
csrli(011,0,11110)
csrli(011,0,11111)

csrli(011,1, 00000)
csrli(011,1, 00001)
csrli(011,1, 00010)
csrli(011,1, 00011)
csrli(011,1, 00100)
csrli(011,1, 00101)
csrli(011,1, 00110)
csrli(011,1, 00111)
csrli(011,1, 01000)
csrli(011,1, 01001)
csrli(011,1, 01010)
csrli(011,1, 01011)
csrli(011,1, 01100)
csrli(011,1, 01101)
csrli(011,1, 01110)
csrli(011,1, 01111)
csrli(011,1, 10000)
csrli(011,1, 10001)
csrli(011,1, 10010)
csrli(011,1, 10011)
csrli(011,1, 10100)
csrli(011,1, 10101)
csrli(011,1, 10110)
csrli(011,1, 10111)
csrli(011,1, 11000)
csrli(011,1, 11001)
csrli(011,1, 11010)
csrli(011,1, 11011)
csrli(011,1, 11100)
csrli(011,1, 11101)
csrli(011,1, 11110)
csrli(011,1, 11111)
add x0, x0, x0
csrai(101, 0, 11111)
csrai(101, 0, 00010)
csrai(101, 0, 00001)
csrai(101, 0, 00000)
csrai(101, 1, 11111)
csrai(101, 1, 00001)
csrai(101, 1, 00000)
j exit
