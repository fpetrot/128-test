OUT_DIR=out/

$(OUT_DIR)/lib.o:
	${CROSS_GCC} -mcmodel=medany -I./include -O3 -g -march=rv64imfd -mabi=lp64d -fno-math-errno -Wall -Werror -ffreestanding -c ../common/lib.c -o $(OUT_DIR)/lib.o 