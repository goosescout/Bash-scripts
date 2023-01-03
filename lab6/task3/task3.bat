net start > C:\lab6\task3\task3_1.txt
net stop spooler
timeout /t 3
net start > C:\lab6\task3\task3_2.txt
fc C:\lab6\task3\task3_1.txt C:\lab6\task3\task3_2.txt > C:\lab6\task3\task3_diff.txt
net start spooler
