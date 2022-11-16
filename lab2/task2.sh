#!/bin/bash
ps -A --format pid,command |
grep -E " +/sbin/" |
awk '{print $1}' |
paste -d "," -s |
sed "s/,/, /g" > result2.txt
