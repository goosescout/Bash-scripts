#!/bin/bash

function echoerr {
    echo "$@" 1>&2
}

if [[ $DEBUG == "true" ]]; then
    rmdir ~/.trash
    touch ~/.trash.log
fi

if [[ $# -ne 1 ]]; then
    echoerr "Exactly 1 argument must be provided"
    exit 1
fi

mkdir ~/.trash 2> /dev/null

if [[ ! -f ~/.trash.log ]]; then
    touch ~/.trash.log
fi

counter=0
while [[ -e ~/.trash/$counter ]]; do
    ((counter++))
done

ln -- "$1" ~/.trash/$counter && {
    rm -- "$1" && {
        echo $counter $(realpath -- "$1") >> ~/.trash.log
    } || {
        echoerr "Unable to remove file"
    }
} || {
    echoerr "Unable to create link"
}
