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
:: This is an uninstaller for the automatic terraria backup script written up by /u/neckless_ or neckless-was-taken on GitHub
::
:: To see what files this particular script touches you can scroll down to the next comment after this bunch
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
::
::
@echo off
title Automatic Terraria Backup uninstaller
set hour=%time:~0,2%
if "%hour:~0,1%" == " "  set hour=0%hour:~1,1%
call :art
echo [%hour%:%time:~3,2%:%time:~6,2%] This is the uninstaller for Automatic Terraria Backup by /u/neckless_ or neckless-was-taken on GitHub
echo [%hour%:%time:~3,2%:%time:~6,2%] https://github.com/neckless-was-taken/automatic-terraria-backup-v1
:question_loop
set hour=%time:~0,2%
if "%hour:~0,1%" == " "  set hour=0%hour:~1,1%
set /P "conf=[%hour%:%time:~3,2%:%time:~6,2%] Are you sure you want to uninstall? [Y/N]: " string ( str ^) 
if %conf%== y goto yes
if %conf%== n goto no
if %conf%== Y goto yes
if %conf%== N goto no
echo [%hour%:%time:~3,2%:%time:~6,2%] Wrong input, please press either [Y] for Yes or [N] for No
goto question_loop
:yes
set hour=%time:~0,2%
if "%hour:~0,1%" == " "  set hour=0%hour:~1,1%
echo.
echo [%hour%:%time:~3,2%:%time:~6,2%] Sad to see you go! :(
:: this is what it actually does                                                                                          
del "Terraria.exe" > NUL
del "terrariabackup.bat"  > NUL
del "usersettings.cmd" > NUL
ren "Terraria_game.exe" "Terraria.exe"  > NUL
del ".backup\minstart.exe" > NUL
rmdir "%temp%\backuparchiver" > NUL
::                                                                                                                        
echo [%hour%:%time:~3,2%:%time:~6,2%] Automatic Terraria Backup files have been removed and Terraria has been set up to work as normal!
echo [%hour%:%time:~3,2%:%time:~6,2%] The backups and archived backups made by the script have been left untouched. Their locations were set as : 
call usersettings.cmd > NUL
echo [%hour%:%time:~3,2%:%time:~6,2%] Worlds backup storage folder set as : %destination_worlds%
echo [%hour%:%time:~3,2%:%time:~6,2%] Players backup storage folder set as : %destination_players%
echo [%hour%:%time:~3,2%:%time:~6,2%] Archived backup folder set as : %archive%
echo [%hour%:%time:~3,2%:%time:~6,2%] Delete this atbunins.bat after exiting, as it can't be automatically deleted
goto exit
:no
set hour=%time:~0,2%
if "%hour:~0,1%" == " "  set hour=0%hour:~1,1%
echo.
echo [%hour%:%time:~3,2%:%time:~6,2%] Whoo, glad to see you decided to stay after all!
goto exit

:exit
set hour=%time:~0,2%
if "%hour:~0,1%" == " "  set hour=0%hour:~1,1%
echo [%hour%:%time:~3,2%:%time:~6,2%] Press any key to exit . . .
pause >NUL
exit

:art
echo                  _    _                   
echo                 ^| ^|  ^| ^|                  
echo  _ __   ___  ___^| ^| _^| ^| ___  ___ ___     
echo ^|  _ \ / _ \/ __^| ^|/ / ^|/ _ \/ __/ __^|    
echo ^| ^| ^| ^|  __/ (__^|   ^<^| ^|  __/\__ \__ \   ______
echo ^|_^| ^|_^|\___^|\___^|_^|\_\_^|\___^|^|___/___/  ^|______^|
echo.
exit /B

pause