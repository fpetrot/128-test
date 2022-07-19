#!/usr/bin/bash

# script used to test with every arch and abi for rv128

#ABIS="llp128"
ABIS="llp128 llp128f llp128d"

#ARCH_llp128="rv128i rv128im rv128ima"
ARCH_llp128="rv128i rv128im rv128ima rv128imac"

ARCH_llp128f="rv128imafc"

ARCH_llp128d="rv128imafdc"

for abi in $ABIS
do
	ARCHES=ARCH_$abi
	for arch in ${!ARCHES}
	do
		make clean
		MARCH=$arch MABI=$abi make check
		if [ $? -ne 0 ]
		then
			exit 1
		fi
	done
	echo "-> ALL TESTS HAVE PASSED"
done
