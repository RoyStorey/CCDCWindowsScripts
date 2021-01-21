#set-executionpolicy remotesigned
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

<#
This section will try to find the location of the Operating System.
If it cannot find the OS it will prompt you for the location.
It will then verify that Windows is within the location
#>
$VNum = "21"
$VNumDate = "Unreleased"
Clear
$DriveCheckC = Test-Path C:
if ($DriveCheckC -eq $true) {$OSLocation = "C:"; Write-Host "OS Found on C: Drive" -ForegroundColor Green -BackgroundColor Black}
elseif ($DriveCheckC -eq $false) {$DriveCheckD = Test-Path D:}
if ($DriveCheckC -eq $False -and $DriveCheckD -eq $True) {$OSLocation = "D:"; Write-Host "OS Found on D: Drive" -ForegroundColor Green -BackgroundColor Black}
elseif ($DriveCheckD -eq $false -and $DriveCheckC -eq $false) {Write-Host "
Was unable to locate the drive where Windows is located.
Please tell me the Windows install location in the form of
DriveLetter followed by a Colon" -ForegroundColor Cyan -BackgroundColor Black; $Input1 = Read-Host " "
$DriveCheckInput = Test-Path $Input1
If ($DriveCheckInput -eq $true) {$OSLocation = $Input1; Write-Host "OS Found on $Input1" -ForegroundColor Green -BackgroundColor Black}
elseif ($DriveCheckD -eq $false -and $DriveCheckC -eq $false -and $DriveCheckInput -eq $false) {Write-Host "
Input was unable to be verified!
Please double check your OS Location." -ForegroundColor Cyan -BackgroundColor Black
}}

