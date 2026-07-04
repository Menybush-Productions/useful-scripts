function Invoke-ReadKey {
	param (
		[Parameter(Mandatory = $false)] [string]$message = "Press a key to continue..."
	)
	Write-Host $message -ForegroundColor Cyan
	$null = [System.Console]::ReadKey($true)
	Clear-Host
}
function Get-Index {
	param (
		[Parameter(Mandatory = $true)] [int	]$num,
		[Parameter(Mandatory = $true)] [int	]$max,
		[Parameter(Mandatory = $true)] [bool]$increment
	)
	if ($increment) {
		if ($num + 1 -gt $max) { return $max }
		else { return $num + 1 }
	}
	else {
		if ($num - 1 -lt 0) { return 0 }
		else { return $num - 1 }
	}
}

$exit = $false
do {
	$wingetUpgradeOut = winget upgrade --include-unknown
	
	$header0 = $wingetUpgradeOut[0]
	$header1 = $wingetUpgradeOut[1]
	$footer = $wingetUpgradeOut[$wingetUpgradeOut.Count - 1]
	
	$list = $wingetUpgradeOut -ne $header0 -ne $header1 -ne $footer
	if ($list.Count -eq 0) {
		Write-Host "No upgradable packages parsed." -ForegroundColor Cyan
		Invoke-ReadKey -message "Press any key to exit..."
		break
	}
	
	$idx = 0
	[int]$idxMax = $list.Count - 1

	$continue = $true
	do {
		$header0
		$header1

		For ($i = 0; $i -lt $list.Count; $i++) {
			if ($i -eq $idx) { Write-Host $list[$i] -ForegroundColor Black -BackgroundColor DarkGreen }
			else { Write-Host $list[$i] }
		}

		Write-Host $header1
		Write-Host "Press Escape or CTRL+C to exit!" -ForegroundColor Cyan

		$key = [Console]::ReadKey($true)
		switch ($key.Key) {
			"UpArrow" {
				$idx = Get-Index -num $idx -max $idxMax -increment $false
				break
			}
			"DownArrow" {
				$idx = Get-Index -num $idx -max $idxMax -increment $true
				break
			}
			"Enter" {
				$pkgName = ($list[$idx] -split '\s{2,}')[1] -replace '\s.*'
				Write-Host ""
				Write-Host "############################"
				winget upgrade $pkgName
				Write-Host "############################"
				Invoke-ReadKey
				$continue = $false
				break
			}
			"Escape" {
				$exit = $true
				$continue = $false
				break
			}
			Default {
			}
		}
		
		[Console]::SetCursorPosition(0, 0)

	} while ($continue)

} while (!$exit)