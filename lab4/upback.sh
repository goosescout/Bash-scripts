#!/bin/bash

function copy_files {
    for filename in $(ls ~/$1); do
        backup_path=$1$filename
        backup_abs_path=~/$1$filename
        if [[ -d $backup_abs_path ]]; then
            copy_files $backup_path/
        elif [[ -z $(echo $filename | grep -E "[0-9]{4}-[0-9]{2}-[0-9]{2}") ]]; then
            restore_abs_path=~/restore/${1:18}$filename
            mkdir -p $(dirname $restore_abs_path) &&
            cp $backup_abs_path $restore_abs_path
        fi
    done
}

if [[ ! -d ~/restore ]]; then
    mkdir ~/restore
fi

previous_backup=$(ls ~/ | grep -E "Backup-[0-9]{4}-[0-9]{2}-[0-9]{2}" | tail -1)
if [[ -z $previous_backup ]]; then
    exit 1
fi
copy_files $previous_backup/

