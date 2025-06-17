#!/bin/sh
# Compile each .c file in subdirectories, placing the executable in the same directory as the .c file

find . -type f -name "*.c" | while read -r file; do
    dir=$(dirname "$file")
    name=$(basename "$file" .c)
    gcc "$file" -o "$dir/$name" -lm
    ./"$dir/$name" > "$dir/$name".exp 
done
