#!/usr/bin/bash

if [ $# -ne 1 ]
then
	echo "Usage : ./gen_test.sh test_name"
fi

if [ -d "$1" ]
then
	echo "unable to generate test template, this name is already used"
else
	mkdir "$1"
	cd "$1"
	echo -e "#include <stdio.h>\n\nint main()\n{\n  printf(\"Hello World!\");\n}" > "$1.c"
	echo -e "Hello World!" > "$1.exp"
	echo -e "$1_bin = $1\n\n$1_objs = $1.o" > rules.mk
	echo "generation of test $1 done"
fi
