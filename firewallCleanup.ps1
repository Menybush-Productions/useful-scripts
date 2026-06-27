param(
    [switch]$y = $false
)

Write-Output "Mode: $y"
Write-Output "Invalid Firewall Rules:"
Get-NetFirewallApplicationFilter | ForEach-Object {
    $program = $_.Program
    if ([System.IO.Path]::IsPathRooted($program)) {
        if (!(Test-Path -Path "$program" -PathType Leaf)) {
            Write-Output "$program"
            if ($y) {
                $_ | Remove-NetFirewallRule
            }
        }
    }
}
Write-Output "Note: if you wish to remove these invalid rules, run the script again with -y "