Clear
if (Test-Path $OSLocation\CCDC) {
Write-Host "
CCDC Folder Found" -ForegroundColor Green -BackgroundColor Black}
ElseIf (-NOT (Test-Path $OSLocation\CCDC)) {
New-Item -ItemType Directory -Path $OSLocation\CCDC
 }

if (Test-Path $OSLocation\CCDC\WindowsIntelligentSecuritySuiteVersion$VNum.ps1) {
Write-Host "
Security Suite Found" -ForegroundColor Green -BackgroundColor Black }
ElseIF (-NOT (Test-Path $OSLocation\CCDC\WindowsIntelligentSecuritySuiteVersion$VNum.ps1))
{
Write-Host "
The Security Suite needs to be coppied into the $OSLocation\CCDC directory

    [C] Continue
    [Q] Quit" -ForegroundColor Cyan -BackgroundColor Black
$SuiteWrong  = Read-Host " "
If ($SuiteWrong -eq 'Q') {Break}
}

If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
 {
 Clear    
 Write-Host "
 Windows Intelligent Security Suite" -ForegroundColor Cyan -BackgroundColor Black
  Write-Host "
  The Windows Intelligent Security Suite MUST be ran as Administrator!
  If you continue many parts of the Security Suite will not run properly" -ForegroundColor Red -Background Black
  Write-Host "
    [C] Continue
    [Q] Quit" -ForegroundColor Cyan -BackgroundColor Black
  $NoAdminAlert = Read-Host " "
  if ($NoAdminAlert -eq 'Q') {Clear;Break}
 }

<#
This will allow you to update your version of powershell
#>
Clear
do {
Write-Host "
=================================
   Powershell Update assistant   
---------------------------------
Would you like to update Powershell Version" $PSVersionTable.PSVersion | Format-Table Major -HideTableHeaders | out-host
Write-Host "
    [1] Update for Windows 7 x64
    [2] Update for Windows 7 x86
    [3] Update for Windows 2008 x64
    [S] Skip" 
$PSUpdateInput = Read-Host " "
if ($PSUpdateInput -eq '1') {
wusa $OSLocation\CCDC\PowershellUpdates\Windows6.1-kb2819745-x64-MultiPkg.msu
}
Elseif ($PSUpdateInput -eq '2') {
wusa $OSLocation\CCDC\PowershellUpdates\Windows6.1-kb2819745-x86-MultiPkg.msu
}
Elseif ($PSUpdateInput -eq '3') {
wusa $OSLocation\CCDC\PowershellUpdates\Windows8-rt-kb2799888-x64.msu.msu
}
} Until ($PSUpdateInput -eq 'S')
Clear

<#
This will detect the Windows Operating System Version 
#>
$CurrentOSVersion = (
get-itemproperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -Name ProductName
).ProductName

Write-Host "
Optimized for Detected $CurrentOSVersion" -ForegroundColor Green -BackgroundColor Black

<#
This checks to see if a CCDC folder is located off the root.
If it does not it creastes it for you.
#>
$CCDCTest = Test-Path $OSLocation\CCDC 
If($CCDCTest -eq $false) {New-Item -Path $OSLocation\ -name "CCDC" -type "directory"; Write-Host "
A CCDC Folder Has Been Created For You" -ForegroundColor Cyan -BackgroundColor Black}

$CommandLog = Get-Date
Get-History | Out-file $OSLocation\CCDC\CommandHistory.txt -Append
Add-Content $OSLocation\CCDC\CommandHistory.txt "Backup Created at $CommandLog"

<#
This is the Beginning of the Menu System
#>
do {
Write-Host "
TheArch0n's Windows Intelligent Security Suite Version: $VNum" -ForegroundColor Green -BackgroundColor Black
Write-host "
####################################################################
                                                                    
      ooo        ooooo   .oooooo.   oooooooooo.   oooooooooooo      
       88.       .888   d8P    Y8b   888     Y8b   888       8      
       888b     d'888  888      888  888      888  888              
       8 Y88. .P  888  888      888  888      888  888oooo8         
       8   888    888  888      888  888      888  888              
       8    Y     888   88b    d88   888     d88   888       o      
      o8o        o888o   Y8bood8P   o888bood8P    o888ooooood8      
                                                                    
####################################################################

Would you like to run in Manual mode or Independent mode?" -ForegroundColor Cyan -BackgroundColor Black
Write-host "
--------------------------------------------------------------------
|   [M] Manual                                                     |
|                                                                  |
|   [I] Independent    (Not Yet Enabled)                           |
|                                                                  |
|   [F] Full Control   (Not Yet Enabled)                           |
|                                                                  |
|   [EXIT]                                                         |
--------------------------------------------------------------------" -ForegroundColor Cyan -BackgroundColor Black

$readhost1 = Read-Host " "
Switch ($readhost1)
{
<#
This Section is for Manual Mode
#>
M {
do {
Clear-History
Clear
if ($NoAdminAlert -eq 'C') { Write-Host "
NOT RUNNING AS ADMINISTRATOR SOME FEATURES ARE DISABLED" -ForegroundColor Red -BackgroundColor Black}
Write-Host "
Manual Mode with Powershell Version" -ForegroundColor Green -BackgroundColor Black $PSVersionTable.PSVersion | Format-Table Major -HideTableHeaders | out-host 
Write-Host "
TheArch0n's Windows Intelligent Security Suite Version: $VNum" -ForegroundColor Green -BackgroundColor Black
Write-Host "
####################################################################
                                                                    
     ooo        ooooo oooooooooooo ooooo      ooo ooooo     ooo     
      88.       .888   888       8  888b.      8   888       8      
      888b     d'888   888          8  88b.    8   888       8      
      8 Y88. .P  888   888oooo8     8    88b.  8   888       8      
      8   888    888   888          8      88b.8   888       8      
      8    Y     888   888       o  8        888    88.    .8       
     o8o        o888o o888ooooood8 o8o         8      YbodP         
                                                                    
####################################################################" -ForegroundColor Cyan -BackgroundColor Black
Write-Host "
--------------------------------------------------------------------
| Please Select an Option                                          |
|    [1] Local Computer Users Tool                                 |
|    [2] Scheduled Task Tool                                       |
|    [3] Detailed System Information                               |
|    [4] Log Files Filtering Tool                                  |
|    [5] Network Monitoring Tool                                   |
|    [6] Scan For EternalBlue Vulnerability                        |
|    [7] Users Monitoring Tool                                     |
|    [8] Firewall Tool                                             |
|    [9] Port Scanning Tool                  (Not Enabled)         |
|    [10] Process Control Tool                                     |
|    [11] Arp Tool                                                 |
|    [12] Incident Report Generator                                |
|                                                                  |
|    [F] Full Control Tools                                        |
|                                                                  |
|    [H] Help                                                      |
|    [P] Patch Notes and Version Information                       |
|    [D] Delete Script Data                                        |
|    [A] Advanced                                                  |
|    [Q] Quit to Previous Menu                                     |
--------------------------------------------------------------------" -ForegroundColor Cyan -BackgroundColor Black
$readhost2 = Read-Host " "
Switch ($readhost2)
{
1 {
do {
clear
Write-Host "
===================================
     Local Computer Users Tool     
-----------------------------------
What would you like to do?
    [1] Show Current Local Users List
    [2] Show Enabled/Disabled User Accounts 
    [3] BackUp Current Users List
    [4] Add or Remove Users Accounts
    [5] Enable/Disable Users Accounts
    [6] Groups Management
    [7] Account Policy Settings
    [8] Domain Controller Account Policy Settings (Not Enabled)
    [Q] Quit to Main Menu" -ForegroundColor Cyan -BackgroundColor Black
$UserOptions = Read-Host " "
Switch ($UserOptions)
{
<#
Local Computer Users Tool
#>

1 { do { 
Clear
Write-Host "
===================================
     Local Computer Users Tool     
-----------------------------------
" -ForegroundColor Cyan -BackgroundColor Black
get-ciminstance win32_useraccount | Format-List | Out-Host
Write-Host "
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
$LocalUsersExit = Read-Host " "
Clear-History} Until ($LocalUsersExit -eq 'Q')}

2 {
Clear
Write-Host "
===================================
     Local Computer Users Tool     
-----------------------------------
" -ForegroundColor Cyan -BackgroundColor Black
Get-WmiObject -Class Win32_UserAccount -Filter "LocalAccount='$true'" | Select-Object Name,
Disabled | Format-Table -AutoSize
Write-Host "
    [Q] Quit to Users Menu" -ForegroundColor Cyan -BackgroundColor Black
$ShowEnaDisQuit = Read-Host " "
if ($ShowEnaDisQuit -eq 'Q') {Clear-History;Break}
}
3 { do 
{ 
Clear
$UsersTest = Test-Path $OSLocation\CCDC\Users.txt
if ($UsersTest -eq $false) {New-Item -path $OSLocation\CCDC\ -name Users.txt -type "file" ; Write-Host "
Users Output File Created" -ForegroundColor Cyan -BackgroundColor Black}
elseif ($UsersTest -eq $true) {Write-Host "
Users Output file found" -ForegroundColor Cyan -BackgroundColor Black}
get-ciminstance win32_useraccount | Format-List | Out-File $OSLocation\CCDC\Users.txt -Append; Write-Host "
===================================
     Local Computer Users Tool     
-----------------------------------
Current Users list backed up to
$OSLocation/CCDC/Users.txt" -ForegroundColor Cyan -BackgroundColor Black
$TimeStamp1 = Get-Date
Add-Content $OSLocation\CCDC\Users.txt "Backup Created at $TimeStamp1"
Write-Host "
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
$UserOutputQuit = Read-Host " "
} Until ($UserOutputQuit -eq 'Q')}
<#
This is used for removing a User.
#>

4 { do {
Clear
<#if ($CurrentOSVersion -eq 'Windows Server 2012 R2 Datacenter' -or 'Windows Server 2008 R2 SP1') {Write-Host "
The Add or Remove Users Feature of
Windows Intelligent Security Suite Version $VNum
is not YET optimized for your system ($CurrentOSVersion) and is therefore disabled.
Please check newer editions of the Windows Intelligent Security Suite
for support of your Version of Windows." -ForegroundColor Red -BackgroundColor Black
Write-Host "
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
Read-Host " "
Break}
#>
Write-Host "
===================================
     Local Computer Users Tool     
-----------------------------------
How would you like to manage the User Accounts?
    [1] Create New User
    [2] Delete An Existing User
    [Q] Quit To Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
$DeleteUserYN = Read-Host " "
Switch ($DeleteUserYN)
{
1 { 
Clear
Write-Host "
===================================
     Local Computer Users Tool     
-----------------------------------
What is the Name of the New User?

    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
$CreateUser = Read-Host " "
if ($CreateUser -eq 'Q') {Clear-History;Break}

Net User $CreateUser * /add
Clear
Write-Host "
===================================
     Local Computer Users Tool     
-----------------------------------" -ForegroundColor Cyan -BackgroundColor Black
Write-Host "
User $CreateUser has been created"
Write-Host "
    [Q] Quit to Users Menu" -ForegroundColor Cyan -BackgroundColor Black
$NewUserCreated = Read-Host " "
}
2 { 
Clear
Write-Host "
===================================
     Local Computer Users Tool     
-----------------------------------" -ForegroundColor Cyan -BackgroundColor Black

Get-ciminstance win32_useraccount | Format-List Name, Domain, Caption | Out-Host
Write-Host "
What User you would like to Delete?

    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
$DeleteUser = Read-Host " "
if ($DeleteUser -eq 'Q') {Clear-History;Break}
Net User $DeleteUser /delete 
Clear
Write-Host "
===================================
     Local Computer Users Tool     
-----------------------------------
$DeleteUser has been removed

    [Q] Quit to Users Menu" -ForegroundColor Cyan -BackgroundColor Black
    $UserDeleted = Read-Host " "
    if ($UserDeleted -eq 'Q') {Clear-History;Break}
}
}} Until ($DeleteUserYN -eq 'Q' -or $NewUserCreated -eq 'Q')
}
5 {
Clear
Write-Host "
===================================
     Local Computer Users Tool     
-----------------------------------
Would you like to Enable or Disable and Account?
    [1] Enable an Account
    [2] Disable an Account
    [Q] Quit to Users Menu" -ForegroundColor Cyan -BackgroundColor Black
$EnableorDisable = Read-Host " "
if ($EnableorDisable -eq 'Q') {Clear-History;Break}
Switch ($EnableorDisable)
{
1 {
Clear
Write-Host "
===================================
     Local Computer Users Tool     
-----------------------------------
What Account would you like to Enable?" -ForegroundColor Cyan -BackgroundColor Black
get-ciminstance win32_useraccount | Format-List Name, Domain, Caption | Out-Host
Write-Host "
    [Q] Quit to Users Menu" -ForegroundColor Cyan -BackgroundColor Black
$AccountEnable = Read-Host " "
if ($AccountEnable -eq 'Q') {Break}
Net User $AccountEnable /Active:Yes
Clear
Write-Host "
===================================
     Local Computer Users Tool     
-----------------------------------
$AccountEnable has been Enabled

    [Q] Quit to Users Menu" -ForegroundColor Cyan -BackgroundColor Black
$EnableDone = Read-Host " "
if ($EnableDone -eq 'Q') {Clear-History;Break}
}
2 {
Clear
Write-Host "
===================================
     Local Computer Users Tool     
-----------------------------------" -ForegroundColor Cyan -BackgroundColor Black
get-ciminstance win32_useraccount | Format-List Name, Domain, Caption | Out-Host
Write-Host "
What Account would you like to Disable?

    [Q] Quit to Users Menu" -ForegroundColor Cyan -BackgroundColor Black
$AccountDisable = Read-Host " "
if ($AccountDisable -eq 'Q') {Break}
Net User $AccountDisable /Active:No
Clear
Write-Host "
===================================
     Local Computer Users Tool     
-----------------------------------
$AccountDisable has been Disabled

    [Q] Quit to Users Menu" -ForegroundColor Cyan -BackgroundColor Black
$DisableDone = Read-Host " "
if ($DisableDone -eq 'Q') {Clear-History;Break}
}

}
}

6 {
do {
Clear
Write-Host "
===================================
     Local Groups Management       
-----------------------------------
How would you like to Manage Groups?

    [1] Show Local Groups
    [2] Show Local Administrators Group
    [3] Add User to Administrators Group
    [4] Remove User From Administrators Group
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
$GroupMenu = Read-Host " "
Switch ($GroupMenu) {
1 {
Clear
Write-Host "
===================================
     Local Groups Management       
-----------------------------------" -ForegroundColor Cyan -BackgroundColor Black
net localgroup
Write-Host "
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
$ShowGroupQ = Read-Host " "
}
2 {
Clear
Write-Host "
===================================
     Local Groups Management       
-----------------------------------" -ForegroundColor Cyan -BackgroundColor Black
net localgroup Administrators | Format-Table
Write-Host "
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
$ShowAdminQ = Read-Host " "
}
3 {
Clear
Write-Host "
===================================
     Local Groups Management       
-----------------------------------
What User would you like to add to Administrators group?" -ForegroundColor Cyan -BackgroundColor Black
Get-WmiObject -Class Win32_UserAccount -Filter "LocalAccount='$true'" | Select-Object Name | Format-Table -AutoSize
Write-Host "
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
$UserAddAdmin = Read-Host " "
if ($UserAddAdmin -eq 'Q') {Break}
net localgroup Administrators "$UserAddAdmin" /Add
}
4 {
Clear
Write-Host "
===================================
     Local Groups Management       
-----------------------------------
What User would you like to remove
from the Administrators group?" -ForegroundColor Cyan -BackgroundColor Black
net localgroup Administrators
Write-Host "
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
$UserRemoveAdmin = Read-Host " "
if ($UserRemoveAdmin -eq 'Q') {Break}
net localgroup Administrators "$UserRemoveAdmin" /Delete
}
}
} Until ($GroupMenu -eq 'Q')
}

7 { do { 
Clear
Write-Host "
===================================
      Account Policy Settings      
-----------------------------------

    [1] Show Account Policy Settings
    [2] Change Minimum Password Length
    [3] Change Length of Password History
    [4] Change Maximun Password Age
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
$AccountPolicy = Read-Host " "
Switch ($AccountPolicy) {
1 {
Clear
Write-Host "
===================================
      Account Policy Settings      
-----------------------------------" -ForegroundColor Cyan -BackgroundColor Black
Net Accounts
Write-Host "
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
$ShowAccountQuit = Read-Host " "
if ($ShowAccountQuit -eq 'Q') {Break}
}
2 {
Clear
Write-Host "
===================================
      Account Policy Settings      
-----------------------------------
What would you like the minimum password 
length to be? (0-14)

    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
$PSLength = Read-Host " "
if ($PSLength -eq 'Q') {Break}
Net Accounts /MINPWLEN:$PSLength

}
3 { 
Clear
Write-Host "
===================================
      Account Policy Settings      
-----------------------------------
What would you like the new Password
History to be? 0-24

    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
$PasswordHistory = Read-Host " "
if ($PasswordHistory -eq 'Q') {Break}
Net Accounts /UNIQUEPW:$PasswordHistory

}
4 {
Clear
Write-Host "
===================================
      Account Policy Settings      
-----------------------------------
How long before a User Must change a Password?
(1-999 days or UNLIMITED)

    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
$PasswordAge = Read-Host " "
if ($PasswordAge -eq 'Q') {Break}
Net Accounts /MAXPWAGE:$PasswordAge 

}
} 
} Until ($AccountPolicy -eq 'Q')
}

8 {
Clear 
Write-Host "
=============================================
  Domain Controller Account Policy Settings  
---------------------------------------------" -ForegroundColor Cyan -BackgroundColor Black

}
}
}
 Until ($UserOptions -eq 'Q')
}
<#
Scheduled Task Tool
#>
2 { do {
Clear
Write-Host "
========================================
          Scheduled Task Tool           
----------------------------------------
    [1] View Scheduled Tasks
    [2] View Scheduled Tasks Filtered (Not Enabled)
    [3] View Non-Disabled, Non-System Created Tasks
    [4] Disable a Scheduled Task
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
$TaskMenu = Read-Host " "
Switch ($TaskMenu)
{
1 { do {
Clear
Write-Host "
========================================
          Scheduled Task Tool           
----------------------------------------
How would you like Tasks displayed?
    [1] Terminal Display
    [2] Export to GridView
    [3] Save Task List to Text Document
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
$ViewTaskQuit = Read-Host " "
Switch ($ViewTaskQuit)
{
1 { do {
clear
Write-Host "
========================================
          Scheduled Task Tool           
----------------------------------------" -ForegroundColor Cyan -BackgroundColor Black
Get-ScheduledTask | Out-Host 
Write-Host "
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
    $TerminalDisplayQuit = Read-Host " "} Until ($TerminalDisplayQuit -eq 'Q')}
2 { do {
clear
Write-Host "
========================================
          Scheduled Task Tool           
----------------------------------------" -ForegroundColor Cyan -BackgroundColor Black
"Loading Please Wait"
Get-ScheduledTask | Out-GridView 
Clear
Write-Host "
========================================
          Scheduled Task Tool           
----------------------------------------

    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
    $TaskGridQuit = Read-Host " "} Until ($TaskGridQuit -eq 'Q')}
3 { do {
clear
Write-Host "
========================================
          Scheduled Task Tool           
----------------------------------------" -ForegroundColor Cyan -BackgroundColor Black
"Please Wait"
Get-ScheduledTask | Format-List | Out-file $OSLocation\CCDC\ScheduledTaskList.txt -Append
$TimeStamp2 = Get-Date
Add-Content $OSLocation\CCDC\ScheduledTaskList.txt "Backup Created at $TimeStamp2"
Clear
Write-Host "
========================================
          Scheduled Task Tool           
----------------------------------------
A Backup has been created at /CCDC/ScheduledTaskList.txt

    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
    $TaskBackUpQuit = Read-Host " "} Until ($TaskBackUpQuit -eq 'Q')}
}} Until ($ViewTaskQuit -eq 'Q') 
}
<#
2 {
clear
Write-Host "
========================================
          Scheduled Task Tool           
----------------------------------------" -ForegroundColor Cyan -BackgroundColor Black
Get-ScheduledTask -TaskName -ne "xblgamesavetask"| Out-Host 
Write-Host "
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
}
#>

3 {
do {
Clear
Write-Host "
========================================
          Scheduled Task Tool           
----------------------------------------
How would you like Tasks displayed?
    [1] Terminal Display
    [2] Export to GridView
    [3] Save Task List to Text Document
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
$TaskTool3Menu = Read-Host " "
Switch ($TaskTool3Menu) {
1 {
Clear
Write-Host "
========================================
          Scheduled Task Tool           
----------------------------------------" -ForegroundColor Cyan -BackgroundColor Black
Get-ScheduledTask | Where-Object Author -ne "Microsoft Corporation" |`
Where-Object Author -ne "Microsoft" |`
Where-Object Author -ne "Microsoft Corporation." |`
Where-Object State -ne "Disabled" 
Write-Host "
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
$TaskTool3 = Read-Host " "
if ($TaskTool3 -eq 'Q') {Break} 
}
2 {
Clear
Write-Host "
========================================
          Scheduled Task Tool           
----------------------------------------" -ForegroundColor Cyan -BackgroundColor Black
Get-ScheduledTask | Where-Object Author -ne "Microsoft Corporation" |`
Where-Object Author -ne "Microsoft" |`
Where-Object Author -ne "Microsoft Corporation." |`
Where-Object State -ne "Disabled" | Out-GridView 
Write-Host "
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
$TaskToolGrid3 = Read-Host " "
if ($TaskToolGrid3 -eq 'Q') {Break} 
}
3 {
Clear
Write-Host "
========================================
          Scheduled Task Tool           
----------------------------------------" -ForegroundColor Cyan -BackgroundColor Black
"Please Wait" 
Get-ScheduledTask | Where-Object Author -ne "Microsoft Corporation" |`
Where-Object Author -ne "Microsoft" |`
Where-Object Author -ne "Microsoft Corporation." |`
Where-Object State -ne "Disabled" | Out-file $OSLocation\CCDC\ScheduledTaskList.txt -Append
$3TimeStamp = Get-Date
Add-Content $OSLocation\CCDC\ScheduledTaskList.txt "Backup Created at $3TimeStamp"
Clear
Write-Host "
========================================
          Scheduled Task Tool           
----------------------------------------
A Backup has been created at /CCDC/ScheduledTaskList.txt

    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
$Task3Backup = Read-Host " "
if ($Task3Backup -eq 'Q') {Break}
}
}

} Until ($TaskTool3Menu -eq 'Q')
}
4 { do {
Clear
Write-Host "
========================================
          Scheduled Task Tool           
----------------------------------------
What is the name of the task you would like to disable?
    
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
$TaskName = Read-Host " "
Get-ScheduledTask $TaskName | Disable-ScheduledTask -Confirm
Write-Host "
$TaskName has been Disabled" -ForegroundColor Cyan -BackgroundColor Black } Until ($TaskName -eq 'Q') }
} } Until ($TaskMenu -eq 'Q')}
<#
System Information Tool
#>
3 {
do {
clear
Write-Host "
=========================================
         YOUR SYSTEM INFORMATION         
-----------------------------------------" -ForegroundColor Cyan -BackgroundColor Black;
$SysInfo = Get-CimInstance Win32_OperatingSystem | Select-Object Caption, LocalDateTime, ServicePackMajorVersion,
ServicePackMinorVersion, CSName, OSArchitecture, SystemDirectory, NumberOfUsers, Version | FL * 
$SysInfo
Write-Host "
Would you like this information backed up in a text file?

    [Y] Yes
    [N] No
    [Q] Quiet to Main Menu" -ForegroundColor Cyan -BackgroundColor Black
$InfoBackUpInput = Read-Host " "
Switch ($InfoBackUpInput)
{
Y {$SysInfo | Out-File $OSLocation\CCDC\SystemInformation.txt -Append 
$TimeStamp3 = Get-Date
Add-Content $OSLocation\CCDC\SystemInformation.txt "Backup Created at $TimeStamp3"
Write-Host "
SystemInformation backed up to CCDC/SystemInformation.txt
    [Q] Quit to Main Menu" -ForegroundColor Cyan -BackgroundColor Black 
$SystemInformationSaved = Read-Host " "}
N {Clear}
}} Until ($InfoBackUpInput -eq 'Q' -or $SystemInformationSaved -eq 'Q')}

<#
Log Files Filtering Tool
#>
4 { do {
Clear
Write-Host "
===================================
     Log Files Filtering Tool      
-----------------------------------
    [1] Use Search Engine
    [2] View Most Recent Event Logs             (Not Enabled)
    [3] View Most Recent Security Logs
    [4] View Most Recent File and Registry Logs (Not Enabled)
    [5] View Most Recent New Programs Installed
    [6] View Most Recent Account Creation Logs
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
    $LogFilesMenu  = Read-Host " "
Switch ($LogFilesMenu)
{
1 {
do {
clear
Write-Host "
===================================
     Log Files Search Engine       
-----------------------------------
Search Security Logs
Enter A Log ID Number " -ForegroundColor Cyan -BackgroundColor Black  
$SearchEngine = Read-Host " "
Get-EventLog Security | Where-Object {$_.EventID -eq $SearchEngine} | Out-Host
Write-Host "
    [1] Save to Text File
    [Q] Quit to Previous Menu
    [ANY KEY] Search Again" -ForegroundColor Cyan -BackgroundColor Black
$ForcedReturn = Read-Host " "
Switch ($ForcedReturn)
{  
1 { do
{
Get-EventLog Security | Where-Object {$_.EventID -eq $SearchEngine} | Out-File $OSLocation\CCDC\$SeachEngine.txt -Append
$TimeStamp4 = Get-Date
Add-Content $OSLocation\CCDC\$SearchEngine.txt "Backup Created at $TimeStamp4"
Write-Host "
$SearchEngine Logs Backed up to $OSLocation\CCDC\$SearchEngine.txt

    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
    $SearchSaveQuit = Read-Host " "
    } Until ($SearchSaveQuit -eq 'Q')
}
}} Until ($ForcedReturn -eq 'Q')}   
   
2 { do { 
Clear
Write-Host "
===================================
     Log Files Filtering Tool      
-----------------------------------" -ForegroundColor Cyan -BackgroundColor Black
Get-EventLog * -Newest 25 | Out-Host
Write-Host "
    [Q]  Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
    $RecentLogQuit = Read-Host " "
} Until ($RecentLogQuit -eq 'Q') }

3 {
do {
Clear
Write-Host "
===================================
     Log Files Filtering Tool      
-----------------------------------
    [1] Short Format Log Display
    [2] Long Format Log Display
    [3] Display in Grid View
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
    $SecurityLogsMenu = Read-Host " "
    Switch ($SecurityLogsMenu)
    {

1 {
do {
Clear
Write-Host "
===================================
     Log Files Filtering Tool      
-----------------------------------" -ForegroundColor Cyan -BackgroundColor Black
Get-EventLog Security -Newest 25 | Out-Host
Write-Host "
    [1] Save To Text File
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
    $SecurityLogQuit = Read-Host " "
Switch ($SecurityLogQuit)
{
1 {
do {
Get-EventLog Security -Newest 25 | Format-List | Out-File $OSLocation\CCDC\SecurityEventLogs.txt -Append
$TimeStamp = Get-Date
Add-Content $OSLocation\CCDC\SecurityEventLogs.txt "Backup Created at $TimeStamp"
Write-Host "
Security Logs Backed up to $OSLocation\CCDC\SecurityEventLogs.txt

    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black 
$SaveLogs1Quit = Read-Host " "
} Until ($SaveLogs1Quit -eq 'Q' ) } }
} Until ($SecurityLogQuit -eq 'Q' ) }
2 {
do {
Clear
Write-Host "
===================================
     Log Files Filtering Tool      
-----------------------------------" -ForegroundColor Cyan -BackgroundColor Black
Get-EventLog Security -Newest 25 | Format-List -Property Name, Index, EntryType, InstanceID,
Message, Source, TimeGenerated, TimeWritten | Out-Host
Write-Host "
    [1] Save To Text File
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
    $SecurityLogsLong = Read-Host " "
    Switch ($SecurityLogsLong)
    {
    1 {
    Get-EventLog Security -Newest 25 | Format-List -Property Name, Index, EntryType, InstanceID,
Message, Source, TimeGenerated, TimeWritten | Out-File $OSLocation\CCDC\SecurityEventLogs.txt -Append
    $TimeStamp6 = Get-Date
    Add-Content $OSLocation\CCDC\SecurityEventLogs.txt "Backup Created at $TimeStamp6"
Write-Host "
Security Logs Backed up to $OSLocation\CCDC\SecurityEventLogs.txt

    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black 
$SaveSecurityLogsLong = Read-Host " "
}}} Until ($SecurityLogsLong -eq 'Q' -or $SaveSecurityLogsLong -eq 'Q')
}
3 {
do {
Clear
Write-Host "
===================================
     Log Files Filtering Tool      
-----------------------------------" -ForegroundColor Cyan -BackgroundColor Black
Get-EventLog Security -Newest 25 | Out-GridView
Write-Host "
    [1] Save To Text File
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
    $SecurityLogsGrid = Read-Host " "
    Switch ($SecurityLogsGrid)
    {
    1 {
    Get-EventLog Security -Newest 25 | Format-List -Property Name, Index, EntryType, InstanceID,
Message, Source, TimeGenerated, TimeWritten | Out-File $OSLocation\CCDC\SecurityEventLogs.txt -Append
    $TimeStamp7 = Get-Date
Add-Content $OSLocation\CCDC\SecurityEventLogs.txt "Backup Created at $TimeStamp7"
Write-Host "
Security Logs Backed up to $OSLocation\CCDC\SecurityEventLogs.txt

    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
$SecurityLogsGridSaved = Read-Host " "
}}} Until ($SecurityLogsGridSaved -eq 'Q' -or $SecurityLogsGrid -eq 'Q')
}
}} Until ($SecurityLogsMenu -eq 'Q')
}
4 {
do {
Clear
Write-Host "
===================================
     Log Files Filtering Tool      
-----------------------------------
Most Recent File and Registry Logs" -ForegroundColor Cyan -BackgroundColor Black
Get-EventLog -Newest 25 -LogName System | Where-object {$_.EventID -eq 4656 -or $_.EventID -eq 4657 -or 
$_.EventID -eq 4660 -or$_.EventID -eq 4660 } | Out-Gridview
Write-Host "
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
    $RegisteryLogsQuit = Read-Host " "
    } Until ($RegisteryLogsQuit -eq 'Q')}
5 {
do {
Clear
Write-Host "
===================================
     Log Files Filtering Tool      
-----------------------------------
Most Recent New Programs Installed" -ForegroundColor Cyan -BackgroundColor Black
Get-EventLog Application | Where-Object {$_.EventID -eq 4688 -or $_.EventID -eq 11707} | Out-Host
Write-Host "
    [1] Save To Text File
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
    $ProgramsLogsQuit = Read-Host " "
Switch ($ProgramsLogsQuit)
{ 
1 { 
do {
Get-EventLog Application | Where-Object {$_.EventID -eq 4688 -or $_.EventID -eq 11707} | Out-File $OSLocation\CCDC\ApplicationLogs.txt -Append
$TimeStamp3 = Get-Date 
Add-Content $OSLocation\CCDC\ApplicationLogs.txt "Backup Created at $TimeStamp3"
Write-Host "
Application Logs Backed up to $OSLocation\CCDC\ApplicationLogs.txt

    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
    $ApplicationLogsQuit = Read-Host " "
    } Until ($ApplicationLogsQuit -eq 'Q')
} 
}
    } Until ($ProgramsLogsQuit -eq 'Q')}
6 { 
do {
Clear
Write-Host "
===================================
     Log Files Filtering Tool      
-----------------------------------
    [1] Short Format Display
    [2] Long Format Display
    [3] Grid View Display
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
    $AccountCreationLogsMenu = Read-Host " "
    Switch ($AccountCreationLogsMenu)
    {
    1 { 
Clear
Write-Host "
===================================
     Log Files Filtering Tool      
-----------------------------------
Most Recent Account Creation and Removal Logs" -ForegroundColor Cyan -BackgroundColor Black
Get-EventLog Security | Where-Object {$_.EventID -eq 4720 -or $_.EventID -eq 4725 } | Out-Host 
Write-Host "
    [1] Save To Text File
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
    $AccountCreationLogsShort = Read-Host " "
    if ($AccountCreationLogsShort -eq 'Q') {Clear-History;Break}
    Switch ($AccountCreationLogsShort)
    {
    1 {
Get-EventLog Security | Where-Object {$_.EventID -eq 4720 -or $_.EventID -eq 4725 } | Out-File $OSLocation\CCDC\AccountChangesLogs.txt -Append
Write-Host "
Account Creation and Removal Logs Backed up to $OSLocation\CCDC\AccountChangesLogs.txt

    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
    $AccountCreationLogsShortQuit = Read-Host " " 
    if ($AccountCreationLogsShortQuit -eq 'Q') {Clear-History;Break}
    }}
    } 
    
2 { 
do {
Clear
Write-Host "
===================================
     Log Files Filtering Tool      
-----------------------------------
Most Recent Account Creation and Removal Logs" -ForegroundColor Cyan -BackgroundColor Black
Get-EventLog Security | Where-Object {$_.EventID -eq 4720 -or $_.EventID -eq 4725 } | Format-List | Out-Host 
Write-Host "
    [1] Save To Text File
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
    $AccountLogsQuit = Read-Host " "
Switch ($AccountLogsQuit)
{
1 {
do {
Get-EventLog Security | Where-Object {$_.EventID -eq 4720 -or $_.EventID -eq 4725} | Format-List | Out-File $OSLocation\CCDC\AccountChangesLogs.txt -Append
$TimeStamp5 = Get-Date
Add-Content $OSLocation\CCDC\AccountChangesLogs.txt "Backup Created at $TimeStamp5"
Write-Host "
Account Creation and Removal Logs Backed up to $OSLocation\CCDC\AccountChangesLogs.txt

    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
    $AccountLogsSaveQuit = Read-Host " "
    } Until ($AccountLogsSaveQuit -eq 'Q')
}}} Until ($AccountLogsSaveQuit -eq 'Q' -or $AccountLogsQuit -eq 'Q')
}
3 {
do {
Clear
Write-Host "
===================================
     Log Files Filtering Tool      
-----------------------------------
Most Recent Account Creation and Removal Logs" -ForegroundColor Cyan -BackgroundColor Black
Get-EventLog Security | Where-Object {$_.EventID -eq 4720 -or $_.EventID -eq 4725 } | Out-GridView
Write-Host "
    [1] Save To Text File
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
    $AccountLogsGrid = Read-Host " "
    Switch ($AccountLogsGrid)
    {
    1 { 
    
Get-EventLog Security | Where-Object {$_.EventID -eq 4720 -or $_.EventID -eq 4725 } | Format-List | Out-File $OSLocation\CCDC\AccountChangesLogs.txt -Append
$TimeStamp8 = Get-Date
Add-Content $OSLocation\CCDC\AccountChangesLogs.txt "Backup Created at $TimeStamp8"
Write-Host "
Account Creation and Removal Logs Backed up to $OSLocation\CCDC\AccountChangesLogs.txt

    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
    $AccountLogsGridQuit = Read-Host " "
    }}
    } Until ($AccountLogsGridQuit -eq 'Q' -or $AccountLogsGrid -eq 'Q')}
    }} Until ($AccountCreationLogsMenu -eq 'Q')
}
}} Until ($LogFilesMenu -eq 'Q') 

<#
Network Monitoring Tool
#>
}
5 {  
Clear
if (Test-Path $OSLocation\CCDC\SubScripts\PingScript.ps1) {
Write-Host "
===============================
    Network Monitoring Tool    
-------------------------------
" -ForegroundColor Cyan -BackgroundColor Black
Write-Host "
Opening in new Window" -ForegroundColor Cyan -BackgroundColor Black
Start-Process -FilePath "powershell" -argument '
 \CCDC\SubScripts\PingScript.ps1 '
 Write-Host "
    [R]  Return to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
$Monitortool = Read-Host " " 
}
Else {
Write-Host "
===============================
    Network Monitoring Tool    
-------------------------------
" -ForegroundColor Cyan -BackgroundColor Black
Write-Host "
PingScript.ps1 was not found in the 
$OSLocation\CCDC\SubScripts folder" -ForegroundColor Red -BackgroundColor Black
Write-Host "
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
    Read-Host " "
}

} 
<#
EternalBlue Vulnerability Checker
#>
6 {do
{clear;$hotfixes = "KB3205409", "KB3210720", "KB3210721", "KB3212646", "KB3213986", 
"KB4012212", "KB4012213", "KB4012214", "KB4012215", "KB4012216", "KB4012217", 
"KB4012218", "KB4012220", "KB4012598", "KB4012606", "KB4013198", "KB4013389", 
"KB4013429", "KB4015217", "KB4015438", "KB4015546", "KB4015547", "KB4015548", 
"KB4015549", "KB4015550", "KB4015551", "KB4015552", "KB4015553", "KB4015554", 
"KB4016635", "KB4019213", "KB4019214", "KB4019215", "KB4019216", "KB4019263", 
"KB4019264", "KB4019472", "KB4015221", "KB4019474", "KB4015219", "KB4019473"

#checks the computer it's run on if any of the listed hotfixes are present
$hotfix = Get-HotFix -ComputerName $env:computername | Where-Object {$hotfixes -contains $_.HotfixID} | Select-Object -property "HotFixID"

#confirms whether hotfix is found or not
if (Get-HotFix | Where-Object {$hotfixes -contains $_.HotfixID})
{"Your Computer has been Patched for EternalBlue!: " + $hotfix.HotFixID} 
else 
{Write-Host ”
WARNING : Was unable to find Patch for EternalBlue! Patch NOW!

Go To: https://docs.microsoft.com/en-us/security-updates/SecurityBulletins/2017/ms17-010
For Your Hotfix" -ForegroundColor Red -BackgroundColor Black
Write-Host "
Would you like to apply a hotfix from the Security Suites Library?

    [Y] Yes
    [Q] Quit to Main Menu" -ForegroundColor Cyan -BackgroundColor Black
$HotfixApply = Read-Host " "
if ($HotfixApply -eq 'Q') {Break}
if ($HotfixApply -eq 'Y') {
Clear
Write-Host "
=====================================
           HotFix Library            
-------------------------------------

    [1] Windows Server 2012 HotFix
    [2] Windows 2008 HotFix
    [Q] Quit to Main Menu
" -ForegroundColor Cyan -BackgroundColor Black
$HFSelect = Read-Host " "
if ($HFSelect -eq 'Q') {Break}
Switch ($HFSelect) {
1 {
wusa $OSLocation\CCDC\HotFixLibrary\Windows8.1-kb4012216-x64_cd5e0a62e602176f0078778548796e2d47cfa15b.msu
Clear
Write-Host "
HotFix Install Initiated" -ForegroundColor Cyan -BackgroundColor Black
}
}
}
}
Write-Host "
    [Q] Quit to Main Menu" -ForegroundColor Cyan -BackgroundColor Black
    $EternalBlueMenu = Read-Host " "} until ($EternalBlueMenu -eq 'Q')}
<#
Users Monitoring Tool
#>
7 {
do {
Clear
Write-Host "
=====================================
        Users Monitoring Tool        
-------------------------------------
    [1] Check for New Users
    [2] Create a Users Reference List
    [Q] Quit to Main Menu" -ForegroundColor Cyan -BackgroundColor Black
    $UsersMenuSelect = Read-Host " "
    Switch ($UsersMenuSelect)
    {
    1 { 
    do {
    $File2 = get-ciminstance win32_useraccount | Select-Object Name | Format-Table -HideTableHeaders | Out-File $OSLocation\CCDC\UsersbackupScan
 Clear
 Write-Host "
=====================================
        Users Monitoring Tool        
-------------------------------------
Any new users will be displayed below" -ForegroundColor Cyan -BackgroundColor Black
Compare-Object -ReferenceObject $(Get-Content $OSLocation\CCDC\UsersbackupReference) -DifferenceObject $(Get-Content $OSLocation\CCDC\Usersbackupscan) |
Out-Host
Write-Host "
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
   $UsersDisplay = Read-Host " "
 } Until ($UsersDisplay -eq 'Q')
 }
    2 { do { get-ciminstance win32_useraccount | Select-Object Name | Format-Table -HideTableHeaders | Out-File $OSLocation\CCDC\UsersbackupReference
    Clear
    Write-Host "
=====================================
        Users Monitoring Tool        
-------------------------------------
Reference List Created of Current Users
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
   $UsersReferenceDisplay = Read-Host " "
   } 
   Until ($UsersReferenceDisplay -eq 'Q') }  
    }
} Until ($UsersMenuSelect -eq 'Q')
 
}

<#
Firewall Rules Tool
#>

8 {
do {
Clear
Write-Host "
=====================================
            Firewall Tool            
-------------------------------------
    [1] Create a Rule to Allow Inbound Traffic
    [2] Create a Rule to Block Inbound Traffic
    [3] Create a Rule to Allow Outbound Traffic
    [4] Create a Rule to Block Outbound Traffic
    [5] Delete a Rule
    [6] Display Current Firewall Rules
    [7] Display All Connections and Listening Ports
    [8] Display Routing Table
    [Q] Quit to Main Menu" -ForegroundColor Cyan -BackgroundColor Black
    $FirewallRulesMenu = Read-Host " "
    Switch ($FirewallRulesMenu) {
    1 {
    do {
    Clear
    Write-Host "
=====================================
            Firewall Tool            
-------------------------------------
What would you like the New allow in rule to be called?

    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
    $NewAllowRule = Read-Host " "
    if ($NewAllowRule -eq 'Q') {Clear-History;Break}
Clear
Write-Host "
Rule Name Set to $NewAllowRule" -ForegroundColor Green -BackgroundColor Black
    Write-Host "
=====================================
            Firewall Tool            
-------------------------------------
What Port Number would you like to Allow traffic in through?

    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
    $NewAllowPortNum = Read-Host " "
    if ($NewAllowPortNum -eq 'Q') {Clear-History;Break}
Clear
Write-Host "
Rule Name Set to $NewAllowRule" -ForegroundColor Green -BackgroundColor Black
Write-Host "
Target Port set to $NewAllowPortNum" -ForegroundColor Green -BackgroundColor Black
    Write-Host "
=====================================
            Firewall Tool            
-------------------------------------
What will be the set Protocol? Ex: TCP

    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
    $NewProtocolAllow = Read-Host " "
    if ($NewProtocolAllow -eq 'Q') {Clear-History;Break}
New-NetFirewallRule -DisplayName "$NewAllowRule" -Direction Inbound -LocalPort $NewAllowPortNum -Protocol $NewProtocolAllow -Action Allow
Clear
Write-Host "
=====================================
            Firewall Tool            
-------------------------------------
Your New Firewall Rule Has Been Created" -ForegroundColor Cyan -BackgroundColor Black
Get-NetfirewallRule -DisplayName $NewAllowRule | Out-Host
Write-Host "
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
    $AllowRuleDone = Read-Host " "
} Until ($AllowRuleDone -eq 'Q')
    }
    
    2 {
    do {
    Clear
Write-Host "
=====================================
            Firewall Tool            
-------------------------------------
What would you like the New Block rule to be called?

    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
    $NewBlockRule = Read-Host " "
    if ($NewBlockRule -eq 'Q') {Clear-History;Break}

Clear
Write-Host "
Rule Name Set to $NewBlockRule" -ForegroundColor Green -BackgroundColor Black
    Write-Host "
=====================================
            Firewall Tool            
-------------------------------------
What Port Number would you like to Block traffic in through?

    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
    $NewBlockPortNum = Read-Host " "
    if ($NewBlockPortNum -eq 'Q') {Clear-History;Break}

Clear
Write-Host "
Rule Name Set to $NewBlockRule" -ForegroundColor Green -BackgroundColor Black
Write-Host "
Target Port set to $NewBlockPortNum" -ForegroundColor Green -BackgroundColor Black
    Write-Host "
=====================================
            Firewall Tool            
-------------------------------------
What will be the set Protocol? Ex: TCP

    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
    $NewProtocolBlock = Read-Host " "
    if ($NewProtocolBlock -eq 'Q') {Clear-History;Break}

New-NetFirewallRule -DisplayName "$NewBlockRule" -Direction Inbound -LocalPort $NewBlockPortNum -Protocol $NewProtocolBlock -Action Block
Clear
Write-Host "
=====================================
            Firewall Tool            
-------------------------------------
Your New Firewall Rule Has Been Created" -ForegroundColor Cyan -BackgroundColor Black
Get-NetfirewallRule -DisplayName $NewBlockRule | Out-Host
Write-Host "
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
    $BlockRuleDone = Read-Host " "
    } Until ($BlockRuleDone -eq 'Q')
    }

3 { do {
Clear
Write-Host "
=====================================
            Firewall Tool            
-------------------------------------
What would you like the New Allow out rule to be called?

    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
    $NewAllowOutRule = Read-Host " "
    if ($NewAllowOutRule -eq 'Q') {Clear-History;Break}
Clear
Write-Host "
Rule Name Set to $NewAllowOutRule" -ForegroundColor Green -BackgroundColor Black
    Write-Host "
=====================================
            Firewall Tool            
-------------------------------------
What Port Number would you like to Allow traffic Out through?

    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
    $NewAllowOutPortNum = Read-Host " "
    if ($NewAllowOutPortNum -eq 'Q') {Clear-History;Break}
Clear
Write-Host "
Rule Name Set to $NewAllowOutRule" -ForegroundColor Green -BackgroundColor Black
Write-Host "
Target Port set to $NewAllowOutPortNum" -ForegroundColor Green -BackgroundColor Black
    Write-Host "
=====================================
            Firewall Tool            
-------------------------------------
What will be the set Protocol? Ex: TCP

    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
    $NewProtocolAllowOut = Read-Host " "
    if ($NewProtocolAllowOut -eq 'Q') {Clear-History;Break}
New-NetFirewallRule -DisplayName "$NewAllowOutRule" -Direction OutBound -LocalPort $NewAllowOutPortNum -Protocol $NewProtocolAllowOut -Action Allow
Clear
Write-Host "
=====================================
            Firewall Tool            
-------------------------------------
Your New Firewall Rule Has Been Created" -ForegroundColor Cyan -BackgroundColor Black
Get-NetfirewallRule -DisplayName $NewAllowOutRule | Out-Host
Write-Host "
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
    $AllowOutRuleDone = Read-Host " "
} Until ($AllowOutRuleDone -eq 'Q')
}

4 { do {
Clear
Write-Host "
=====================================
            Firewall Tool            
-------------------------------------
What would you lke the New Block out rule to be called?

    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
    $NewBlockOutRule = Read-Host " "
    if ($NewBlockOutRule -eq 'Q') {Clear-History;Break}
Clear
Write-Host "
Rule Name Set to $NewBlockOutRule" -ForegroundColor Green -BackgroundColor Black
    Write-Host "
=====================================
            Firewall Tool            
-------------------------------------
What Port Number would you like to Block traffic Out for?

    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
    $NewBlockOutPortNum = Read-Host " "
    if ($NewBlockOutPortNum -eq 'Q') {Clear-History;Break}
Clear
Write-Host "
Rule Name Set to $NewBlockOutRule" -ForegroundColor Green -BackgroundColor Black
Write-Host "
Target Port set to $NewBlockOutPortNum" -ForegroundColor Green -BackgroundColor Black
    Write-Host "
=====================================
            Firewall Tool            
-------------------------------------
What will be the set Protocol? Ex: TCP

    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
    $NewProtocolBlockOut = Read-Host " "
    if ($NewProtocolBlockOut -eq 'Q') {Clear-History;Break}
New-NetFirewallRule -DisplayName "$NewBlockOutRule" -Direction OutBound -LocalPort $NewBlockOutPortNum -Protocol $NewProtocolBlockOut -Action Block
Clear
Write-Host "
=====================================
            Firewall Tool            
-------------------------------------
Your New Firewall Rule Has Been Created" -ForegroundColor Cyan -BackgroundColor Black
Get-NetfirewallRule -DisplayName $NewBlockOutRule | Out-Host
Write-Host "
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
    $BlockOutRuleDone = Read-Host " "
} Until ($BlockOutRuleDone -eq 'Q')
}

5 { do {
Clear
Write-Host "
=====================================
            Firewall Tool            
-------------------------------------
What is the Display Name of the rule you would like Deleted?
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
$DeleteRule = Read-Host " "
if ($DeleteRule -eq 'Q') {Clear-History;Break}
Remove-NetFirewallRule -DisplayName $DeleteRule
Write-Host "
$DeleteRule has been removed

    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
$RuleRemoved = Read-Host " "
} Until ($RuleRemoved -eq 'Q') }

6 {
do {
Clear
Write-Host "
=====================================
            Firewall Tool            
-------------------------------------" -ForegroundColor Cyan -BackgroundColor Black
"Loading Please Wait"
Get-NetFirewallrule | Out-GridView
Clear
Write-Host "
=====================================
            Firewall Tool            
-------------------------------------

    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
$GridViewQuit = Read-Host " "
} Until ($GridViewQuit -eq 'Q')
}

7 {
Clear
Write-Host "
=====================================
            Firewall Tool            
-------------------------------------" -ForegroundColor Cyan -BackgroundColor Black
netstat -ano | Out-GridView
Write-Host "
If you find an open Connection or Port
that should not be open, then go back and
double check your firewall rules to findout
how the connection is getting through.

You can also stop the connection by killing
the process using the PID or Process Identifier
and the Process Control Tool" -ForegroundColor Red -BackgroundColor Black
Write-Host "
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
$DisplayListeningQuit = Read-Host " "
if ($DisplayListeningQuit -eq 'Q') {Clear-History;Break}
}

8 {
Clear
Write-Host "
=====================================
            Firewall Tool            
-------------------------------------" -ForegroundColor Cyan -BackgroundColor Black
netstat -r | Out-Host
Write-Host "
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
$RoutingTableQuit = Read-Host " "
if ($RoutingTableQuit -eq 'Q') {Clear-History;Break}
}

}
} Until ($FirewallRulesMenu -eq 'Q')
}

<#
Process Control Tool
#>
10 {
do {
Clear
Write-Host "
=====================================
        Process Control Tool         
-------------------------------------
    [1] Search Engine
    [2] Show Running Processes Full
    [3] Show Running Processes Filtered (Not Optimized)
    [4] Kill a Process
    [Q] Quit to Main Menu" -ForegroundColor Cyan -BackgroundColor Black
$ProcessControlMenu = Read-Host " "
Switch ($ProcessControlMenu) {

1 {
Clear
Write-Host "
=====================================
        Process Control Tool         
-------------------------------------
Search by PID or Process/Image Name

    [1] Process Identifier
    [2] Process/Image Name
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
$PCSearchEngineMenu = Read-Host " "
if ($PCSearchEngineMenu -eq 'Q') {Clear-History;Break}
Switch ($PCSearchEngineMenu) 
{
1 {
Clear
Write-Host "
=====================================
        Process Control Tool         
-------------------------------------
Enter the PID

    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
$PIDInput = Read-Host " "
if ($PIDInput -eq 'Q') {Clear-History;Break}
clear
Write-Host "
=====================================
        Process Control Tool         
-------------------------------------
" -ForegroundColor Cyan -BackgroundColor Black
tasklist /fi "PID eq $PIDInput"
Write-Host "
    [Q] Quit to Process Control Menu" -ForegroundColor Cyan -BackgroundColor Black
$PIDSearchQuit = Read-Host " "
if ($PIDSearchQuit -eq 'Q') {Clear-History;Break}
}
2 {
Clear
Write-Host "
=====================================
        Process Control Tool         
-------------------------------------
Enter the Process/Image Name

    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
$ImageName = Read-Host " "
if ($ImageName -eq 'Q') {Clear-History;Break}
clear
Write-Host "
=====================================
        Process Control Tool         
-------------------------------------
" -ForegroundColor Cyan -BackgroundColor Black
tasklist /fi "ImageName eq $ImageName"
Write-Host "
    [Q] Quit to Process Control Menu" -ForegroundColor Cyan -BackgroundColor Black
$ImageSearchQuit = Read-Host " "
if ($ImageSearchQuit -eq 'Q') {Clear-History;Break}
}
}
}

2 {
Clear
Write-Host "
=====================================
        Process Control Tool         
-------------------------------------" -ForegroundColor Cyan -BackgroundColor Black
tasklist
Write-Host "
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
$RunningProcessQuit = Read-Host " "
if ($RunningProcessQuit -eq 'Q') {Clear-History;Break}
}

3 { 
Clear
Write-Host "
=====================================
        Process Control Tool         
-------------------------------------" -ForegroundColor Cyan -BackgroundColor Black
tasklist /fi “ImageName ne svchost.exe”  /fi “ImageName ne System” `
/fi “ImageName ne vmtoolsd.exe” /fi “ImageName ne explorer.exe”`
 /fi “ImageName ne powershell.exe” /fi “ImageName ne tasklist.exe”`
 /fi “ImageName ne winlogon.exe”
Write-Host "
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
$ProcessFilteredQuit = Read-Host " "
if ($ProcessFilteredQuit -eq 'Q') {Clear-History;Break}

}

4 {
Clear
Write-Host "
=====================================
        Process Control Tool         
-------------------------------------
Kill by PID or Process/Image Name?
    [1] Process Identifier
    [2] Process/Image Name
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
$KillProcessMenu = Read-Host " "
if ($KillProcessMenu -eq 'Q') {Clear-History;Break}
Switch ($KillProcessMenu) {
1 {
Clear
Write-Host "
=====================================
        Process Control Tool         
-------------------------------------
What is the PID of the Process you would like to kill?

    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
$PIDKill = Read-Host " "
if ($PIDKill -eq 'Q') {Clear-History;Break}
TaskKill /PID $PIDKill /F
Clear
Write-Host "
=====================================
        Process Control Tool         
-------------------------------------
Process $PIDKill has been Stopped

    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
$PIDKillQuit = Read-Host " "
if ($PIDKillQuit -eq 'Q') {Clear-History;Break}
}
2 {
Clear
Write-Host "
=====================================
        Process Control Tool         
-------------------------------------
What is the Process/Image Name of the Process you would like to kill?

    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
$ImageKill = Read-Host " "
if ($ImageKill -eq 'Q') {Clear-History;Break}
TaskKill /IM $ImageKill /F
Clear
Write-Host "
=====================================
        Process Control Tool         
-------------------------------------
Process $ImageKill has been Stopped

    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
$ImageKillQuit = Read-Host " "
if ($ImageKillQuit -eq 'Q') {Clear-History;Break} 
}
}
}
}
} Until ($ProcessControlMenu -eq 'Q')
}
<#
Arp Tool
#>
11 {
do {
Clear
Write-Host "
=====================================
             Arp Tool                
-------------------------------------

    [1] Display Arp Entries
    [2] Add a Static Arp Entry
    [3] Remove a Static Arp Entry
    [4] Clear Entire Arp Cache
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
$ArpMenu = Read-Host " "
Switch ($ArpMenu) {
1 {
Clear
Write-Host "
=====================================
             Arp Tool                
-------------------------------------" -ForegroundColor Cyan -BackgroundColor Black
Arp -a
Write-Host "
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
$DisplayArp = Read-Host " "
if ($DisplayArp -eq 'Q') {Break}
}
2 {
Clear
Write-Host "
=====================================
             Arp Tool                
-------------------------------------
What is the IP Address of the new Arp Entry?

    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
$ArpAddIp = Read-Host " "
if ($ArpAddIp -eq 'Q') {Break}
Clear
Write-Host "
New Arp Entry Ip Set to $ArpAddIp" -ForegroundColor Green -BackgroundColor Black
Write-Host "
=====================================
             Arp Tool                
-------------------------------------
What is the MAC Address of the new Arp Entry?

Ex: aa-aa-aa-aa-aa-aa

    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
$ArpAddMac = Read-Host " "
if ($ArpAddMac -eq 'Q') {Break}
arp -s $ArpAddIp $ArpAddMac
Clear
Write-Host "
=====================================
             Arp Tool                
-------------------------------------
New Entry Added" -ForegroundColor Cyan -BackgroundColor Black
Arp -a
Write-Host "
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
$NewArpQuit = Read-Host " "
if ($NewArpQuit -eq 'Q') {Break}
}
3 {
Clear
Write-Host "
=====================================
             Arp Tool                
-------------------------------------
What is the IP of the Arp Entry would you like to remove?" -ForegroundColor Cyan -BackgroundColor Black
Arp -a
Write-Host "
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
$ArpDelete = Read-Host " "
if ($ArpDelete -eq 'Q') {Break}
Arp -d $ArpDelete
Clear
Write-Host "
=====================================
             Arp Tool                
-------------------------------------
$ArpDelete has been Removed" -ForegroundColor Cyan -BackgroundColor Black
Arp -a
Write-Host "
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
$ArpDeleteQuit = Read-Host " "
if ($ArpDeleteQuit -eq 'Q') {Break}

}
4 {
Clear
Write-Host "
=====================================
             Arp Tool                
-------------------------------------" -ForegroundColor Cyan -BackgroundColor Black
Write-Host "
This will clear your ENTIRE Arp cache
are you sure you wish to continue?" -ForegroundColor Red -BackgroundColor Black
Write-Host "
    [Y] Yes Continue
    [N] No and Quit" -ForegroundColor Cyan -BackgroundColor Black
$ClearArpCache = Read-Host " "
If ($ClearArpCache -eq 'Y') {arp -d *}
if ($ClearArpCache -eq 'N') {Break}
}

}
} Until ($ArpMenu -eq 'Q')
}

<#
Incident Report Generator
#>
12 { 
$IncidentTestPath = Test-Path $OSLocation\CCDC\IncidentReports
If ($IncidentTestPath -ne $True) {New-Item -path $OSLocation\CCDC\ -name IncidentReports -type "directory"}
do {
Clear
Write-Host "
=====================================
      Incident Report Generator      
-------------------------------------
What would you like this Incident saved as?
    [Q] Quit to Main Menu" -ForegroundColor Cyan -BackgroundColor Black
$IncidentSaveName = Read-Host " "
if ($IncidentSaveName -eq 'Q') {Clear-History;Break}

Clear
Write-Host "
Incident Report will be saved as $IncidentSaveName" -ForegroundColor Green -BackgroundColor Black
Write-Host "
=====================================
      Incident Report Generator      
-------------------------------------
At what Box did the incident occure?
    [1] Windows 2012 WebApps
    [2] Windows 2008 R2
    [3] Windows 2003 Server
    [4] Input Box Name
    [Q] Quit to Main Menu" -ForegroundColor Cyan -BackgroundColor Black
    $IncidentMainMenu = Read-Host " "
   if ($IncidentMainMenu -eq 'Q') {Clear-History;Break}
   Elseif ($IncidentMainMenu -eq '1') {$BoxName = "Windows 2012 WebApps"}
   Elseif ($IncidentMainMenu -eq '2') {$BoxName = "Windows 2008 R2"}
   Elseif ($IncidentMainMenu -eq '3') {$BoxName = "Windows 2003 Server"}
   Elseif ($IncidentMainMenu -eq '4') {
    Write-Host "
=====================================
      Incident Report Generator      
-------------------------------------
Enter the Name of the Box where the incident occured
Example: Windows 2012 WebApps" -ForegroundColor Cyan -BackgroundColor Black
$BoxNameInput = Read-Host " ";
    $BoxName = $BoxNameInput}

Clear
Write-Host "
Machine set as $BoxName" -ForegroundColor Green -BackgroundColor Black
Write-Host "
=====================================
      Incident Report Generator      
-------------------------------------
What type of Incident was this?
    [1] Malicious Scheduled Task
    [2] Unauthorized User Created
    [3] Unauthorized Privilege Escalation
    [4] Malicious Software Installed
    [5] Input Event
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
    $TypeofIncidentInput = Read-Host " "
    if ($TypeofIncidentInput -eq 'Q') {Clear-History;Break}
    Elseif ($TypeofIncidentInput -eq '1') {$TypeofIncident = "Malicious Scheduled Task Found"} 
    ElseIf ($TypeofIncidentInput -eq '2') {$TypeofIncident = "Unauthorized User Created"}
    ElseIf ($TypeofIncidentInput -eq '3') {$TypeofIncident = "Unauthorized Privilege Escalation"}
    ElseIf ($TypeofIncidentInput -eq '4') {$TypeofIncident = "Malicious Software Installed"}
    ElseIf ($TypeofIncidentInput -eq '5') {
    Clear
Write-Host "
=====================================
      Incident Report Generator      
-------------------------------------
Input the Type Event that Occured
Example: Unauthorized User Created" -ForegroundColor Cyan -BackgroundColor Black
$TypeofIncidentRead = Read-Host " "
$TypeofIncident = $TypeofIncidentRead}

Clear
Write-Host "
Machine set as $BoxName" -ForegroundColor Green -BackgroundColor Black 
Write-Host "
Incident Type set to $TypeofIncident" -ForegroundColor Green -BackgroundColor Black
Write-Host "
=====================================
      Incident Report Generator      
-------------------------------------
When did the Incident Occur
    [1] Use Current Time
    [2] Input Time
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
    $IncidentTimeInput = Read-Host " "
    if ($IncidentTimeInput -eq 'Q') {Clear-History;Break}
    Elseif ($IncidentTimeInput -eq '1') {$IncidentTime = Get-date}
    Elseif ($IncidentTimeInput -eq '2') {
Clear
Write-Host "
=====================================
      Incident Report Generator      
-------------------------------------
Input the Time the Incident Occured" -ForegroundColor Cyan -BackgroundColor Black
$OccuranceTimeInput = Read-Host " ";
$IncidentTime = $OccuranceTimeInput}

$IncidentEndTimeGet = Get-Date
Clear
Write-Host "
Machine set as $BoxName" -ForegroundColor Green -BackgroundColor Black 
Write-Host "
Incident Type set to $TypeofIncident" -ForegroundColor Green -BackgroundColor Black
Write-Host "
=====================================
      Incident Report Generator      
-------------------------------------
Activity report. When did the Incident end?
    [1] Use Current Time
    [2] Input Time
    [ENTER] Skip
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
    $IncidentEndTimeInput = Read-Host " "
    if ($IncidentEndTimeInput -eq 'Q') {Clear-History;Break}
    Elseif ($IncidentEndTimeInput -eq '1') {$IncidentEndTime = "
The Incident occured until $IncidentEndTimeGet"}
    Elseif ($IncidentEndTimeInput -eq '2') {
    Clear
    Write-Host "
=====================================
      Incident Report Generator      
-------------------------------------
Input the Time the Incident Ended" -ForegroundColor Cyan -BackgroundColor Black
$IncidentEndTimeInput = Read-Host " "
$IncidentEndTime = "
The Incident occured until $IncidentEndTimeInput"}
    Elseif ($IncidentEndTimeInput -eq '') {$IncidentEndTime = " "}

Clear
Write-Host "
Machine set as $BoxName" -ForegroundColor Green -BackgroundColor Black 
Write-Host "
Incident Type set to $TypeofIncident" -ForegroundColor Green -BackgroundColor Black
Write-Host "
Incident Time set to $IncidentTime" -ForegroundColor Green -BackgroundColor Black
Write-Host "
=====================================
      Incident Report Generator      
-------------------------------------
Add a description of the Incident
(THIS DOES NOT INCLUDE HOW THE INCIDENT WAS RESOLVED)" -ForegroundColor Cyan -BackgroundColor Black
$IncidentDescription = Read-Host " "

Clear
Write-Host "
Machine set as $BoxName" -ForegroundColor Green -BackgroundColor Black 
Write-Host "
Incident Type set to $TypeofIncident" -ForegroundColor Green -BackgroundColor Black
Write-Host "
Incident Time set to $IncidentTime" -ForegroundColor Green -BackgroundColor Black
Write-Host "
Incident Description set" -ForegroundColor Green -BackgroundColor Black
Write-Host "
=====================================
      Incident Report Generator      
-------------------------------------
How was the Incident Resolved?" -ForegroundColor Cyan -BackgroundColor Black
$IncidentResolution = Read-Host " "


    $IncidentReport = "
=====================================
          INCIDENT REPORT
-------------------------------------

Jackson College CCDC Team

Type of Incident: $TypeofIncident
Incident occured on: $BoxName box
Time of Incident: $IncidentTime $IncidentEndTime

Incident Description: $IncidentDescription

How the Incident was Resolved: $IncidentResolution
"
    $IncidentReport | Out-File $OSLocation\CCDC\IncidentReports\$IncidentSaveName.txt -Append

Clear
Write-Host "
Incident report created at $OSLocation\CCDC\IncidentReports\$IncidentSaveName.txt
    [Q] Quit to Main Menu" -ForegroundColor Cyan -BackgroundColor Black
   $IncidentFinish =  Read-Host " "
 
} Until ($IncidentFinish -eq 'Q' -or $IncidentMainMenu -eq 'Q' -or $TypeofIncidentInput -eq 'Q' -or $IncidentEndTimeInput -eq 'Q') }

<#
Full Control Tools Section
#>
F {
do {
Clear
Write-Host "
=====================================
         Full Control Tools          
-------------------------------------" -ForegroundColor Cyan -BackgroundColor Black
Write-Host "
WARNING!!!
These tools have been designed to run without
your permission. They can and WILL permanently
effect your system." -ForegroundColor Red -BackgroundColor Black
Write-Host "
    [C] Continue
    [Q] Quit to Main Menu" -ForegroundColor Cyan -BackgroundColor Black
$FullControlAccess = Read-Host " "
Switch ($FullControlAccess) 
{
C {
do {
Clear
Write-Host "
=====================================
         Full Control Tools          
-------------------------------------

    [1] User Account Police
    [2] Local Arp Police
    [3] Scheduled Task Police
    [H] Help
    [Q] Quit to Main Menu" -ForegroundColor Cyan -BackgroundColor Black
$FCMenuSelect = Read-Host " "
Switch ($FCMenuSelect) {
1 {
Clear
Write-Host "
=====================================
         Full Control Tools          
-------------------------------------
" -ForegroundColor Cyan -BackgroundColor Black
if (Test-Path $OSLocation\CCDC\SubScripts\UserAccountPolice.ps1) {
Start-Process -FilePath "powershell" -argument '
  \CCDC\SubScripts\UserAccountPolice.ps1 '
Write-Host "
Tool has opened in new window

    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
$UserAccountPoliceOpened = Read-Host " "  
 if ($UserAccountPoliceOpened -eq 'Q') {Break}
  }
Else {
Write-Host "
The UserAccountPolice.ps1 is not located within the
$OSLocation\CCDC\SubScripts folder and therefore
cannot be ran" -ForegroundColor Red -BackgroundColor Black
Write-Host "
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
Read-Host " "
}
}

2 {
Clear
Write-Host "
=====================================
         Full Control Tools          
-------------------------------------
" -ForegroundColor Cyan -BackgroundColor Black
if (Test-Path $OSLocation\CCDC\SubScripts\LocalArpPolice.ps1) {
Start-Process -FilePath "powershell" -argument '
  \CCDC\SubScripts\LocalArpPolice.ps1 '
Write-Host "
Tool has opened in new window

    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
$LocalArpPoliceOpened = Read-Host " "
 if ($LocalArpPoliceOpened -eq 'Q') {Break}
}
Else {
Write-Host "
The LocalArpPolice.ps1 is not located within the
$OSLocation\CCDC\SubScripts folder and therefore
cannot be ran" -ForegroundColor Red -BackgroundColor Black
Write-Host "
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
Read-Host " "
}
}

3 {
Clear
Write-Host "
=====================================
         Full Control Tools          
-------------------------------------
" -ForegroundColor Cyan -BackgroundColor Black
if (Test-Path $OSLocation\CCDC\SubScripts\ScheduledTaskPolice.ps1) {
Start-Process -FilePath "powershell" -argument '
  \CCDC\SubScripts\ScheduledTaskPolice.ps1 '
Write-Host "
Tool has opened in new window

    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
$ScheduledTaskPoliceOpened = Read-Host " "
 if ($ScheduledTaskPoliceOpened -eq 'Q') {Break}
}
Else {
Write-Host "
The ScheduledTaskPolice.ps1 is not located within the
$OSLocation\CCDC\SubScripts folder and therefore
cannot be ran" -ForegroundColor Red -BackgroundColor Black
Write-Host "
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
Read-Host " "
}
}

H {
Clear
Write-Host "
=====================================
         Full Control Help           
-------------------------------------
[1] User Account Police: This tool will take a snapshot
    of the current Users list and if any new user is
    created, the tool will delete the New user, notify you
    and write up an incident report.

[2] Local Arp Police: This tool will take a snapshot of
    the current Arp list and if any new arp entries are
    added, the tool will remove them, notify you and 
    write up an incident report.

[3] Scheduled Task Police: This tool will take a snapshot
    of the current scheduled tasks and if any new tasks
    are detected it will alert you. WARNING this tool
    is not designed to take action against a new task.

    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
$FCHelp = Read-Host " "
if ($FCHelp -eq 'Q') {Break}
}
}
} Until ($FCMenuSelect -eq 'Q') 
}
}
} Until ($FullControlAccess -eq 'Q')
}
<#
Help Section
#>
H {
do {
Clear
Write-Host "
================================
           Help Menu            
--------------------------------
    [1] CCDC Check List
    [2] Windows Intelligent Security Suite Troubleshooter
    [Q] Quit to Main Menu
" -ForegroundColor Cyan -BackgroundColor Black
$HelpMainMenu = Read-Host " "
Switch ($HelpMainMenu) {
1 { do {
Clear-History
Clear
Write-Host "
================================
           Help Menu            
--------------------------------" -ForegroundColor Cyan -BackgroundColor Black
Write-Host "
CCDC Check List

    1. Change passwords on all accounts
    
    2. Check Network connections (Network Monitoring Tool)

    3. Make sure you are not logged in as Admin
    
    4. Check for legitimate accounts and disable 
       outdated or questionable accounts
    
    5. Disable the built-in Admin account (RID 500)
    
    6. Check scheduled tasks (Crontab)
    
    7. Check current software version and 
       start applying Security Patches
    
    8. Scan the network for open ports and disable
       unused services 

    9. Turn off any uncessary services (SVCHost)

    10. Set up firewalls and test

    11. Configure static Arp (Arp Tool)

    12. Have proper backups and restore plan

    13. Check and monitor logs

    14. Install AV and start to scan system
    
    15. Take invetory of hardware and software
     "
Write-Host "
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
$CCDCCheckList = Read-Host " "
} Until ($CCDCCheckList -eq 'Q') 
}

2 { do {
Clear
Write-Host "
================================
        TroubleShooting         
--------------------------------" -ForegroundColor Cyan -BackgroundColor Black
Write-Host "
Why is the Network Monitoring Tool not Starting?" -ForegroundColor Cyan -BackgroundColor Black
Write-Host "
Make sure you have the PingScript.ps1 saved in the $OSLocation\CCDC\ folder
You can get the PingScript.ps1 off the Google drive in the Scripts folder"
Write-Host "
Where are my backups being saved?" -ForegroundColor Cyan -BackgroundColor Black
Write-Host "
Backups of users list, logs, and other such documentation created by the 
Windows Intelligent Security Suite are saved to the $OSLocation\CCDC\ directory"
Write-Host "
When I go to create a new user, the new user is not appearing" -ForegroundColor Cyan -BackgroundColor Black
Write-Host "
This will happen if the Password you give the new user does not meet the
password requirments. Either check your requirments or try a harder password"
Write-Host "
    [Q] Quit to Previous Menu"  -ForegroundColor Cyan -BackgroundColor Black
$TroubleShootQuit = Read-Host " "
} Until ($TroubleShootQuit -eq 'Q')
}
}
} Until ($HelpMainMenu -eq 'Q')
}
<#
Patch Notes
#>
P {
do {
Clear
Write-Host "
================================
           Patch Notes          
--------------------------------" -ForegroundColor Cyan -BackgroundColor Black
Write-Host "
Optimized for Detected $CurrentOSVersion" -ForegroundColor Green -BackgroundColor Black
Write-Host "
Powershell Version" -ForegroundColor Green -BackgroundColor black $PSVersionTable.PSVersion | Format-Table Major -HideTableHeaders | out-host
Write-Host "
Current Windows Intelligent Security Suite Version: $VNum
Version Release Date: $VNumDate" -ForegroundColor Green -BackgroundColor Black
Write-Host "
Using $OSLocation\CCDC for file System Generation" -ForegroundColor Green -BackgroundColor Black
Write-Host "
Version $VNum Patch Notes:" -ForegroundColor Cyan -BackgroundColor Black
Write-Host "
1. User Account Killer changed to User Account
   Police and updated.

2. Local Arp Police added under Full Control
   Tools. 

3. Self Building File changed to Self 
   Building Directory.

4. Scheduled Task Police added under Full
   Control Tools.

5. View Non-Disabled, Non-System Created Tasks
   is now available under Scheduled Task Tool
"
Write-Host "
    [Q] Quit to Main Menu" -ForegroundColor Cyan -BackgroundColor Black
$PatchNotesQuit = Read-Host " "
} Until ($PatchNotesQuit -eq 'Q' )
}
<#
Delete Script Data
#>
D {
Clear
Write-Host "
===============================
      Delete Script Data       
-------------------------------" -ForegroundColor Cyan -BackgroundColor Black
Write-Host "
WARNING!!!
THIS WILL ERASE THE SCRIPT FROM THE DISC
" -ForegroundColor Red -BackgroundColor Black
Write-Host "
The Windows Intelligent Security Suite Version $VNum
will continue to run from memory

    [C] Continue and Clear Disc
    [Q] Quit to Main Menu
" -ForegroundColor Cyan -BackgroundColor Black
$ClearDisc = Read-Host " "
if ($ClearDisc -eq 'C') {
Remove-Item -LiteralPath $MyInvocation.MyCommand.Path -Force
}
Else {Break}
}

A {
Clear
Write-Host "
Password:"
$PassInput = Read-Host " "
if ($PassInput -ne "Open") {Break}
Clear
Write-Host "
Command History is being saved to $OSLocation\CCDC\CommandHistory.txt

PSReadLine is located at
"
Get-PSReadlineOption | Select-Object HistorySavePath | Out-Host
Write-Host "
    [Q] Quit to Main Menu" -ForegroundColor Cyan -BackgroundColor Black
$AdvancedQuit = Read-Host " "
if ($AdvancedQuit -eq 'Q') {Clear-History;Break}
}
}} Until ($readhost2 -eq 'Q')
}
<#
This Section is for Auto Run mode.
#>
<#
I {
Clear
Write-Host "
Now Running in Independent Mode" -ForegroundColor Cyan -BackgroundColor Black 
}
#>
}} Until ($ReadHost1 -eq 'Exit')

<#
$a = 1
do {
Test-NetConnection -ComputerName SilverLaptop -Port $a -InformationLevel Quiet
} While (($a = $a + 1) -le 5)
#>

