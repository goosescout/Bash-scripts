#!/bin/bash
echo "Select item 1-4 from menu:
1. nano
2. vi
3. links
4. exit menu"
printf "Enter a number from 1 to 4: "
read choice

case $choice in
    "1") nano;;
    "2") vi;;
    "3") links;;
    "4") exit;;
    *) echo "Menu entry not found";;
esac
