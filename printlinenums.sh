#!/bin/bash
## Simple bash script to print out each line of a program with its
## corresponding line number

declare -i line_count=1
declare -i ret=1
if [ $# != 1 ]
then
    echo "Usage ./printlinenums.sh file_name"
    exit 1
fi

file_name=$1
## Treat as string
num_lines="$(wc -l $file_name | head -n1 | awk '{print $1}')"

## Get number of digits
declare -i num_digits="$(echo -n $num_lines | wc -c)"

## Variables for storing output strings prior to printing
## Helpful for preventing an extra line from printing at the end
## of the program
line_buffer=""

while [[ $line_count -lt $num_lines ]]
do
    ##printf "% *d: " $num_digits $line_count
    line_buffer="$(head -$line_count $file_name | tail -1)"
    ret=$?
    if [[ $line_count -lt $num_lines ]]
    then
        printf "%*d: " $num_digits $line_count
        echo "$line_buffer"
    fi
    line_count=$line_count+1
done
