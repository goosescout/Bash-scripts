#!/bin/bash
set -f # disable wildcards

echo $$ > pipe

while true; do
    read line
    echo $line > pipe
    if [[ $line == "QUIT" ]]; then
        echo "Exiting..."
        exit 0
    fi
done
