#!/bin/bash

function echoerr {
    echo "$@" 1>&2
}

function restore {
    if [[ ! -e "$1" ]]; then
        ln -- ~/.trash/$2 "$1" && {
            rm -- ~/.trash/$2 && {
                sed -i "/$2 /d" ~/.trash.log
                echo "Successfully restored $1"
            }
        }
    else 
        printf "Choose another name for the file to avoid conflict: "
        read new_filename < /dev/tty
        new_path=$(dirname -z -- "$1")/"$new_filename"
        restore "$new_path" $2
    fi
}

if [[ $# -ne 1 ]]; then
    echoerr "Filename not provided"
    exit 1
fi

grep -s -- "$1" ~/.trash.log |
while read line; do
    path=$(echo $line | awk '{for (i=2; i<NF; i++) printf $i " "; print $NF}')
    num=$(echo $line | awk '{print $1}')

    echo "Restore $path? (y/n)"
    read answer < /dev/tty
    if [[ $answer == "y" ]]; then
        directory=$(dirname -- "$path")
        if [[ ! -d $directory ]]; then
            echo "Directory $directory does not exist. Restoring file to home directory"
            new_path=~/$(basename -- "$path")
            restore "$new_path" $num
        else
            restore "$path" $num
        fi
    fi
done
