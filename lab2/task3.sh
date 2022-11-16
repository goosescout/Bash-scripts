#!/bin/bash
ps --pid $$ --ppid $$ -N --format pid,command,start --sort start_time | tail -1 | awk '{print $1" "$3" ("$2")"}'
