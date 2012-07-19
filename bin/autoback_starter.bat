REM ~ autoback_starter.bat

REM ~ Use this from Windows Scheduler for daily backups. Can also be used to start a backup immediately.

REM ~ Fixes #1...
set CYGWIN=nowinsymlinks 

rem c:\cygwin\bin\sh autoback.sh

c:\cygwin\bin\bash /cygdrive/z/BACKUP/autoback/bin/autoback.sh