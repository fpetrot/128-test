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

cd ../build/bin/global-tests/$2 || exit 1

TESTS_COUNT=$(ls | wc -l)
TESTS_FAIL=0

EXEC_TIME="$1"

echo -e "\n${BLUE}BEGINNING OF GLOBAL TESTS${NC}\n"
echo -e "execution time: ${EXEC_TIME}"

for i in *
do
	echo -e "${BLUE}TEST: ${NC}$i"
	RES=$(timeout --foreground "$EXEC_TIME" $QEMU_CMD $i)
	if [ $? -ne 0 ]
	then
		echo -e "${RED}-> ERROR: EXECUTION HAS FAILED${NC}"
		TESTS_FAIL=$(($TESTS_FAIL+1))
	else
		if [ $2 == newlib ]; then 
			i="${i%.x}_new"
		fi		
		FILE=../../../exp/global-tests/$i.exp
		#if newlib version of result not exist
		if [ ! -f "$FILE" ]; then
			FILE="${FILE%_new.exp}.exp"
		fi
		#check if the answer file exister to do a diff
		if test -f "$FILE"; then
			DIFF=$(diff <(echo "$RES") "$FILE")
			if [ "$DIFF" != "" ]
			then
				echo -e "${RED}-> ERROR: WRONG OUTPUT (expected is below)${NC}"
				#not to print all diff
				#if too long do a vimdiff between the two files (name.exp and name_err.exp)
				#in build/exp/global-tests/
				if [ $(echo "$DIFF" | wc -l) -lt 5 ]
				then
					echo -e "${YELLOW}$DIFF${NC}"
				else
					echo -e "${YELLOW}$(echo "$DIFF" | head -n 5) ...${NC}"
				fi
				echo "$RES" > ${FILE%.*}_err.exp
				TESTS_FAIL=$(($TESTS_FAIL+1))
        		RESULT=0
    			else
     				echo -e "${GREEN}-> OK${NC}"
   			fi
		else
			echo "$RES" > ${FILE%.*}_temp.exp
			echo -e "${YELLOW}-> PASSED (without execution failure)${NC}"	
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
