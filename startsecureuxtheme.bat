@echo off
net file 1>nul 2>nul && goto :run ^
  || powershell -ex unrestricted -Command "Start-Process -Verb RunAs -FilePath '%comspec%' -ArgumentList '/c %~fnx0 %*'"
goto :eof

:run
cd /d "%~dp0"
for /f "delims=" %%I in ('powershell -Command "((Get-Content startsecureuxtheme.json -Raw) | ConvertFrom-Json).PATH"') do set "EXE_PATH=%%I"
start "" "%EXE_PATH%"