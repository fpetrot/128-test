#!/usr/bin/bash

QEMU_CMD='qemu-system-riscv64 -nographic -bios none -cpu x-rv128 -accel tcg,thread=single -machine virt -kernel'

if [ $# -ne 1 ] && [ $# -ne 2 ]
then
	echo "Usage : ./gen_exp.sh test_name [sub_test_name]"
	exit 1
fi

TEST="$1"
SUB_TEST="$1"

if [ $# -eq 2 ]
then
	SUB_TEST="$2"
fi

if [ -d "$TEST" ]
then
	if [ -f "$TEST/$SUB_TEST.c" ]
	then
		make
		echo -e "SOURCE CONTENT IS : \n"
		cat "$TEST/$SUB_TEST.c"
		echo -e "RESULT CONTENT IS : \n"
		RES=$($QEMU_CMD "../build/bin/global-tests/virt/$SUB_TEST")
		echo "$RES"
		echo -e "\n Is it correct ? y/n"
		read keep
		if [ $keep = "y" ]
		then
			rm "$SUB_TEST.exp" 2> /dev/null
			echo "$RES" > "$TEST/$SUB_TEST.exp"
			echo "-> Result saved as expected for $SUB_TEST"
		else
			echo "-> exit without saving result"
		fi
	else
		echo "unable to find sub test"
		exit 1
	fi
else
	echo "unable to find test"
	exit 1
fi
