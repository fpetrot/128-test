#!/usr/bin/bash

if [ $# -ne 2 ]
then
	echo "Usage : ./gen_test.sh test_name sub_test_name"
	exit 1
fi

if [ -d "$1" ]
then
	cd "$1"
	if [ -f "$2.exp" ]
	then
		echo "unable to generate sub test template, this name is already used"
		exit 1
	fi
	echo -e "#include <stdio.h>\n\nint main()\n{\n  printf(\"Hello World!\");\n}" > "$2.c"
	echo -e "Hello World!" > "$2.exp"
	sed -i "s/$1_bin =/$1_bin = $2/g" rules.mk
	echo -e "\n$2_objs = $2.o" >> rules.mk
	echo "generation of sub test $2 done"
else
	echo "unable to generate sub test template, unknown test folder"
	exit 1
fi
