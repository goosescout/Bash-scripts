#!/bin/bash
result=""
read str
while [[ $str != "q" ]]; do
    result="${result} ${str}"
    read str
done
echo $result
