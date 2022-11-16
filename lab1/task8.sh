#!/bin/bash
declare -A users
IFS=":"

while read line; do
    split_line=($line)
    users[${split_line[2]}]=${split_line[0]}
done < /etc/passwd
unset IFS

while read line; do
    echo "id: $line, user: ${users[$line]}"
done < <(echo "${!users[@]}" | tr " " "\n" | sort -n)
