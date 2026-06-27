param
(
	[Parameter(Mandatory=$true)]
    [string]$source,
    [string]$dest = "Q"
)
Write-Host "#############################################"
$src = Resolve-Path $source
$dst = $dest.Replace(":", "").Replace("\", "")

Write-Host "Src: $src"
Write-Host "Dst: $dst"

Remove-PSDrive 	-Name $dst
New-PSDrive 	-Name $dst -PSProvider FileSystem -Root $src -Scope Global
Write-Host "#############################################"
exit 0