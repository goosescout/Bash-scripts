#!/bin/bash
bash task4.sh

prev_ppid=-1
current_count=1
total_count=1
art_sum=0

function get_avg() {
    ((total_count+=current_count))
    avg=$(echo "$art_sum / $current_count" | bc -l | awk '{printf "%.6f\n", $0}')
    sed -i "$total_count i Average_Running_Children_of_ParentID=$prev_ppid is $avg" result4.txt
    ((total_count++))
}

while read line; do
    ppid=$(echo $line | awk '{print $3}' | sed "s/Parent_ProcessID=//")
    art_value=$(echo $line | awk '{print $5}' | sed "s/Average_Running_Time=//")
    if [[ $prev_ppid -eq $ppid ]]; then
        let current_count=$current_count+1
        art_sum=$(echo "$art_sum + $art_value" | bc -l | awk '{printf "%.6f\n", $0}')
    else
        if [[ $prev_ppid -ne -1 ]]; then
            get_avg
        fi
        art_sum=$art_value
        current_count=1
    fi
    prev_ppid=$ppid
done < result4.txt

((total_count+=current_count))
avg=$(echo "$art_sum / $current_count" | bc -l | awk '{printf "%.6f\n", $0}')
echo "Average_Running_Children_of_ParentID=$prev_ppid is $avg" >> result4.txt
