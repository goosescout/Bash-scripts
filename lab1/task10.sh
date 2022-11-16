#!/bin/bash
man bash |
grep -o "[a-zA-Z]\{4,\}" |
tr "[:upper:]" "[:lower:]" |
sort |
uniq -ci |
sort -nr |
head -3 |
awk '{print $1,$2}'
