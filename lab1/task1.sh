#!/bin/bash
max=$1
for elem in $*; do
    if [[ $max -lt $elem ]]; then
        max=$elem
    fi
done
echo $max
