#!/bin/bash

# prerequisites: run task1.sh in 2m
# ./task1.sh &

if [[ $DEBUG == "true" ]]; then
    (sleep 2m ; DEBUG=false bash task1.sh) &
fi

tail -n 0 -f ~/report
