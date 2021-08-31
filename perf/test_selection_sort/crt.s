#include "data.s"
.section .text.init,"ax",@progbits
.globl _start
_start:
# We're in bare metal, so set stack at the end of physical memory
la      sp, _memory_end
j main

#if TYPESIZE == 16
/* Using Kito Chen .insn directives to ease life */
#define lq(rd, imm, rs1)                  .insn i  0b0001111, 0b010, rd, imm(rs1)
#define sq(rs2, imm, rs1)                 .insn s  0b0100011, 0b100, rs2, imm(rs1)
#elif TYPESIZE == 8
#define lq(rd, imm, rs1)                  ld rd, imm(rs1)
#define sq(rs2, imm, rs1)                 sd rs2, imm(rs1)
#elif TYPESIZE == 4
#define lq(rd, imm, rs1)                  lw rd, imm(rs1)
#define sq(rs2, imm, rs1)                 sw rs2, imm(rs1)
#else
#error "Unsupported size"
#endif

# table de correspondance par rapport au programme original
# à gauche mon programme à droite le programme original
# t0=t0,a0=a0, a1=a1,s0=t3,s1=t2,s2=t1,s3=t4, s4=t5, s5=t6

# TODO: Le sub est foireux et "pourri" les 64 bits de poids forts
# On utilse donc pour l'instant deux registres différents pour le
# contrôle et les données

main:
    add t0,zero,zero # t0 contient 0
    la t3,donnee_programme# t2 contient l'adresse des données
    la a0, tableau # a0 contient l'adresse du tableau
    lq(t1,0 * TYPESIZE,t3)    # t1 contient 1
    lq(a1,1 * TYPESIZE,t3)   # a1 contient la taille
    lq(t2,2 * TYPESIZE,t3)   # t2 contient shift amount
    lq(t5,3 * TYPESIZE,t3)   # t5 contient taille - 1

for1_opt:
    # sub s0,a1,t1 #taille -1 dans s0
    slt s0,t0,t5 #si s0 est inférieur à 0 
    beqz s0, fin_for1_opt # c'est la fin
    add s1,t0,zero
    add s2,t0,t1
for2_opt:
    slt s0, s2,a1
    beqz s0, fin_for2_opt
    sll t4,s2,t2
    add t4,t4,a0
    lq(t4,0,t4)
    sll s3,s1,t2
    add s3, s3,a0
    lq(s4,0,s3)
    slt s5,t4,s4
    beqz s5,fin_if_opt
    add s1,s2,zero
fin_if_opt:
    add s2,s2,t1
    j for2_opt
    
fin_for2_opt:
    sll s5,t0,t2
    add s5,s5,a0
    lq(t4,0,s5)
    sll s3,s1,t2
    add s3,s3,a0
    lq(s4,0,s3)
    sll s5,t0,t2
    add s5,s5,a0
    sq(s4,0,s5)
    sll s3,s1,t2
    add s3,s3,a0
    sq(t4,0,s3)
    add t0,t0,t1
    j for1_opt
fin_for1_opt:
#if 1
    jal checkthestuff
#endif
die:
    li  t0, 0x100000
    li  t1, 0xdead3333
    sw  t1, 0(t0)
    wfi
    j       die
