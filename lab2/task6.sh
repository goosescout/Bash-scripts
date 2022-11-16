#!/bin/bash
for pid in $(ps -A --format pid | sed "1d"); do
    grep -hs "VmRSS" /proc/$pid/status |
    awk '{printf "%s %.0f\n", '$pid', $2/1024}'
done | sort -n --key=2 |
tail -1 |
awk '{print "PID:\tMemory (MB)\n"$1"\t"$2}'
