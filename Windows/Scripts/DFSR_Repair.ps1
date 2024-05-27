#Requires -RunAsAdministrator -Modules ActiveDirectory

Write-Host "`nStopping DFSR Service"
if((Get-Service -Name DFSR).Status -eq 'Running'){
	Stop-Service -Name DFSR
}

Write-Host "`nModifying properties"
$DName = (Get-ADComputer -Identity $Env:COMPUTERNAME).DistinguishedName
$ADObject = "CN=SYSVOL Subscription,CN=Domain System Volume,CN=DFSR-LocalSettings,$DName"
$Properties = Get-ADObject -Identity $ADObject -Properties msDFSR-Enabled,msDFSR-options
if($Properties.'msDFSR-Enabled'){
	Set-ADObject -Identity $ADObject -Replace @{'msDFSR-Enabled'=$false}
}
if(!$Properties.'msDFSR-options'){
	Set-ADObject -Identity $ADObject -Replace @{'msDFSR-options'=1}
}

Write-Host "`nStarting DFSR Service"
Start-Service -Name DFSR
Set-ADObject -Identity $ADObject -Replace @{'msDFSR-Enabled'=$true}

Write-Host "`nForcing sync"
repadmin /syncall /Adp

Start-Sleep -Seconds 2 # Waiting for the prior sync to properly finish.
Write-Host "`nManual sync check"
if((Get-WindowsFeature -Name 'RSAT-DFS-Mgmt-Con').InstallState -ne 'Installed'){
	Install-WindowsFeature -Name 'RSAT-DFS-Mgmt-Con'
}
DFSRDIAG POLLAD
