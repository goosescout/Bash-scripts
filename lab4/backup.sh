#!/bin/bash

function create_dir {
    echo "Creating new backup directory"
    mkdir ~/Backup-$CURRENT_DATE && {
        BACKUP_DIR=~/Backup-$CURRENT_DATE
        echo "created new backup directory $BACKUP_DIR at $CURRENT_DATE" >> ~/backup-report
    } || exit 1
}

function init_dir {
    echo "Found existing backup directory: $previous_backup"
    BACKUP_DIR=~/$previous_backup
    echo "using previously created directory $BACKUP_DIR at $CURRENT_DATE" >> ~/backup-report
}

function copy_files {
    for filename in $(ls ~/source/); do
        cp -r ~/source/$filename $BACKUP_DIR &&
        echo "copied $filename to $BACKUP_DIR" >> ~/backup-report
    done  
}

function update_files {
    for filename in $(ls ~/$1); do
        source_path=$1$filename
        source_abs_path=~/$1$filename
        if [[ -d $source_abs_path ]]; then
            update_files $source_path/
        else
            backup_abs_path=$BACKUP_DIR/${1:7}$filename
            if [[ -e $backup_abs_path && $(stat $source_abs_path -c %s) -ne $(stat $backup_abs_path -c %s) ]]; then
                if [[ -e $backup_abs_path.$CURRENT_DATE ]]; then
                    counter=1
                    while [[ -e $backup_abs_path.$CURRENT_DATE"_"$counter ]]; do
                        ((counter++))
                    done
                    mv $backup_abs_path $backup_abs_path.$CURRENT_DATE"_"$counter && {
                        echo "renamed $backup_abs_path to $backup_abs_path.$CURRENT_DATE"_"$counter" >> ~/backup-report
                        cp $source_abs_path $BACKUP_DIR/${1:7} &&
                        echo "copied already existed file $source_abs_path to $BACKUP_DIR" >> ~/backup-report
                    }
                else
                    mv $backup_abs_path $backup_abs_path.$CURRENT_DATE && {
                        echo "renamed $backup_abs_path to $backup_abs_path.$CURRENT_DATE" >> ~/backup-report
                        cp $source_abs_path $BACKUP_DIR/${1:7} &&
                        echo "copied already existed file $source_abs_path to $BACKUP_DIR" >> ~/backup-report
                    }
                fi                    
            elif [[ ! -e $backup_abs_path ]]; then
                mkdir -p $BACKUP_DIR/${1:7} &&
                cp $source_abs_path $BACKUP_DIR/${1:7} &&
                echo "copied $source_abs_path to $BACKUP_DIR" >> ~/backup-report
            fi
        fi
    done
}

if [[ $DEBUG == "true" ]]; then
    for dir in $(ls ~/ | grep -E "Backup-[0-9]{4}-[0-9]{2}-[0-9]{2}"); do
        rm -rf ~/$dir
    done
    > ~/backup-report
fi

if [[ ! -f ~/backup-report ]]; then
    touch ~/backup-report
fi

CURRENT_DATE=$(date "+%F")
BACKUP_DIR=""

# ls sorts by name by default
previous_backup=$(ls ~/ | grep -E "Backup-[0-9]{4}-[0-9]{2}-[0-9]{2}" | tail -1)

if [[ -n $previous_backup ]]; then
    previous_date=$(echo $previous_backup | grep -oE "[0-9]{4}-[0-9]{2}-[0-9]{2}")
    previous_timestamp=$(date --date=$previous_date "+%s")
    ((previous_timestamp+=7*24*60*60))
    current_timestamp=$(date "+%s")
    
    if [[ $previous_timestamp -lt $current_timestamp ]]; then
        create_dir
        copy_files
    else
        init_dir
        update_files source/
    fi
else
    create_dir
    copy_files
fi
