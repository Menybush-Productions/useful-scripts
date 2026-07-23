function Invoke-ReadKey {
	param (
		[Parameter(Mandatory = $false)] [string]$message = "Press a key to continue..."
	)
	Write-Host $message -ForegroundColor Cyan
	$null = [System.Console]::ReadKey($true)
	Clear-Host
}

function Get-BrowserPath {
    [string]$browser = Get-Content -Path "startbrowser.json" | ConvertFrom-Json | Select-Object -ExpandProperty browser
    if (Test-Path -LiteralPath $browser) {
        return $browser
    } else {
        Write-Host "Browser path not found. Change the path in 'startbrowser.json'." -ForegroundColor Red
        Invoke-ReadKey -message "Press any key to exit..."
        exit
    }
}

function Get-OptimizerPath {
    [string]$optimizer = Get-Content -Path "startbrowser.json" | ConvertFrom-Json | Select-Object -ExpandProperty optimizer
    if (Test-Path -LiteralPath $optimizer) {
        return $optimizer
    } else {
        Write-Host "Optimizer path not found. Change the path in 'startbrowser.json'." -ForegroundColor Red
        Invoke-ReadKey -message "Press any key to exit..."
        exit
    }
}

$browserPath = Get-BrowserPath
$browserName = [System.IO.Path]::GetFileNameWithoutExtension($browserPath)

$optimizerPath = Get-OptimizerPath
$optimizerName = [System.IO.Path]::GetFileNameWithoutExtension($optimizerPath)

$browserRunning = Get-Process -Name $browserName -ErrorAction SilentlyContinue
$optimizerRunning = Get-Process -Name $optimizerName -ErrorAction SilentlyContinue


<#
| Is browser running | Is optimizer running | What to start           |
| ------------------ | -------------------- | ----------------------- |
| No                 | No                   | optimizer, then browser |
| Yes                | No                   | optimizer               |
| No                 | Yes                  | browser                 |
| Yes                | Yes                  | nothing                 | 
#>

if (-not $browserRunning -and -not $optimizerRunning) {
    Start-Process -FilePath $optimizerPath
    Start-Process -FilePath $browserPath
    Write-Host "Success: Started optimizer!" -ForegroundColor Green
    Write-Host "Success: Started browser!" -ForegroundColor Green
} elseif ($browserRunning -and -not $optimizerRunning) {
    Start-Process -FilePath $optimizerPath
    Write-Host "Success: Started optimizer!" -ForegroundColor Green
} elseif (-not $browserRunning -and $optimizerRunning) {
    Start-Process -FilePath $browserPath
    Write-Host "Success: Started browser!" -ForegroundColor Green
}


# SIG # Begin signature block
# MIIGMgYJKoZIhvcNAQcCoIIGIzCCBh8CAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUUYCy0ra0xtSkpNk++9gSk9do
# 1gSgggPIMIIDxDCCAqygAwIBAgIQRqaG/Zc3Po5BF31FOLqbBTANBgkqhkiG9w0B
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
# nQW5KrIi7MRNM8YKJ+7ddPjJSDANBgkqhkiG9w0BAQEFAASCAQApi9qgEPD+4m42
# AmrIWcLGphPVxqjPV4uF0uQLI+csHHIk6uESt51eZb4d20AvdcW64zrwjJZZpeX/
# RBttqw8aBJAc11PfWCBO7ykJwgBuLLQ58AWgaqX2TiYIPa6DHajVuFpnhAdSpM5n
# DDwqmETAWfALmyVgVByJSh3KnfNzW2HJt7TVjbnQCAxKFAgfzZGRkXlPINOV88fU
# g6QQ4qgxxecwAmpNd842aAUWy4kSMEb/jx1XKb/UPFNbC6rd4nEpSQJYYDjsS/Yy
# K/CZAWt3eKKkz51xTdjBGLZcKqTNQonqkz6UEmGc3qC7ikWwIwGj1RvArHx+fNVZ
# SInIgwWj
# SIG # End signature block
