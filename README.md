mysql_dump_win
==============

MySQL dumper batch scripts for Windows

- Sergey Dyagovchenko, http://d.sumy.ua/
- версия: 16.12.2012
- github: https://github.com/DyaGa/mysql_dump_win

Этот скрипт является переделанной версией скрипта, которую разработал [Артем Волк](http://artvolk.sumy.ua/). Спасибо тебе Артем :)

Зависимости
===========

Перед установкой скриптов необходимо удостоверится что:

 - Вы используюете систему Windows :)
 - Локально у Вас установлены и настроены: Apache, php, MySQL. Обычно, для этого используют WAMP платформы, например: [OpenServer](http://open-server.ru/), [Denwer](http://www.denwer.ru/) и т.п.

Установка скриптов
=======================

Инструкция будет основана на примерении работы скрипта в рамках платформы *OpenServer* ([Краткая инструкция по установке](https://github.com/DyaGa/dev-workspace/wiki/WAMP-платформа-OpenServer.-Установка-и-настройка)).

После установки и настройки *OpenServer*'а необходимо скопировать файл `mysql_run_to_import_dumps.exe` в папку `bin` системы *MySQL*. Например, для версии *Open Server 4.7.4* это будет папка: `modules\database\MySQL-5.1.66\bin\`. Это даст возможность импортировать SQL файлы в базу данных.

Также, необходимо просто скопировать файл `userdata\config\MySQL-5.1.66_my.ini` в файл `modules\database\MySQL-5.1.66\my.cnf`.

Далее, копируем папку `mysql_dumper` в корневую папку *OpenServer*'а. Должно получится вот так:

```
domains
modules
mysql_dumper
userdata
Open Server.exe
```

Если наш проект называется, например, `Project` и находится в папке `domains\project`, то копируем полностью папку `_dump` в корневую директорию проекта. Должно получится следующая структура:

```
domains\project\_dump\backup.cmd
domains\project\_dump\restore.cmd
```

Настройка скриптов
==================

Редактируем наш скопированный файл `mysql_dumper\mysql_dumper.cmd`. В нем находим 19 строку:

```
set MYSQL_PATH=Q:\modules\database\MySQL-XXX
```

и меняем ее, в зависимости от используемой версии *MySQL*, на:

```
set MYSQL_PATH=Q:\modules\database\MySQL-5.1.66
```

Если название проекта и название базы данных совпадают (в нашем примере это `project`), то в скриптах `backup.cmd` и `restore.cmd` ничего не меняем.

Если же, название проекта и базы данных разные, к примеру, проект `project`, а база данных будет называться `project-new`, то необходимо в `backup.cmd` и `restore.cmd` поменять следующую сторку:

```
set DB_NAME=%CD:~11,-6%
```

на

```
set DB_NAME=project-new
```

Запуск скриптов
===============

Для создания резервной копии базы данных запускаем `backup.cmd`. Если при этом нету ошибок, то в этой же папке появится файл `project.sql` (либо `project-new.sql`). Все ошибки выводятся в коммандной консоли.

Для восстановления резервной копии базы данных запускаем `restore.cmd`.
