#!/bin/bash

#compile all tests with newlib instead of libfemto
#tests hava to have a Makefile in their dirs
GREEN='\033[0;32m'
NC='\033[0m'
GLOBAL_PATH=$(pwd)
mkdir -p ../build/bin/global-tests/newlib/
mkdir -p ../build/dump/
# Starting from the current directory
find . -type d ! -path . | while read dir; do
    # Check if the Makefile exists in the directory
    if [ -f "$dir/Makefile" ]; then
        echo -e "${GREEN}Found Makefile in $dir, running make...${NC}"
        # Enter the directory and run make
	if [ $1 == 0 ]; then
         	   (cd "$dir" && make RVB_BUILD=/work/rv128_ariane_testharness BSP_FPU=1&&\
		cp build/*.x $GLOBAL_PATH/../build/bin/global-tests/newlib/ &&\
		cp build/*.x.dump $GLOBAL_PATH/../build/dump/)
	else
		(cd "$dir" &&  make RVB_BUILD=/work/rv128_ariane_testharness clean)
	fi	
    fi
done

