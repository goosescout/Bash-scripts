#!/bin/bash
> emails.lst
for file in /etc/*; do
    if [[ ! -d $file ]]; then
        # a - binary as text
        # o - only matching part
        # E - extended regex
        grep -aoE "[A-Za-z0-9\._]+@[A-Za-z0-9_]+\.[A-Za-z0-9\._]+" $file | tr "\n" " " >> emails.lst
    fi
done

sed -i "s/ /, /g" emails.lst
sed -i "s/..$/\n/" emails.lst
