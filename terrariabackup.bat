::                   _    _                         
::                  | |  | |                        
::   _ __   ___  ___| | _| | ___  ___ ___           
::  |  _ \ / _ \/ __| |/ / |/ _ \/ __/ __|          
::  | | | |  __/ (__|   <| |  __/\__ \__ \   ______ 
::  |_| |_|\___|\___|_|\_\_|\___||___/___/  |______|
::                                                  
::
::
:: https://github.com/neckless-was-taken/automatic-terraria-backup-v1
:: This is an automatic terraria worlds and players backup script written up by /u/neckless_ or neckless-was-taken on GitHub
:: If you're looking to change your directories, this isn't where you'll find them, go to usersettings.cmd and edit that
::
:: Other than that you're welcome to look through this and if you have any suggestions message me on Reddit or add it as an issue on GitHub
:: I have added comments to most sections to explain what they're intended to do, so should be relatively easy to look through the code
::
::
::
::
::
::
::
::
::
::
::
@echo off
SETLOCAL EnableExtensions
title Automatic Terraria Backup
set /A b=0
:: whenever you see these next two lines of code, they just re-set the hourly time stamp to be accurate and add a 0 to the start if it's a single digit (i.e. 1:42:53 becomes 01:42:53)
:: since the variables can't be dynamically updated whenever called up-on i've just pasted in these two lines throughout the code to keep the timestamp up-to-time
set hour=%time:~0,2%
if "%hour:~0,1%" == " "  set hour=0%hour:~1,1%
:: sets EXE variables for later use when checking if they're running in tasklist
set game_EXE=Terraria_game.exe
set backup_EXE=googledrivesync.exe

call :art
echo [%hour%:%time:~3,2%:%time:~6,2%] Welcome to Automatic Terraria backup!
echo [%hour%:%time:~3,2%:%time:~6,2%] This little script was written up by /u/neckless_ or neckless-was-taken on GitHub
echo [%hour%:%time:~3,2%:%time:~6,2%] https://github.com/neckless-was-taken/automatic-terraria-backup-v1

:: Checks if usersettings.cmd exists
if not exist "usersettings.cmd" (goto :initial_setup)

:: Checks if game is running
:game_check
timeout /t 5 /nobreak > NUL
if %b%==1 goto stop
for /F %%x IN ('tasklist /NH /FI "IMAGENAME eq %game_EXE%"') DO IF %%x == %game_EXE% goto game_check_skip
set b=1
echo [%hour%:%time:~3,2%:%time:~6,2%] Terraria appears to not be running . . .
echo [%hour%:%time:~3,2%:%time:~6,2%] Checking if it's running again in 15 seconds, if it's still not running, stopping the script . . .
timeout /t 10 /nobreak > NUL
goto game_check
:game_check_stop
echo [%hour%:%time:~3,2%:%time:~6,2%] Terraria appears to still not be running . . .
echo [%hour%:%time:~3,2%:%time:~6,2%] Stopping Automatic Terraria Backup . . .
echo [%hour%:%time:~3,2%:%time:~6,2%] Press any key to exit . . .
pause > NUL
exit
:game_check_skip

if %b%==1 ( echo [%hour%:%time:~3,2%:%time:~6,2%] Terraria is finally running . . . ) else ( echo [%hour%:%time:~3,2%:%time:~6,2%] Terraria is running . . . )
echo [%hour%:%time:~3,2%:%time:~6,2%] Starting Automatic Terraria Backup . . .


:: checks if EXEs have been setup to work with the script, if not it renames them, also backs up current Terraria.exe
if exist "Terraria_game.exe" ( goto skip1 )
mkdir .atb_backup > NUL
copy "minstart.exe" ".atb_backup\minstart.exe" > NUL
copy "Terraria.exe" ".atb_backup\Terraria_old.exe" > NUL
ren Terraria.exe Terraria_game.exe > NUL
ren minstart.exe Terraria.exe > NUL
:skip1
call usersettings.cmd
:: creates the directories used by the script
if not exist "%destination_worlds%" mkdir "%destination_worlds%" > NUL
if not exist "%archive%" mkdir "%archive%" > NUL
:: checks if the user has set up players folder backup, if not skips this part
if not %players_conf%==y ( goto skip2 )
if not exist "%destination_players%" mkdir "%destination_players%" > NUL
:skip2

set tempo=%temp%\backuparchiver
mkdir %tempo%
goto start

:: start of main backup script

:start
set /A t = 0
:: worlds backuper
set hour=%time:~0,2%
if "%hour:~0,1%" == " "  set hour=0%hour:~1,1%
XCOPY /E /I  "%source_worlds%"  "%destination_worlds%\Worlds_%hour%%time:~3,2%-%date:~0,2%%date:~3,2%%date:~6,4%" /Y
forfiles -p "%destination_worlds%" -m *.* -d -%max_days% -c "cmd  /c del /q @path" 2> NUL
forfiles -p "%destination_worlds%" -d -%max_days% -c "cmd /c IF @isdir == TRUE rd /S /Q @path" 2> NUL
:: checks if the user has set up players folder backup, if not skips this part
if not %players_conf%==y ( goto players_backup_skip )
:: players backuper
set hour=%time:~0,2%
if "%hour:~0,1%" == " "  set hour=0%hour:~1,1%
XCOPY /E /I  "%source_players%"  "%destination_players%\Players_%hour%%time:~3,2%-%date:~0,2%%date:~3,2%%date:~6,4%" /Y
forfiles -p "%destination_players%" -m *.* -d -%max_days% -c "cmd  /c del /q @path" 2> NUL
forfiles -p "%destination_players%" -d -%max_days% -c "cmd /c IF @isdir == TRUE rd /S /Q @path" 2> NUL
:players_backup_skip

:: this loop continously checks if the game is running,
:loop
set hour=%time:~0,2%
if "%hour:~0,1%" == " "  set hour=0%hour:~1,1%
for /F %%x IN ('tasklist /NH /FI "IMAGENAME eq %game_EXE%"') DO IF %%x == %game_EXE% goto game_found
echo [%hour%:%time:~3,2%:%time:~6,2%] Terraria is no longer running . . .
goto archiver

:game_found
set hour=%time:~0,2%
if "%hour:~0,1%" == " "  set hour=0%hour:~1,1%
set /A c =%t% %% %15%
if %c%==0 echo [%hour%:%time:~3,2%:%time:~6,2%] Terraria is still running
timeout /t 30 /nobreak > NUL
set /A t = %t%+1
if %t%==60 (goto start) else (goto loop)

:: end of main backup script

:: start of backup archivere

:archiver
set hour=%time:~0,2%
if "%hour:~0,1%" == " "  set hour=0%hour:~1,1%

:: checks if googledrivesync is opened, if not opens it
for /F %%x IN ('tasklist /NH /FI "IMAGENAME eq %backup_EXE%"') DO IF %%x == %backup_EXE% goto skip3
echo [%hour%:%time:~3,2%:%time:~6,2%] Starting Backup and Sync by Google . . .
start "" "C:\Program Files\Google\Drive\googledrivesync.exe" 2> NUL
timeout /t 5 /nobreak > NUL
:skip3
mkdir  %tempo% 2> NUL
FOR /f "delims=" %%a IN (
  'dir /b /ad /o-d "%destination_worlds%\*" '
  ) DO XCOPY /S /I /N "%destination_worlds%\%%a" "%tempo%\Worlds_%hour%%time:~3,2%-%date:~0,2%%date:~3,2%%date:~6,4%" &GOTO worlds_archiver_done
)
:worlds_archiver_done
:: checks if the user has set up players folder backup, if not skips this part
if not %players_conf%==y ( goto archiver_done )
FOR /f "delims=" %%a IN (
  'dir /b /ad /o-d "%destination_players%\*" '
  ) DO XCOPY /S /I /N "%destination_players%\%%a" "%tempo%\Players_%hour%%time:~3,2%-%date:~0,2%%date:~3,2%%date:~6,4%" &GOTO archiver_done
)
:archiver_done
echo [%hour%:%time:~3,2%:%time:~6,2%] Archiving the last backups made . . .
PUSHD %tempo%
for /d %%X in (*) do "C:\Program Files\7-Zip\7z.exe" a "%%X.zip" "%%X\"
POPD
copy "%tempo%\*.zip" "%archive%"
echo [%hour%:%time:~3,2%:%time:~6,2%] Archiving complete
goto exit

