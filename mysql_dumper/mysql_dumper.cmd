@echo off
echo MySQL dumper script for Windows
echo author: Sergey Dyagovchenko, http://d.sumy.ua/,
echo github: https://github.com/DyaGa/mysql_dump_win
echo version: 16.12.2012
echo ------------------------------
echo dependencies: mysql_run_to_import_dumps.exe, mysqldump.exe
echo ------------------------------

:: ��������� ������� ������� ������������� ���������
if [%2]==[] (goto :show_error) else (goto :set_sql_file)

:show_error
echo ERROR: 1-st parameter (database name) should be set.
goto :eof

:set_sql_file
:: MySQL ���� (�������� MySQL-XXX �� ���������� �������� �����)
set MYSQL_PATH=Q:\modules\database\MySQL-XXX

:: ������������� �������� ���� (������� ��� 2 �������� � ���������� ������)
set DB_NAME=%2

:: ������������� �������� ����� ����� ����
:: �������� �������� SQL ����� �� ���������� ������ (3-� ��������)
if [%3]==[] (set SQL_FILE=%DB_NAME%.sql) else (set SQL_FILE=%3)

:: ������� ������� ����� ������������ (4-� ��������)
:: ���������: --tables t1 t2 ...
if [%4]==[] (set DB_TABLES=) else (set DB_TABLES=%~4)

:: ������� ������� ����� ��������
:: ���������: --ignore-table=%DB_NAME%.table1 --ignore-table=%DB_NAME%.table2
set DB_TABLES_IGNORE=

set CURRENT_DIR=%CD%

:: �������� �����, ���� restore, ���� backup (1-� ��������)
set DUMP_CMD=%1

echo CURRENT_DIR: %CURRENT_DIR%
echo DUMP_CMD: %DUMP_CMD%
echo DB_NAME: %DB_NAME%
echo SQL_FILE: %SQL_FILE%
echo DB_TABLES: %DB_TABLES%
echo ------------------------------

if %DUMP_CMD%==restore (goto :restore)
if %DUMP_CMD%==backup (goto :backup)

echo ������. ���������� �������� ��� ������� ���������: restore|backup
goto :eof

:restore
:: ��������������� ����
echo.
echo Restoring...
%MYSQL_PATH%\bin\mysql_run_to_import_dumps.exe -u root %DB_NAME% < %SQL_FILE%

:: ���� ������� �������
pause

goto :eof

:backup
:: ������ ���� ����
echo.
echo Make backup...

:: command list: http://dev.mysql.com/doc/refman/5.5/en/mysqldump.html
%MYSQL_PATH%\bin\mysqldump.exe -u root --add-drop-table --skip-complete_insert --skip-extended-insert --set-charset --default_character_set=utf8 --order-by-primary --verbose %DB_TABLES_IGNORE% --databases %DB_NAME% %DB_TABLES% > %SQL_FILE%

:: ���� ������� �������
pause

goto :eof