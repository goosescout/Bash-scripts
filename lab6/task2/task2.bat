net share temp=C:\lab6\task2\temp
net use h: \\%computername%\temp

set /a HH=%time:~0,2%
set HH_str=00%HH%
set /a mm=%time:~3,2%+1
set mm_str=00%mm%
set "time_str=%HH_str:~-2%:%mm_str:~-2%"

@REM schtasks /create /sc once /tn task2_exec /tr "C:\lab6\task2\task2_exec.bat" /st %time_str%
schtasks /create /SC ONCE /TN task2_exec /TR "C:\Windows\System32\xcopy.exe /z C:\lab6\task2\copy.txt C:\lab6\task2\temp" /ST %time_str%

tasklist /fi "imagename eq task2_exec"

:loop
tasklist /fi "imagename eq task2_exec" 2>nul | find /i "task2_exec" >nul
if errorlevel 0 goto loop_exit
goto loop

:loop_exit
@schtasks /delete /tn task2_exec /f
taskkill /im task2_exec /f
fc C:\Windows\explorer.exe H:\explorer.exe > task2_diff.txt

C:\Windows\System32\xcopy.exe /z C:\Windows\explorer.exe H:\explorer.exe

@REM @REM C:\lab6\task2\task2_exec.bat
