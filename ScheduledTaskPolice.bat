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

Get-ScheduledTask | Select-Object Taskname |`
Out-File $OSLocation\CCDC\SelfBuildingDirectory\Cache\ScheduledTaskReference
 
Clear
While(1) {
Write-Host "
===================================
       ScheduledTasks Police       
-----------------------------------" -ForegroundColor Cyan -BackgroundColor Black
Write-Host "
Checking Against Reference List
--------------------------------
To view reference list open ScheduledTaskReference
in
$OSLocation\CCDC\SelfBuildingFile\Cache\ScheduledTaskReference
"
Get-ScheduledTask | Select-Object Taskname |`
Out-File $OSLocation\CCDC\SelfBuildingDirectory\Cache\ScheduledTaskBackupScan
Compare-Object -ReferenceObject $(Get-Content $OSLocation\CCDC\SelfBuildingDirectory\Cache\ScheduledTaskReference)`
-DifferenceObject $(Get-Content $OSLocation\CCDC\SelfBuildingDirectory\Cache\ScheduledTaskBackupScan) |`
Out-file $OSLocation\CCDC\SelfBuildingDirectory\Cache\NewScheduledTask.txt 
$NewTaskEntry1 = get-content -path $OSLocation\CCDC\SelfBuildingDirectory\Cache\NewScheduledTask.txt
if ($NewTaskEntry1 -ne $Null)
{

$TimeTaskFound = Get-Date
 $PopUpAlert = New-Object -ComObject Wscript.Shell

$PopUpAlert.Popup("
THE CREATION OF A NEW SCHEDULED TASK HAS BEEN
DETECTED AT $TimeTaskFound

Incident report creation and any further action will
NOT be taken automatically. It is recommened 
that you inspect the new task",0,"ALERT!!!",0x1)

Get-ScheduledTask | Select-Object Taskname |`
Out-File $OSLocation\CCDC\SelfBuildingDirectory\Cache\ScheduledTaskReference 
}

  Start-Sleep -s 5
  Clear

}

