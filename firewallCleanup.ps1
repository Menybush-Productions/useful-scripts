param(
	[switch]$manual = $false
)

function List-FWRules {
	Write-Output "Invalid Firewall Rules:"
	Get-NetFirewallApplicationFilter | ForEach-Object {
		$program = $_.Program
		if ([System.IO.Path]::IsPathRooted($program)) {
			if (!(Test-Path -Path "$program" -PathType Leaf)) {
				Write-Output "$program"
			}
		}
	}
}
function Clear-FWRules {
	Write-Output "Removing Invalid Firewall Rules:"
	Get-NetFirewallApplicationFilter | ForEach-Object {
		$program = $_.Program
		if ([System.IO.Path]::IsPathRooted($program)) {
			if (!(Test-Path -Path "$program" -PathType Leaf)) {
				Write-Output "Removed: $program"
				$_ | Remove-NetFirewallRule
			}
		}
	}
}

Write-Host "#############################################"
List-FWRules

$confirm = Read-Host "Do your really want to remove these invalid rules? [y/n]"
if($confirm -eq "y") { Clear-FWRules }

Write-Host "Script completed successfully!" -ForegroundColor Green
Write-Host "#############################################"
