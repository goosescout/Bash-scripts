#!/bin/bash
> full.log
sed -n "/.*: \[WARN]/p" /var/log/syslog | sed "s/\[WARN\]/Warning:/g" >> full.log
sed -n "/.*: \[INFO]/p" /var/log/syslog | sed "s/\[INFO\]/Information:/g" >> full.log
cat full.log
