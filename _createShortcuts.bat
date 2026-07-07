@echo off
setlocal enabledelayedexpansion
net file 1>nul 2>nul && goto :run ^
  || powershell -ex unrestricted -Command "Start-Process -Verb RunAs -FilePath '%comspec%' -ArgumentList '/c %~fnx0 %*'"
goto :eof

:run

cd /d "%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -File ".\_createShortcuts.ps1"