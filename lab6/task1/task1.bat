cd C:\
mkdir lab6
ver > C:\lab6\ver
systeminfo > C:\lab6\systeminfo
wmic diskdrive get model,serialNumber,size,mediaType >  C:\lab6\wmic_diskdrive_get_model
mkdir test
copy C:\lab6 C:\test
cd C:\test
copy C:\test C:\test\copy
for /f "skip=1 eol=: delims=" %F in ('dir /b /o-d') do @del "%F"
