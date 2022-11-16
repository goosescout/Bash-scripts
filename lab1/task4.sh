#!/bin/bash
str=$("pwd")
if [[ $str == /home* ]]; then
    echo "$str"
    exit 0
else
    echo "This script wasn't run from home directory"
    exit 1
fi
