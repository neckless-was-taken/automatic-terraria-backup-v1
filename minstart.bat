@echo off
if exist "terrariabackup.exe" goto exe
if exist "terrariabackup.bat" goto bat
goto eof

:exe
start /min "" "terrariabackup.exe"
start Terraria_game.exe
goto eof
:bat
start /min "" "terrariabackup.bat"
start Terraria_game.exe
goto eof
:eof
exit