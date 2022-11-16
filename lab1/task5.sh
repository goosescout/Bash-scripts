#!/bin/bash
sed -n "/.*: \[INFO\]/p" /var/log/syslog > info.log
