@ECHO OFF
TITLE TDBtoARC Installation Tool
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

:Begin
CLS
SET v=""
ECHO.
ECHO    C - Convert TDB to ArcEmu structure
ECHO    R - Remove not more needed tables
ECHO    A - Add ArcEmu world structure
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

:error
ECHO	Please enter a correct character.
ECHO.
PAUSE
GOTO begin

:exit