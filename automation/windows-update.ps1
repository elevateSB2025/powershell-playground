# windows-update.ps1 

Write Host "Installing Windows Update module..."
Install-Module -Name PSWindowsUpdate -Force -Confirm:$true

Import-Module PSWindowsUpdate 

Write-Host "Checking for updates..."
$updates = Get-WindowsUpdate 

Write-Host "Found Updates..."
$updates | Format-Table | Out-String | Write-Host 

Write-Host "Installing upates..."
Get-WindowsUpdate -AcceptAll -Install -AutoReboot:$false -Out-File -FilePath C:\Temp\winupdate-log.txt

Write-Host "Update process complete. See winupdate-log.txt for details"
