Clear

$CurrentOSVersion = (
get-itemproperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -Name ProductName
).ProductName

if (Test-Path $OSLocation\CCDC\SelfBuildingDirectory) {
Write-Host "
Folder Test Successful" }
Else {
New-Item -ItemType Directory -Path $OSLocation\CCDC\SelfBuildingDirectory
Write-Host "
Folder Created"
}

if (Test-Path $OSLocation\CCDC\SelfBuildingDirectory\Cache) {
Write-Host "
Folder Test Successful" }
Else {
New-Item -ItemType Directory -Path $OSLocation\CCDC\SelfBuildingDirectory\Cache
Write-Host "
Folder Created"
}

if (Test-Path $OSLocation\CCDC\IncidentReports) {
Write-Host "
Folder Test Successful" }
Else {
New-Item -ItemType Directory -Path $OSLocation\CCDC\IncidentReports
Write-Host "
Folder Created"
}

Get-CimInstance Win32_useraccount | Select-Object Name | Format-Table -HideTableHeaders |`
Out-File $OSLocation\CCDC\SelfBuildingDirectory\Cache\UsersBackUpReference

Clear
While(1) {
Write-Host "
=================================
       User Account Police       
---------------------------------" -ForegroundColor Cyan -BackgroundColor Black
Write-Host "
Checking Against Reference List
--------------------------------"
Get-Content $OSLocation\CCDC\SelfBuildingDirectory\Cache\UsersBackUpReference | Out-Host
get-ciminstance win32_useraccount | Select-Object Name | Format-Table -HideTableHeaders |`
Out-File $OSLocation\CCDC\SelfBuildingDirectory\Cache\UsersbackupScan
Compare-Object -ReferenceObject $(Get-Content $OSLocation\CCDC\SelfBuildingDirectory\Cache\UsersbackupReference)`
-DifferenceObject $(Get-Content $OSLocation\CCDC\SelfBuildingDirectory\Cache\Usersbackupscan) |
Out-file $OSLocation\CCDC\SelfBuildingDirectory\Cache\NewUsers.txt 
$NewUsers1 = get-content -path $OSLocation\CCDC\SelfBuildingDirectory\Cache\NewUsers.txt
if ($NewUsers1 -ne $Null)
{ 
(Get-Content -path $OSLocation\CCDC\SelfBuildingDirectory\Cache\NewUsers.txt).Replace('-','')|Out-File $OSLocation\CCDC\SelfBuildingDirectory\Cache\NewUsers.txt
(Get-Content -path $OSLocation\CCDC\SelfBuildingDirectory\Cache\NewUsers.txt).Replace(' ','')|Out-File $OSLocation\CCDC\SelfBuildingDirectory\Cache\NewUsers.txt
(Get-Content -path $OSLocation\CCDC\SelfBuildingDirectory\Cache\NewUsers.txt).Replace('InputObject','')|Out-File $OSLocation\CCDC\SelfBuildingDirectory\Cache\NewUsers.txt
(Get-Content -path $OSLocation\CCDC\SelfBuildingDirectory\Cache\NewUsers.txt).Replace('=>','')|Out-File $OSLocation\CCDC\SelfBuildingDirectory\Cache\NewUsers.txt
(Get-Content -path $OSLocation\CCDC\SelfBuildingDirectory\Cache\NewUsers.txt).Replace('SideIndicator','')|Out-File $OSLocation\CCDC\SelfBuildingDirectory\Cache\NewUsers.txt
(Get-Content -path $OSLocation\CCDC\SelfBuildingDirectory\Cache\NewUsers.txt).Replace('...','')|Out-File $OSLocation\CCDC\SelfBuildingDirectory\Cache\NewUsers.txt


$NewUsers2 = get-content -path $OSLocation\CCDC\SelfBuildingDirectory\Cache\NewUsers.txt

 $Writeout = "net user $NewUsers2 /delete" 
 $Writeout | Out-File $OSLocation\CCDC\SelfBuildingDirectory\Cache\TargetUser.ps1 
 
 Start-Process -FilePath "powershell" -argument '
  \CCDC\SelfBuildingFile\Cache\TargetUser.ps1 ' -WindowStyle Hidden

$IncidentTime = Get-Date
$CreateIncidentReport = "
=====================================
          INCIDENT REPORT
-------------------------------------

Jackson College CCDC Team

Type of Incident: Unauthorized User Created
Incident occured on: $CurrentOSVersion
Time of Incident: $IncidentTime

Incident Description: An Unauthorized account creation was detected.
                      The user account was $NewUsers2

How the Incident was Resolved: The new unauthorized account $NewUser2 was removed.

 "
 $CreateIncidentReport | Out-File $OSLocation\CCDC\IncidentReports\UnauthorizedUserCreated.txt -Append
 
 $wshell = New-Object -ComObject Wscript.Shell

$wshell.Popup("
A NEW USER HAS BEEN DETECTED AND REMOVED
INCIDENT REPORT CREATED AT $IncidentTime",0,"ALERT!!!",0x1)
 
 }
  Start-Sleep -s 5
  Clear
  } 

