#define lq(rd, imm, rs1)                  .insn i  0b0001111, 0b010, rd, imm(rs1)
#define sq(rs2, imm, rs1)                 .insn s  0b0100011, 0b100, rs2, imm(rs1)

// We have to redefine shifts by immediate, since although they have the same opcode,
// gcc for rv64 will not compile if their shift is equal or above 64.
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