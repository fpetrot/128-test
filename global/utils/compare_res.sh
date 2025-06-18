#!/bin/bash


# script to compare quickly the .exp file with the _err.exp file
if [ ! -d ../build/exp/global-tests ]; then
    echo "No build/exp/global-tests"
    exit 0
fi


cd ../build/exp/global-tests
err_files=$(find . -type f -name "*_err.exp")
echo "List of error files:"
for file in $err_files; do
    base_name=$(basename "$file" "_err.exp")
    python3 ../../../utils/test_match.py "$base_name"
done

echo "choose a file from the list above to compare with its .exp file"
read -p "Enter the file name (without _err.exp): " file_name
if [ -z "$file_name" ]; then
    echo "No file name provided"
    exit 0
fi
file=$file_name
if [ ! -f "${file}.exp" ]; then
    echo "No file ${file}.exp"
    exit 0
fi
if [ ! -f "${file}_err.exp" ]; then
    echo "No file ${file}_err.exp"
    echo "No error with this test"
    exit 0

fi

vimdiff "${file}.exp" "${file}_err.exp"


