# Stand-Alone DC DFS Replication Error (Event ID 4012)

> [Source](https://www.mcbsys.com/blog/2018/12/dfsr-error-4012-on-stand-alone-domain-controller/)

1. Run CMD as admin
2. Run `net stop DFSR`
3. Open ADSIEDIT and navigate to: "You domain"\Domain Controllers\"Your DC"\DFSR-LocalSettings\Domain System Volume
4. Open SYSVOL Subscriptions properties and edit the following:

   msDFSR-Enabled=FALSE  
   msDFSR-options=1  
5. Run `net start DFSR`
6. Rerturn to the same location as in Stop 4 and edit the following:

   msDFSR-Enabled=TRUE  
7. Run `repadmin /syncall /Adp`
8. Run `DFSRDIAG POLLAD`

## 'DFSRDIAG' not recognised

> [source](https://www.alitajran.com/dfsrdiag-pollad-is-not-recognized/)

### Server Manager

Add server feature:
`Remote Server Administration Tools > Role Administrations Tools > File Services Tools > DFS Management Tools`

### PowerShell

> :warning: Run as admin

```ps
Install-WindowsFeature -Name 'RSAT-DFS-Mgmt-Con'
```

## One-Liner(*)

> :information_source: The full script can be found [here](./Scripts/DFSR_Repair.ps1)

```ps 
Stop-Service -Name DFSR; $ADObject = "CN=SYSVOL Subscription,CN=Domain System Volume,CN=DFSR-LocalSettings,$((Get-ADComputer -Identity $Env:COMPUTERNAME).DistinguishedName)"; Set-ADObject -Identity $ADObject -Replace @{'msDFSR-Enabled'=$false}; Set-ADObject -Identity $ADObject -Replace @{'msDFSR-options'=1}; Start-Sleep -Seconds 2; Start-Service -Name DFSR; Set-ADObject -Identity $ADObject -Replace @{'msDFSR-Enabled'=$true}; repadmin /syncall /Adp; $f = 'RSAT-DFS-Mgmt-Con'; if((Get-WindowsFeature -Name $f).InstallState -ne 'Installed'){Install-WindowsFeature -Name $f}; Start-Sleep -Seconds 2; DFSRDIAG POLLAD
```
