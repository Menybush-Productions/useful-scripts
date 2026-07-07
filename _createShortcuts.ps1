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

# SIG # Begin signature block
# MIIGMgYJKoZIhvcNAQcCoIIGIzCCBh8CAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUAA8trHywLNpmdhSgWIJwkgwN
# jY6gggPIMIIDxDCCAqygAwIBAgIQRqaG/Zc3Po5BF31FOLqbBTANBgkqhkiG9w0B
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
# MBwGCisGAQQBgjcCAQsxDjAMBgorBgEEAYI3AgEVMCMGCSqGSIb3DQEJBDEWBBTN
# lDMM4aIHqHWSbrzE/RbMpb8TpzANBgkqhkiG9w0BAQEFAASCAQBwfQGkSXpfmzCG
# r6pwqcPZ06YKLr4AHfaUCu6H7AYxqzzTUVEP49MR7ZL1ixnmj2cXBmGURd+QsV1H
# evoOXVp978zHchp0XPYG9wmOX13qMun78lTphCBC+ZYC/WIkd56wtuHug5ChiGAr
# wTHPjPLjyl3/xPYd6eXX9Zq308ii+sjfpv9seqetcRb+AyTLjYMwWJ4MqxctwjhI
# afTDhCXIslKHVl63Z0+KAiKuXOd3lL6PKZ/CHzshit6jvK+ae+BVizM5ZMiSMhAo
# X7nmcLYHrbwOY6ZGP73qJQ0eMaUry8IwHyUptBjVfZx+5gl2feIbAN4O9u4blV5C
# nxZRk2nu
# SIG # End signature block
