function Get-Certificate {
  return Get-ChildItem Cert:\CurrentUser\My -CodeSigningCert | Where-Object { $_.Thumbprint -Match '0BC70FF6EFB07FD9AE2F6EC7F87F99174EF9C93D' }
}
function Invoke-ReadKey {
	param (
		[Parameter(Mandatory = $false)] [string]$message = "Press a key to continue..."
	)
	Write-Host $message -ForegroundColor Cyan
	$null = [System.Console]::ReadKey($true)
	Clear-Host
}

Write-Host 'Signing all PowerShell scripts in the current directory recursively...' -ForegroundColor Cyan
Write-Host '############################'

Get-ChildItem -Path $PSScriptRoot -Filter *.ps1 -Recurse | ForEach-Object {
  $cert = Get-Certificate
  if (!$cert) {
    Invoke-ReadKey -message "No code signing certificate found. Press any key to exit..."
    return
  }
  $status = Set-AuthenticodeSignature -FilePath $_.FullName -Certificate $cert
  if ($status.Status -eq 'Valid') {
    Write-Host "Success: $($_.FullName)" -ForegroundColor Green
  }
  else {
    Write-Host "Error: $($_.FullName)" -ForegroundColor Red
  }
}

Write-Host '############################'
Invoke-ReadKey -message "Press any key to exit..."
# SIG # Begin signature block
# MIIGMgYJKoZIhvcNAQcCoIIGIzCCBh8CAQExCzAJBgUrDgMCGgUAMGkGCisGAQQB
# gjcCAQSgWzBZMDQGCisGAQQBgjcCAR4wJgIDAQAABBAfzDtgWUsITrck0sYpfvNR
# AgEAAgEAAgEAAgEAAgEAMCEwCQYFKw4DAhoFAAQUrz4t6C7zVeZpDGvcHlWPe+Ik
# Ys6gggPIMIIDxDCCAqygAwIBAgIQRqaG/Zc3Po5BF31FOLqbBTANBgkqhkiG9w0B
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
# MBwGCisGAQQBgjcCAQsxDjAMBgorBgEEAYI3AgEVMCMGCSqGSIb3DQEJBDEWBBSc
# NNsIymTbSTHnu5TSr+V4R6zz/DANBgkqhkiG9w0BAQEFAASCAQCIa3jAoFucJ+Qz
# n8tiLBsimbYO8lFr9oiR3B3K97/t/MHGemPJd4vrFTZdk7pZzE+HOgOZlSdVvSvd
# Iah8a8THKqchhicRMMeBwkI5d1ESQDd59MYQMevVmVDl65Cn/orXubJkyEPuigGF
# yes/brr0AG/OJB/Z6St/Y7zsSDKXn1wsR8UlGgO4HTnq1LDYN4DkZn7C2sH2ioI5
# gG8EwrBH11F1oj6ZCoTNQaXJU1xWXNQlFRY6rm8/NJN0TyANCw0MV38NgTNOOXf8
# gzb8y1wT6Sz17DhGHY/KS5do8zK3gaT/W3/Dmhz9X9rXkinDV2svgz6hrzvLx+D+
# f4XmMY9F
# SIG # End signature block
