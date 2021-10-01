@ECHO OFF
TITLE TDBtoARC Windows Installation Tool V1
COLOR F

:TOP
CLS
ECHO.
ECHO Please enter your MySQL Info...
ECHO.
SET /p host= MySQL Server Address (e.g. localhost): 
SET /p port= MySQL Server Port (e.g. 3306): 
ECHO.
SET /p user= MySQL Username: 
SET /p pass= MySQL Password: 
ECHO.
SET /p world_db= World Database: 

SET mysqlpath=.\mysql\
SET extrasql=.\extra\
SET localesql=.\locale\

:Begin
CLS
SET v=""
ECHO.
ECHO    C - Convert TDB to ArcEmu structure
ECHO    R - Remove not more needed tables
ECHO    A - Add ArcEmu world structure
ECHO.
ECHO.
ECHO    L - Delete localization
ECHO.
ECHO.
ECHO.
ECHO    S - Change your settings
ECHO.
ECHO    Q - Quit
ECHO.
SET /p v= 		Enter a char: 
IF %v%==* GOTO error
IF %v%==c GOTO converttdb
IF %v%==C GOTO converttdb
IF %v%==a GOTO addstructure
IF %v%==A GOTO addstructure
IF %v%==l GOTO deletelocale
IF %v%==L GOTO deletelocale
IF %v%==r GOTO remove
IF %v%==R GOTO remove
IF %v%==s GOTO top
IF %v%==S GOTO top
IF %v%==q GOTO exit
IF %v%==Q GOTO exit
IF %v%=="" GOTO exit
GOTO error

:converttdb
CLS
ECHO.
ECHO Converting TDB to ArcEmu structure...
ECHO.
for %%C in (scripts\*.sql) do (
	ECHO executing: %%~nxC
	%mysqlpath%\mysql --host=%host% --user=%user% --password=%pass% --port=%port% %world_db% < "%%~fC"
)
ECHO Database converted sucesfully!
ECHO.
PAUSE   
GOTO begin

:addstructure
CLS
ECHO.
ECHO Adding ArcEmu world structure...
ECHO.
%mysqlpath%\mysql --host=%host% --user=%user% --password=%pass% --port=%port% %world_db% < %extrasql%\add_arc_world_structure.sql
ECHO.
ECHO      Structure added sucesfully!
ECHO.
PAUSE
GOTO begin

:remove
CLS
ECHO.
ECHO Removing not more needed tables...
ECHO.
%mysqlpath%\mysql --host=%host% --user=%user% --password=%pass% --port=%port% %world_db% < %extrasql%\remove_tdb_tables.sql
ECHO.
ECHO      Tables removed sucesfully!
ECHO.
PAUSE
GOTO begin

:deletelocale
CLS
ECHO.
ECHO    DE
ECHO    ES
ECHO    FR
ECHO    MX
ECHO.
ECHO    a - Delete all localization
ECHO.
ECHO.
ECHO    b - Back to main
ECHO.
ECHO Write name of locale
ECHO.
ECHO.
SET /p del=		Name:
ECHO.
IF %del%==a GOTO deleteall
IF %del%==A GOTO deleteall
IF %del%==b GOTO begin
IF %del%==B GOTO begin
ECHO      Deleting...
IF NOT EXIST "%localesql%\delete_locale_%del%.sql" GOTO error2
ECHO.
%mysqlpath%\mysql --host=%host% --user=%user% --password=%pass% --port=%port% %world_db% < %localesql%\delete_locale_%del%.sql
ECHO.
ECHO      File delete_locale_%del%.sql imported sucesfully!
ECHO.
PAUSE
GOTO deletelocale

:deleteall
CLS
ECHO.
ECHO Delete all localization....
ECHO.
for %%C in (locale\*.sql) do (
	ECHO executing: %%~nxC
	%mysqlpath%\mysql --host=%host% --user=%user% --password=%pass% --port=%port% %world_db% < "%%~fC"
)
ECHO.
ECHO Localization deleted sucesfully!
ECHO.
PAUSE   
GOTO begin

:error
ECHO	Please enter a correct character.
ECHO.
PAUSE
GOTO begin

:error2
ECHO	Localization with this name not found.
ECHO.
PAUSE
GOTO deletelocale

:exit