#if TYPE_SIZE == 128
    #define load(rd, imm, rs1) lq(rd, imm, rs1)
    #define store(rs2, imm, rs1) sq(rs2, imm, rs1)
    #define TYPE_OFF 16
    #define TYPE_SHFT 4
#elif TYPE_SIZE == 64
    #define load(rd, imm, rs1) ld rd, imm(rs1)
    #define store(rs2, imm, rs1) sd rs2, imm(rs1)
    #define TYPE_OFF 8
    #define TYPE_SHFT 3
#elif TYPE_SIZE == 32
    #define load(rd, imm, rs1) lw rd, imm(rs1)
    #define store(rs2, imm, rs1) sw rs2, imm(rs1)
    #define TYPE_OFF 4
    #define TYPE_SHFT 2
#else
    #error "TYPE_SIZE must be 128, 64 or 32"
#endif 
