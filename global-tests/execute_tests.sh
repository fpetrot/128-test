#!/usr/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;36m'
YELLOW='\033[0;33m'
NC='\033[0m'

if [ -z "$QEMU" ]
then
	QEMU='qemu-system-riscv64'
fi 

QEMU_ARGS=' -nographic -bios none -cpu x-rv128 -accel tcg,thread=single -machine virt -kernel'
QEMU_CMD="$QEMU $QEMU_ARGS"

cd ../build/bin/global-tests/virt || exit 1

TESTS_COUNT=$(ls | wc -l)
TESTS_FAIL=0

echo -e "\n${BLUE}BEGINNING OF GLOBAL TESTS${NC}\n"

for i in *
do
	echo -e "${BLUE}TEST: ${NC}$i"
	RES=$(timeout --foreground 3 $QEMU_CMD $i)
	if [ $? -ne 0 ]
	then
		echo -e "${RED}-> ERROR: EXECUTION HAVE FAILED${NC}"
		TESTS_FAIL=$(($TESTS_FAIL+1))
	else
		DIFF=$(diff <(echo "$RES") "../../../exp/global-tests/$i.exp")
		if [ "$DIFF" != "" ]
		then
			echo -e "${RED}-> ERROR: WRONG OUTPUT (expected is below)${NC}"
      			echo -e "${YELLOW}$DIFF${NC}"
			TESTS_FAIL=$(($TESTS_FAIL+1))
        	RESULT=0
    		else
     			echo -e "${GREEN}-> OK${NC}"
   		fi
	fi
done

echo -e "\n${BLUE}END OF GLOBAL TESTS${NC}\n"

if [ $TESTS_FAIL -eq 0 ]
then
	echo -e "${GREEN}--> ALL GLOBAL TESTS HAVE PASSED ! ($TESTS_COUNT / $TESTS_COUNT)${NC}\n"
	exit 0
else
	echo -e "${RED}--> SOME GLOBAL TESTS HAVE FAILED : $(($TESTS_COUNT-$TESTS_FAIL)) success(es) / $TESTS_COUNT${NC}\n"
	exit 1
fi
