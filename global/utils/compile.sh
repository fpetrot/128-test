#!/bin/sh
# Compile each .c file in subdirectories
# and save res as a .exp file 

mkdir bin
find ./gcc-polybench -type f -name "*.c" | while read -r file; do
    dir=$(dirname "$file")
    dir=${dir#./gcc-polybench/}
    name=$(basename "$file" .c)
    gcc -I./utils/headers "$file" -o bin/"$name" -lm || exit 1
    ./bin/"$name" > ./global-tests/examples/polybench/"$dir/$name".exp
done
rm -rf bin
