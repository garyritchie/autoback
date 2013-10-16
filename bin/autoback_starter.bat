REM ~ autoback_starter.bat

REM ~ Use this from Windows Scheduler for daily backups. Can also be used to start a backup immediately.

REM ~ Set current working directory
cd /d Z:\BACKUP\autoback\bin

REM ~ Fixes #1...
set CYGWIN=nowinsymlinks 

c:\cygwin\bin\bash /cygdrive/z/BACKUP/autoback/bin/autoback.sh