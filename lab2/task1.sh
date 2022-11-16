ps -U goosescout --format pid,command | awk '{print $1": "$2}' | sed "1d" > result1.txt
sed -i "1s/^/$(wc -l result1.txt | awk '{print $1}')\n/" result1.txt
