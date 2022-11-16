#!/bin/bash
result=0

for file in /var/log/*.log; do
    let result="$result+$(wc -l < $file)"
done

echo $result
