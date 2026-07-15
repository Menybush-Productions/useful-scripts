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
				$pkgName = $list[$idx].Remove($header0.IndexOf("Version")).Remove(0, $header0.IndexOf("Id")).Trim()
				Write-Host "$pkgName" -ForegroundColor Green
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
# SIG # Begin signature block
# MIIGMgYJKoZIhvcNAQcCoIIGIzCCBh8CAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQU46YzgdFrLy+nSYFs6ZWqLTzQ
# DXSgggPIMIIDxDCCAqygAwIBAgIQRqaG/Zc3Po5BF31FOLqbBTANBgkqhkiG9w0B
# AQsFADAfMR0wGwYDVQQDDBRNZW55QnVzaCBQcm9kdWN0aW9uczAeFw0yNjA3MDQx
# MjE4MTZaFw0yOTA3MDQxMjI4MTVaMB8xHTAbBgNVBAMMFE1lbnlCdXNoIFByb2R1
# Y3Rpb25zMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEApsU5F3dB4odF
# OmirLR12kPkrcGMD5CAQmJBS+1K5E5eQskraDpOCnabKgnZTkDnnaQbgX5qNBr8n
# 6puHdKetrCp6TJfsJdfgoQEM/On7SE7iL0gk+oQFR+g4K5iGvRYI3Zl2VYsbchOb
# WD6Zedqn8KIkLaTc/5YRpuyTksXV822IjPDZjPt3p7A67RXtcI4cfVmKTL+4fAu+
# +H+/f130Rri+Fwa0OQIg8dGRnMLpcG2xTu5r7FUe32ev91U1e6XQLP5KXpsCmV/Y
# d1kHFl4Jr2/4LeXho/PV/p/LoJw3wSxzatL/5E3NO3AMUbbUthQm8hiqF0k89KgJ
# VtSPMIxYeQIDAQABo4H7MIH4MA4GA1UdDwEB/wQEAwIHgDATBgNVHSUEDDAKBggr
# BgEFBQcDAzAbBgNVHREEFDASghB3d3cubWVueWJ1c2guY29tMIGUBgkqhkiG9w0B
# CQ8EgYYwgYMwCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBLTALBglghkgBZQMEARYw
# CwYJYIZIAWUDBAEZMAsGCWCGSAFlAwQBAjALBglghkgBZQMEAQUwCgYIKoZIhvcN
# AwcwBwYFKw4DAgcwDgYIKoZIhvcNAwICAgCAMA4GCCqGSIb3DQMEAgICADAdBgNV
# HQ4EFgQUiCgfTgfVG/T9Rcqx31vUkiekS3cwDQYJKoZIhvcNAQELBQADggEBAFTh
# ZKU58S64HgkpghJXVTmLtSXxLBIAoPM1/wh9ZULo2Ub59qmcekbv5AJqqvv3/Ong
# ZKrncu2IZDJxRPdU7o/xZc5bHoyEAl+18y1qh/OnJAVg2h3zEKWokTkMcNo7cE19
# hcMUeeaJdOXtjgY/zlep2AQjArGJDF5kAqA60NUNeHxyjmv4iAw9m1MuHH4j6uRm
# 0BQeUdvUOJAeupdKVQVIUxg8ER4pq0cSh6xZYPS8/tSfUcWk94R6p7UXaoo4BJCG
# xmDChJyYgdpsGZ930A282zIoHXPa2VsGZNA23+Nkn8QN5AYEOWDRcD9vCwEQBhcS
# zq2tXv8sImITL5ULDqcxggHUMIIB0AIBATAzMB8xHTAbBgNVBAMMFE1lbnlCdXNo
# IFByb2R1Y3Rpb25zAhBGpob9lzc+jkEXfUU4upsFMAkGBSsOAwIaBQCgeDAYBgor
# BgEEAYI3AgEMMQowCKACgAChAoAAMBkGCSqGSIb3DQEJAzEMBgorBgEEAYI3AgEE
# MBwGCisGAQQBgjcCAQsxDjAMBgorBgEEAYI3AgEVMCMGCSqGSIb3DQEJBDEWBBS1
# DfRjZDhMPoCNkWtmNzY7cG+xGjANBgkqhkiG9w0BAQEFAASCAQBuFKgSWdUVeDqj
# MNWE2E3MpYKwPbzdfM5KU8uINqzjjVIIF0haqVM0mseFVoblXgDq8EVb0JRk3mWz
# oULjuVHwX/1gaVmcDVOrOxXKFVbyKaed8nzSjiOV18NsbJWX9uAdQs4bS5UVXRvT
# Moh9dZE9O2fsFGvQGRyIJzeUHVTt33G/FNyyhcVFdun25i/lEOFiC9UrwAb/LunI
# WYFRv3VACkp2C8XAfb3DD1JGn7AovSEtxaoTvF7ZZq3jT5Pt1tr0huwfCVHc5ETW
# 4jfJcYNo8+9LuWL4hIIyW+6lJXf8v75/10BV1HNfbKBnNObfCKcZUo/psSttfb14
# Q6XtvjK7
# SIG # End signature block
