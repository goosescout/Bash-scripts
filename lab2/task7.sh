#!/bin/bash
declare -A memory_read

for pid in $(ps -A --format pid | sed "1d"); do
    memory_read[$pid]=$(grep -s "read_bytes" /proc/$pid/io | awk '{print $2}')
done

sleep 1m

for pid in $(ps -A --format pid | sed "1d"); do
    if [[ -n ${memory_read[$pid]} ]]; then
        new_read=$(grep -s "read_bytes" /proc/$pid/io | awk '{print $2}')
        memory_read[$pid]=$(echo $new_read-${memory_read[$pid]} | bc)
    else
        memory_read[$pid]=$(grep -s "read_bytes" /proc/$pid/io | awk '{print $2}')
    fi
    ps -f -p $pid | sed "1d" | awk '{print '$pid'" "$8" "'${memory_read[$pid]}'}'
done | sort -nr --key=3 | head -3 | awk '{print $1"\t:\t"$2"\t:\t"$3}' | sed "1 i PID\t:\tCMD\t:\tread bytes"
