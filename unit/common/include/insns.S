#define lq(rd, imm, rs1)                  .insn i  0b0001111, 0b010, rd, imm(rs1)
#define sq(rs2, imm, rs1)                 .insn s  0b0100011, 0b100, rs2, imm(rs1)

/*
 * Can't use the .insn trick on the two following instructions, so build them
 * the old school way.
 * Since the registers are not know as numbers, we use a define to refer to
 * them, and we can't use xn as is has not to be redefined, so we call them rn
   r5 is x5 aka t0, r5 is used in non .insn insns
 * These are one of the few instructions considering the immediate as unsigned
 */
#define r0  0
#define r1  1
#define r2  2
#define r3  3
#define r4  4
#define r5  5
#define r6  6
#define r7  7
#define r8  8
#define r9  9
#define r10 10
#define r11 11
#define r12 12
#define r13 13
#define r14 14
#define r15 15
#define r16 16
#define r17 17
#define r18 18
#define r19 19
#define r20 20
#define r21 21
#define r22 22
#define r23 23
#define r24 24
#define r25 25
#define r26 26
#define r27 27
#define r28 28
#define r29 29
#define r30 30
#define r31 31

#define lqsp(rd, ofs)  .half (0b001 << 13) | ((ofs & 0x20) << 7) | (rd << 7) | ((ofs & 0x10) << 2) | ((ofs >> 4) & 0x3c) | 0x2
#define sqsp(rs2, ofs) .half (0b101 << 13) | ((ofs << 7) & 0x1800) | ((ofs << 1) & 0x0780) | (rs2 << 2) | 0x2

// We have to redefine shifts by immediate, since although they have the same opcode,
// gas for rv64 will not assemble if their shift is equal to or above 64.
#define rori(rd, rs1, imm)                .insn i  0b0010011, 0b101, rd, rs1, 0b011000000000 | (imm & 0b1111111)

#define slli(rd, rs1, imm)                .insn i  0b0010011, 0b001, rd, rs1, imm & 0b1111111
#define srli(rd, rs1, imm)                .insn i  0b0010011, 0b101, rd, rs1, imm & 0b1111111
#define srai(rd, rs1, imm)                .insn i  0b0010011, 0b101, rd, rs1, 0b010000000000 | (imm & 0b1111111)
#define sllid(rd, rs1, imm)               .insn i  0b1011011, 0b001, rd, rs1, imm & 0b111111
#define srlid(rd, rs1, imm)               .insn i  0b1011011, 0b101, rd, rs1, imm & 0b111111
#define sraid(rd, rs1, imm)               .insn i  0b1011011, 0b101, rd, rs1, 0b010000000000 | (imm & 0b111111)
#define slld(rd, rs1, rs2)                .insn r  0b1111011, 0b001, 0b0000000, rd, rs1, rs2
#define srld(rd, rs1, rs2)                .insn r  0b1111011, 0b101, 0b0000000, rd, rs1, rs2
#define srad(rd, rs1, rs2)                .insn r  0b1111011, 0b101, 0b0100000, rd, rs1, rs2
#define ldu(rd, imm, rs1)                 .insn i  0b0000011, 0b111, rd, rs1, imm
#define addd(rd, rs1, rs2)                .insn r  0b1111011, 0b000, 0b0000000, rd, rs1, rs2
#define addid(rd, rs1, imm)               .insn i  0b1011011, 0b000, rd, rs1, imm
#define subd(rd, rs1, rs2)                .insn r  0b1111011, 0b000, 0b0100000, rd, rs1, rs2

#define muld(rd, rs1, rs2)                .insn r  0b1111011, 0b000, 0b0000001, rd, rs1, rs2
#define divd(rd, rs1, rs2)                .insn r  0b1111011, 0b100, 0b0000001, rd, rs1, rs2
#define divud(rd, rs1, rs2)               .insn r  0b1111011, 0b101, 0b0000001, rd, rs1, rs2
#define remd(rd, rs1, rs2)                .insn r  0b1111011, 0b110, 0b0000001, rd, rs1, rs2
#define remud(rd, rs1, rs2)               .insn r  0b1111011, 0b111, 0b0000001, rd, rs1, rs2
/*
.insn r opcode, func3, func7, rd, rs1, rs2
+-------+-----+-----+-------+----+-------------+
| func7 | rs2 | rs1 | func3 | rd |      opcode |
+-------+-----+-----+-------+----+-------------+
31      25    20    15      12   7             0
*/

/*
.insn i opcode, func3, rd, rs1, simm12
+-------------+-----+-------+----+-------------+
|      simm12 | rs1 | func3 | rd |      opcode |
+-------------+-----+-------+----+-------------+
31            20    15      12   7             0
*/
