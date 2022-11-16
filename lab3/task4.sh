#!/bin/bash
bash task4_loop.sh & pid1=$!
bash task4_loop.sh &
bash task4_loop.sh & pid2=$!

cpulimit -mz --cpu 4 --pid $pid1 --limit 5 &
kill -9 $pid2
