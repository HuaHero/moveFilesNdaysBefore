@ECHO OFF
REM 声明采用UTF-8编码
chcp 65001

rem GetDateNdaysBefore
SetLocal EnableDelayedExpansion
rem SET CmdFile="C:\cmd.ini"
SET "StartDate="
SET Ndays=90  
call:getDate %Ndays% StartDate
echo %StartDate%
rem > %CmdFile% echo RangeBegin=%StartDate%
pause

:getDate
set day=%~1
echo >"%temp%\%~n0.vbs" s=DateAdd("d",%day%,now) : d=weekday(s)
echo>>"%temp%\%~n0.vbs" WScript.Echo year(s)^& right(100+month(s),2)^& right(100+day(s),2)
for /f %%a in ('cscript /nologo "%temp%\%~n0.vbs"') do set "%~2=%%a

rem XMOVE files to backup_dir
SET Backup_Dir="F:\Backup_bills"
IF NOT EXIST %Backup_Dir% (MKDIR %Backup_Dir%)
SET SourceTxtDir="F:\2 资料\Bill\TxtBills"
SET SourceCurDir="F:\2 资料\Bill\CurFile"
echo %SourceTxtDir%
forfiles /p %SourceTxtDir% /d %Ndays% /c "cmd /c move /-y @SourceTxtDir @Backup_Dir"

move /-y %SourceTxtDir%\*%StartDate%* %Backup_Dir%

forfiles /p %SourceCurDir% -s /c "cmd /c move /-y *%StartDate%\* @Backup_Dir"



pause
Goto :Eof