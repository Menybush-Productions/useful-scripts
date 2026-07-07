function Invoke-ReadKey {
	param (
		[Parameter(Mandatory = $false)] [string]$message = "Press a key to continue..."
	)
	Write-Host $message -ForegroundColor Cyan
	$null = [System.Console]::ReadKey($true)
	Clear-Host
}

Write-Host 'Creating Shortcuts for all scripts in the current directory recursively...' -ForegroundColor Cyan
Write-Host '############################'

$outFolder = Join-Path -Path $PSScriptRoot -ChildPath "shortcuts"
if (-not (Test-Path -Path $outFolder)) {
	New-Item -ItemType Directory -Path $outFolder | Out-Null
	Write-Host "Created new folder: $outFolder" -ForegroundColor Green
}

$shell = New-Object -ComObject WScript.Shell

Get-ChildItem -Path $PSScriptRoot -Filter *.bat -Recurse | ForEach-Object {
	$scName = $_.BaseName + '.lnk'
	$scPath = Join-Path -Path $outFolder -ChildPath $scName
	$sc = $shell.CreateShortcut($scPath)
	$sc.TargetPath = $_.FullName
	$sc.Save()
}

Write-Host '############################'
Invoke-ReadKey -message "Press any key to exit..."
