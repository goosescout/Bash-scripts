#!/bin/bash
if [[ $DEBIG == "true" ]]; then
    mkfifo pipe
fi

mode="add"
current=1
generator_pid=""

(tail -f pipe) | while true; do
    read line
    if [[ -z $generator_pid ]]; then
        generator_pid=$line
        continue
    fi
    case $line in
        "+")
            mode="add"
            echo "Mode swithced to addition"
            ;;
        "*")
            mode="mult"
            echo "Mode switched to multiplication"
            ;;
        "QUIT")
            echo "Exiting..."
            exit 0
            ;;
        [0-9]*)
            if [[ $mode == "add" ]]; then
                ((current+=$line))
            else
                ((current*=$line))
            fi
            echo $current
            ;;
        *)
            echo "Invalid input"
            kill -9 $generator_pid
            exit 1
            ;;
    esac
done
