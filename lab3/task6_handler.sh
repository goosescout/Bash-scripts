#!/bin/bash
echo $$ > .pid

current=1

function usr1 {
    ((current+=2))
    echo $current
}

function usr2 {
    ((current*=2))
    echo $current
}

function term {
    echo "Treminated by generator"
    rm .pid
    exit 0
}
trap "usr1" USR1
trap "usr2" USR2
trap "term" SIGTERM

while true; do
    sleep 1s
done
