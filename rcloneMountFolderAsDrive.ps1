param (
    [string]$MountPoint = "",
    [string]$DriveLetter = "",
    [string]$DriveName = ""
)

Write-Host $MountPoint.GetType()

if($MountPoint -eq "") {
    $MountPoint = Read-Host "Enter the mount point (e.g. C:\XYZ\Folder)"
}
if($DriveLetter -eq "") {
    $DriveLetter = Read-Host "Enter the drive letter (e.g. A, B, C, etc.)"
}
if($DriveName -eq "") {
    $DriveName = Read-Host "Enter the drive name (e.g. Rclone Drive)"
}

rclone mount $MountPoint ${DriveLetter}: --volname $DriveName --network-mode --links --no-console