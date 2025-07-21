#!/bin/bash

GREEN='\033[0;32m'
NC='\033[0m'
mkdir -p $HOME/128-test/global/build/bin/global-tests/newlib/
# Starting from the current directory
find . -type d ! -path . | while read dir; do
    # Check if the Makefile exists in the directory
    if [ -f "$dir/Makefile" ]; then
        echo -e "${GREEN}Found Makefile in $dir, running make...${NC}"
        # Enter the directory and run make
	if [ $1 == 0 ]; then
         	   (cd "$dir" && make RVB_BUILD=$HOME/rv128_ariane_testharness BSP_FPU=1&&\
		cp build/*.x $HOME/128-test/global/build/bin/global-tests/newlib/)
	else
		(cd "$dir" &&  make RVB_BUILD=$HOME/rv128_ariane_testharness clean)
	fi	
    fi
done

