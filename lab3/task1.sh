#!/bin/bash
start=$(date +"%d_%m_%Y_%T")

if [[ $DEBUG == "true" ]]; then
    rm -r /home/test
    > ~/report
fi

mkdir /home/test 2> /dev/null && {
    echo "catalog test was created successfully" >> ~/report
    touch /home/test/$start
}
ping "www.net_nikogo.ru" 2> >(awk '{print "'$(date +"%d_%m_%Y_%T")' - " $0'} >> ~/report)
