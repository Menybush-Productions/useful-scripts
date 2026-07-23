@echo off
setlocal enabledelayedexpansion

cd /d "%~dp0"
powershell -NoProfile -ExecutionPolicy Bypass -Command "& '.\startbrowser.ps1'"