# windows-update.ps1

# Ensure C:\Temp exists
if (-not (Test-Path "C:\Temp")) {
    New-Item -ItemType Directory -Path "C:\Temp" | Out-Null
}

$logPath = "C:\Temp\winupdate-log.txt"

Write-Host "Starting Windows Update check..."
"Starting Windows Update check..." | Out-File $logPath

# Fix NuGet provider issues
Install-PackageProvider -Name NuGet -Force
Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted

Write-Host "Installing PSWindowsUpdate module..."
"Installing PSWindowsUpdate module..." | Out-File $logPath -Append

try {
    Install-Module -Name PSWindowsUpdate -Force -Confirm:$false -ErrorAction Stop
    "PSWindowsUpdate installed successfully." | Out-File $logPath -Append
}
catch {
    "Failed to install PSWindowsUpdate: $_" | Out-File $logPath -Append
    exit 1
}

Import-Module PSWindowsUpdate

Write-Host "Checking for updates..."
"Checking for updates..." | Out-File $logPath -Append

try {
    # GitHub runners cannot install updates, only list them
    Get-WindowsUpdate -IgnoreReboot | Out-File $logPath -Append
}
catch {
    "Error running Get-WindowsUpdate: $_" | Out-File $logPath -Append
    exit 1
}

Write-Host "Completed."
"Completed." | Out-File $logPath -Append


