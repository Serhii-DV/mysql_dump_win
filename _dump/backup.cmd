@echo off
:: Путь к скрипту mysql_dumper
set DUMP_PATH=%CD:~0,3%mysql_dumper\mysql_dumper.cmd
:: Имя MySQL базы дынных.
:: Т.к. в основном база называется точно так же как и проект, то название базы данных берем как часть пути к скрипту.
:: Если название проекта и базы данных будут разными, то необходимо ввести название базы здесь.
set DB_NAME=%CD:~11,-6%
:: Запускаем скрипт
call %DUMP_PATH% backup %DB_NAME%