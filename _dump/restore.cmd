@echo off
set DUMP_PATH=%CD:~0,3%mysql_dumper\mysql_dumper.cmd
set DB_NAME=%CD:~11,-10% 
call %DUMP_PATH% restore %DB_NAME% 
