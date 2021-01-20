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

Get-NetNeighbor | Select-Object Ipaddress | Format-Table -HideTableHeaders |`
Out-File $OSLocation\CCDC\SelfBuildingDirectory\Cache\ArpBackupReference

Clear
While(1) {
Write-Host "
====================================
         Local Arp Police           
------------------------------------" -ForegroundColor Cyan -BackgroundColor Black
Write-Host "
Checking Against Reference List
--------------------------------
To view reference list open ArpBackupReference
in
$OSLocation\CCDC\SelfBuildingFile\Cache\ArpBackupReference
"
Get-NetNeighbor | Select-Object Ipaddress | Format-Table -HideTableHeaders |`
Out-File $OSLocation\CCDC\SelfBuildingDirectory\Cache\ArpBackupScan
Compare-Object -ReferenceObject $(Get-Content $OSLocation\CCDC\SelfBuildingDirectory\Cache\ArpbackupReference)`
-DifferenceObject $(Get-Content $OSLocation\CCDC\SelfBuildingDirectory\Cache\Arpbackupscan) |
Out-file $OSLocation\CCDC\SelfBuildingDirectory\Cache\NewArpEntry.txt 
$NewArpEntry1 = get-content -path $OSLocation\CCDC\SelfBuildingDirectory\Cache\NewArpEntry.txt
if ($NewArpEntry1 -ne $Null)
{
(Get-Content -path $OSLocation\CCDC\SelfBuildingDirectory\Cache\NewArpEntry.txt).Replace('-','')|Out-File $OSLocation\CCDC\SelfBuildingDirectory\Cache\NewArpEntry.txt
(Get-Content -path $OSLocation\CCDC\SelfBuildingDirectory\Cache\NewArpEntry.txt).Replace(' ','')|Out-File $OSLocation\CCDC\SelfBuildingDirectory\Cache\NewArpEntry.txt
(Get-Content -path $OSLocation\CCDC\SelfBuildingDirectory\Cache\NewArpEntry.txt).Replace('InputObject','')|Out-File $OSLocation\CCDC\SelfBuildingDirectory\Cache\NewArpEntry.txt
(Get-Content -path $OSLocation\CCDC\SelfBuildingDirectory\Cache\NewArpEntry.txt).Replace('=>','')|Out-File $OSLocation\CCDC\SelfBuildingDirectory\Cache\NewArpEntry.txt
(Get-Content -path $OSLocation\CCDC\SelfBuildingDirectory\Cache\NewArpEntry.txt).Replace('SideIndicator','')|Out-File $OSLocation\CCDC\SelfBuildingDirectory\Cache\NewArpEntry.txt
(Get-Content -path $OSLocation\CCDC\SelfBuildingDirectory\Cache\NewArpEntry.txt).Replace('...','')|Out-File $OSLocation\CCDC\SelfBuildingDirectory\Cache\NewArpEntry.txt

$NewArpEntry2 = Get-Content -path $OSLocation\CCDC\SelfBuildingDirectory\Cache\NewArpEntry.txt

 $Writeout2 = "Arp -d $NewArpEntry2"
 $Writeout2 | Out-File $OSLocation\CCDC\SelfBuildingDirectory\Cache\TargetArp.ps1


 Start-Process -FilePath "powershell" -argument '
  \CCDC\SelfBuildingFile\Cache\TargetArp.ps1 ' -WindowStyle Hidden

$IncidentTime2 = Get-Date
$CreateIncidentReport2 = "
=====================================
          INCIDENT REPORT
-------------------------------------

Jackson College CCDC Team

Type of Incident: New Arp Entry Detected
Incident occured on: $CurrentOSVersion
Time of Incident: $IncidentTime2

Incident Description: A new arp entry was detected.
                      The arp address was $NewArpEntry2

How the Incident was Resolved: The new arp entry $NewArpEntry2 was removed.

 "
 $CreateIncidentReport2 | Out-File $OSLocation\CCDC\IncidentReports\UnauthorizedArpCreated.txt -Append
 
 $PopUpAlert = New-Object -ComObject Wscript.Shell

$PopUpAlert.Popup("
A NEW ARP ENTRY HAS BEEN DETECTED AND REMOVED
INCIDENT REPORT CREATED AT $IncidentTime2",0,"ALERT!!!",0x1)
 
}

  Start-Sleep -s 5
  Clear

}