:: end of backup archiver

:: exit sequence

:exit
set hour=%time:~0,2%
if "%hour:~0,1%" == " "  set hour=0%hour:~1,1%
echo [%hour%:%time:~3,2%:%time:~6,2%] Stopping Backup ^& Sync from Google in 30 seconds to let it finish uploading and then exiting . . .
timeout /t 30 /nobreak > NUL
taskkill /im %backup_EXE% /F
echo [%hour%:%time:~3,2%:%time:~6,2%] Cleaning up the temporary files created by Automatic Terraria Backup . . .
if exist %tempo% RMDIR /S /Q %tempo%
timeout /t 5 /nobreak > NUL
exit

:: storage for some stuff that can be called when needed

:: ascii art work
:art
echo                  _    _                   
echo                 ^| ^|  ^| ^|                  
echo  _ __   ___  ___^| ^| _^| ^| ___  ___ ___     
echo ^|  _ \ / _ \/ __^| ^|/ / ^|/ _ \/ __/ __^|    
echo ^| ^| ^| ^|  __/ (__^|   ^<^| ^|  __/\__ \__ \   ______
echo ^|_^| ^|_^|\___^|\___^|_^|\_\_^|\___^|^|___/___/  ^|______^|
echo.
exit /B

:: initial setup sequence
:initial_setup
set hour=%time:~0,2%
if "%hour:~0,1%" == " "  set hour=0%hour:~1,1%
echo.
echo [%hour%:%time:~3,2%:%time:~6,2%] Looks like this is the first time you've opened Automatic Terraria Backup
echo [%hour%:%time:~3,2%:%time:~6,2%] Let's set you up! All you need to do is point at some directories
echo [%hour%:%time:~3,2%:%time:~6,2%] If you want to use the default locations, just press Enter when prompted
echo [%hour%:%time:~3,2%:%time:~6,2%] You can change these directories at any time by editing the usersettings.cmd file in your Terraria install folder
echo [%hour%:%time:~3,2%:%time:~6,2%] This code was intended to be used alongside Backup and Sync by Google to automatically upload archived backups to your Google Drive so you don't loose them
echo.
echo [%hour%:%time:~3,2%:%time:~6,2%] Press any key to continue . . .
pause > NUL
echo.

set source_worlds=%USERPROFILE%\Documents\My Games\Terraria\Worlds
echo [%hour%:%time:~3,2%:%time:~6,2%] If you have Steam Cloud turned on for the worlds you want to actively back up set this to [Steam install directory]/userdata/[Your Steam ID]/105600/remote/worlds
set /p "source_worlds=[%hour%:%time:~3,2%:%time:~6,2%] Location of your worlds folder [Default=%source_worlds%] : " string ( str ^)  
echo [%hour%:%time:~3,2%:%time:~6,2%] Worlds folder set as : %source_worlds%
echo.

set destination_worlds=%USERPROFILE%\Desktop\Terraria Backups\Worlds
set /p "destination_worlds=[%hour%:%time:~3,2%:%time:~6,2%] Where you want your worlds backups to end up at [Default=%destination_worlds%] : " string ( str ^)  
echo [%hour%:%time:~3,2%:%time:~6,2%] Worlds backup storage folder set as : %destination_worlds%
echo.

:players_question
set /P "players_conf=[%hour%:%time:~3,2%:%time:~6,2%] Do you want to also backup your Players folder? [Y/N]: " string ( str ^) 
if "%players_conf%" == "" ( goto players_question )
if %players_conf%== y goto players_yes
if %players_conf%== n goto players_no
if %players_conf%== Y goto players_yes
if %players_conf%== N goto players_no
goto players_question

:players_no
set source_players=%USERPROFILE%\Documents\My Games\Terraria\Players
set destination_players=%USERPROFILE%\Desktop\Terraria Backups\Players
goto players_skip

:players_yes
echo.
set source_players=%USERPROFILE%\Documents\My Games\Terraria\Players
echo [%hour%:%time:~3,2%:%time:~6,2%] If you have Steam Cloud turned on for the Players you want to actively back up set this to [Steam install directory]/userdata/[Your Steam ID]/105600/remote/players
set /p "source_players=[%hour%:%time:~3,2%:%time:~6,2%] Location of your Players folder [Default=%source_players%] : " string ( str ^)  
echo [%hour%:%time:~3,2%:%time:~6,2%] Players folder set as : %source_players%
echo.
set destination_players=%USERPROFILE%\Desktop\Terraria Backups\Players
set /p "destination_players=[%hour%:%time:~3,2%:%time:~6,2%] Where you want your players backups to end up at [Default=%destination_players%] : " string ( str ^)  
echo [%hour%:%time:~3,2%:%time:~6,2%] Players backup storage folder set as : %destination_players%
goto players_skip
:players_skip
echo.

set max_days=1
set /p "source_worlds=[%hour%:%time:~3,2%:%time:~6,2%] How long do you want your backups to be there before they get deleted? [in days] [Default=%max_days%] : " string ( str ^)  
if "%max_days%" GTR "1" goto max_days_2
goto max_days_1
:max_days_2
echo [%hour%:%time:~3,2%:%time:~6,2%] Max backup age set as : %max_days% days
goto max_days_skip
:max_days_1
set max_days=1
echo [%hour%:%time:~3,2%:%time:~6,2%] Max backup age set as : %max_days% day
goto max_days_skip
:max_days_skip
echo.

set archive=%USERPROFILE%\Desktop\Terraria Backups\Archive
set /p "archive=[%hour%:%time:~3,2%:%time:~6,2%] Where do you want your archived backups to end up? [Default=%archive%] : " string ( str ^)  
echo [%hour%:%time:~3,2%:%time:~6,2%] Archived backup folder set as : %archive%
echo [%hour%:%time:~3,2%:%time:~6,2%] This is the folder you need to set up to be automatically uploaded to your Google Drive using "Backup and Sync by Google"
echo.
goto usersettings_writer

:: writes usersettings.cmd in current directory
:usersettings_writer
echo.
echo [%hour%:%time:~3,2%:%time:~6,2%] Writing usersettings.cmd . . .
>usersettings.cmd (
echo.
echo  :: this determines if you want to backup your players [y/n] lower case letters only!
echo set players_conf=%players_conf%
echo.
echo  :: this is your worlds folder
echo  :: change this to [wherever steam is installed]/userdata/[your steam id]/105600/remote/worlds if you have Steam Cloud turned on for the worlds you want to back up
echo set source_worlds=%source_worlds%
echo.
echo  :: this is your players folder
echo  :: change this to [wherever steam is installed]/userdata/[your steam id]/105600/remote/players if you have Steam Cloud turned on for the players you want to back up
echo set source_players=%source_players%
echo.
echo  :: this is where your worlds backups end up
echo set destination_worlds=%destination_worlds%
echo.
echo  :: this is where your player backups end up
echo set destination_players=%destination_players%
echo.
echo  :: this is where your archived backups end up and this is the folder you want to set up to automatically upload to your google drive
echo set archive=%archive%
echo.
echo  :: any backups older than max_days will get deleted next time you run the backup script. This is why there's an archive of the last backup made everytime you close the script
echo set max_days=%max_days%
echo.
)

:: does some renaming of files, makes a backup in current directory for Terraria.exe and minstart.exe at ..\.atb_backup\
:: if something breaks and the script no longer launches with Terraria, delete your Terraria.exe, Terraria_game.exe
:: the script will do the renaming automatically
set hour=%time:~0,2%
if "%hour:~0,1%" == " "  set hour=0%hour:~1,1%
mkdir .atb_backup > NUL
copy "minstart.exe" ".atb_backup\minstart.exe" > NUL
copy "Terraria.exe" ".atb_backup\Terraria_old.exe" > NUL
ren Terraria.exe Terraria_game.exe > NUL
ren minstart.exe Terraria.exe > NUL
echo [%hour%:%time:~3,2%:%time:~6,2%] Initial set up has been completed
echo [%hour%:%time:~3,2%:%time:~6,2%] You can now launch Terraria through Steam and the script will run automatically
echo [%hour%:%time:~3,2%:%time:~6,2%] Press any key to exit . . .
pause > NUL
exit

:: end of code
