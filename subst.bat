@echo off
setlocal enabledelayedexpansion

set source="%~1"
set dest="%~2"

powershell			^
	-NoProfile		^
	-ExecutionPolicy Bypass ^
	-Command "& '.\subst.ps1' -Source '%source%' -Dest '%dest%'"