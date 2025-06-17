#!/bin/sh
# Compile each .c file in subdirectories

mkdir bin
find . -type f -name "*.c" | while read -r file; do
    dir=$(dirname "$file")
    dir=${dir#./}
    name=$(basename "$file" .c)
    gcc -Iheaders "$file" -o bin/"$name" -lm
    ./bin/"$name" > ../global-tests/examples/polybench/"$dir/$name".exp
done
rm -rf bin
