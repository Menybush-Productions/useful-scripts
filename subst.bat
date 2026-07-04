@echo off
setlocal enabledelayedexpansion

powershell			^
	-NoProfile		^
	-ExecutionPolicy Bypass ^
	-File ".\subst.ps1" -Source "%source%" -Dest "%dest%"