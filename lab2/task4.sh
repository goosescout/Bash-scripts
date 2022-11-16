#!/bin/bash
> result4.txt
for pid in $(ps -A --format pid | sed "1d"); do
    ppid=$(grep -Eis "ppid" "/proc/"$pid"/status" | awk '{print $2}')
    if [[ -z $ppid ]]; then
        continue
    fi

    sum_exec_runtime=$(grep -Eis "sum_exec_runtime" "/proc/"$pid"/sched" | awk '{print $3}')
    nr_switches=$(grep -Eis "nr_switches" "/proc/"$pid"/sched" | awk '{print $3}')
    if [[ -z $sum_exec_runtime || -z $nr_switches ]]; then
        continue
    else
        ART=$(echo "$sum_exec_runtime $nr_switches" | awk '{printf "%f", $1/$2}')
    fi

    echo "$pid $ppid $ART"
done | sort -n --key=2 |
awk '{print "ProcessID="$1"\t:\tParent_ProcessID="$2"\t:\tAverage_Running_Time="$3""}' > result4.txt
