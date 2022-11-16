#!/bin/bash
if [[ $DEBUG == "true" ]]; then
    crontab -r
fi

echo "*/5 * * * 3 ~/goosescout/lab3/task1.sh" | crontab
