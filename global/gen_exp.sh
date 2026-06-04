#!/usr/bin/bash

QEMU_CMD='qemu-system-riscv64 -nographic -bios none -cpu x-rv128 -accel tcg,thread=single -machine virt -kernel'

if [ $# -ne 1 ]
then
	echo "Usage : ./gen_exp.sh test_name"
	exit 1
fi

TEST="$1"

if [ -f "$TEST/Makefile" ]
then
	make -C $TEST
	echo -e "RESULT CONTENT IS : \n"
	RES=$($QEMU_CMD "build/$TEST.x")
	echo "$RES"
	echo -e "\n Is it correct ? y/n"
	read keep
	if [ $keep = "y" ]
	then
		rm "$TEST.exp" 2> /dev/null
		echo "$RES" > "$TEST/$TEST.expected"
		echo "-> Result saved as expected for $TEST"
	else
		echo "-> exit without saving result"
	fi
else
	echo "unable to find test"
	exit 1
fi
