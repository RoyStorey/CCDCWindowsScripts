$CurrentOSVersion = (
get-itemproperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion" -Name ProductName
).ProductName
if ($CurrentOSVersion -eq 'Windows Server 2003') {Write-Host "
The current Version of the Network
Monitoring Tool does not support $CurrentOSVersion
Please check newer editions of the Windows Intelligent Security Suite
for support of your Version of Windows." -ForegroundColor Red -BackgroundColor Black
}
do {
clear
Write-Host "
=====================================
       Network Monitoring Tool       
-------------------------------------
    [1] Start Monitoring Connections
    [2] Display Network Information
    [3] Change Local IPAddress
    [Q] Quit to Main Menu" -ForegroundColor Cyan -BackgroundColor Black
    $NetMonQuit = Read-Host " "
    Switch ($NetMonQuit)
    {
    1 { do {
    Clear
Write-Host "
=====================================
       Network Monitoring Tool       
-------------------------------------
How many connections do you want to monitor?
    [1] A Single Connection
    [2] Two Seperate Connections
    [3] Three Seperate Connections
    [4] Four Seperate Connections
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
    $ConnectionNum = Read-Host " "
    Switch ($ConnectionNum) {

    1 {
    clear
Write-Host "
=====================================
       Network Monitoring Tool       
-------------------------------------
    What is the IP of the connection you would like to Monitor?
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
    $Input2ndIPAddress = Read-Host " "
   if ($Input2ndIPAddress -eq 'Q') {Break}
   do { 
$test = Test-Connection  $Input2ndIPAddress -Count 10 -delay 2 -erroraction inquire
$TimeStamp = Get-Date -Format 'H:mm:ss'
Write-Host "
Test Completed at $TimeStamp" -ForegroundColor Cyan -BackgroundColor Black
if  ( $test -ne $false) {
Write-Host "Good Connection To $Input2ndIPAddress" -ForegroundColor Green -BackgroundColor Black
}} Until ($test -eq $false); if ($test -eq $false) {
 $PopupAlert1 = New-Object -ComObject Wscript.Shell

$PopupAlert1.Popup("
UNABLE TO CONNECT TO $Input2ndIPAddress",0,"ALERT!!!",0x1)

 
}
}

    2 { 
 clear
Write-Host "
=====================================
       Network Monitoring Tool       
-------------------------------------
    What is the IP Address of the first connection you would like to Monitor?
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
    $Input2ndIPAddress = Read-Host " "
if ($Input2ndIPAddress -eq 'Q') {Break}
  Write-Host "
  What is the IP Address of the Second connection you would like to Monitor?
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
  $Input3rdIPAddress = Read-Host " "
if ($Input3rdIPAddress -eq 'Q') {Break}
 do { 
$test = Test-Connection  $Input2ndIPAddress -Count 10 -delay 2 -erroraction inquire
$test2 = Test-Connection  $Input3rdIPAddress -Count 10 -delay 2 -erroraction inquire
$TimeStamp = Get-Date -Format 'H:mm:ss'
Write-Host "
Test Completed at $TimeStamp" -ForegroundColor Cyan -BackgroundColor Black
if  ( $test -ne $false) {
Write-Host "Good Connection To $Input2ndIPAddress" -ForegroundColor Green -BackgroundColor Black
}
if  ( $test2 -ne $false) {
Write-Host "Good Connection To $Input3rdIPAddress" -ForegroundColor Green -BackgroundColor Black
}
} Until ($Input2ndIPAddress -eq 'Q' -or $Input3rdIPAddress -eq 'Q') 
    }
   
    3 {
    clear
Write-Host "
=====================================
       Network Monitoring Tool       
-------------------------------------
    What is the IP Address of the first connection you would like to Monitor?
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
    $Input2ndIPAddress = Read-Host " "
  if ($Input2ndIPAddress -eq 'Q') {Break}
  Write-Host "
  What is the IP Address of the Second connection you would like to Monitor?
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
  $Input3rdIPAddress = Read-Host " "
  if ($Input3rdIPAddress -eq 'Q') {Break}
  Write-Host "
  What is the IP Address of the Third connection you would like to Monitor?
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
  $Input4thIPAddress = Read-Host
  if ($Input4thIPAddress -eq 'Q') {Break}
   do { 
$test = Test-Connection  $Input2ndIPAddress -Count 10 -delay 2 -erroraction inquire
$test2 = Test-Connection  $Input3rdIPAddress -Count 10 -delay 2 -erroraction inquire
$test3 = Test-Connection  $Input4thIPAddress -Count 10 -delay 2 -erroraction inquire
$TimeStamp = Get-Date -Format 'H:mm:ss'
Write-Host "
Test Completed at $TimeStamp" -ForegroundColor Cyan -BackgroundColor Black
if  ( $test -ne $false) {

Write-Host "Good Connection To $Input2ndIPAddress" -ForegroundColor Green -BackgroundColor Black
}
if  ( $test2 -ne $false) {

Write-Host "Good Connection To $Input3rdIPAddress" -ForegroundColor Green -BackgroundColor Black
}
if  ( $test3 -ne $false) {

Write-Host "Good Connection To $Input4thIPAddress" -ForegroundColor Green -BackgroundColor Black
}
} Until ($Input2ndIPAddress -eq 'Q' -or $Input3rdIPAddress -eq 'Q' -or $Input4thIpAddress -eq 'Q') 
    }
       
    4 {
    clear
Write-Host "
=====================================
       Network Monitoring Tool       
-------------------------------------
    What is the IP Address of the first connection you would like to Monitor?
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
    $Input2ndIPAddress = Read-Host " "
    if ($Input2ndIPAddress -eq 'Q') {Break}
  Write-Host "
  What is the IP Address of the Second connection you would like to Monitor?
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
  $Input3rdIPAddress = Read-Host " "
  if ($Input3rdIPAddress -eq 'Q') {Break}
  Write-Host "
  What is the IP Address of the Third connection you would like to Monitor?
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
  $Input4thIPAddress = Read-Host " "
  if ($Input4thIPAddress -eq 'Q') {Break}
  Write-Host "
  What is the IP Address of the Fourth connection you would like to Monitor?
    [Q] Quit to Previous Menu" -ForegroundColor Cyan -BackgroundColor Black
  $Input5thIPAddress = Read-Host " "
  if ($Input5thIPAddress -eq 'Q') {Break}
   do { 
$test = Test-Connection  $Input2ndIPAddress -Count 10 -delay 2 -erroraction inquire
$test2 = Test-Connection  $Input3rdIPAddress -Count 10 -delay 2 -erroraction inquire
$test3 = Test-Connection  $Input4thIPAddress -Count 10 -delay 2 -erroraction inquire
$test4 = Test-Connection  $Input5thIPAddress -Count 10 -delay 2 -erroraction inquire
$TimeStamp = Get-Date -Format 'H:mm:ss'
Write-Host "
Test Completed at $TimeStamp" -ForegroundColor Cyan -BackgroundColor Black
if  ( $test -ne $false) {

Write-Host "Good Connection To $Input2ndIPAddress" -ForegroundColor Green -BackgroundColor Black
}
if  ( $test2 -ne $false) {

Write-Host "Good Connection To $Input3rdIPAddress" -ForegroundColor Green -BackgroundColor Black
}
if  ( $test3 -ne $false) {

Write-Host "Good Connection To $Input4thIPAddress" -ForegroundColor Green -BackgroundColor Black
}
if  ( $test4 -ne $false) {

Write-Host "Good Connection To $Input5thIPAddress" -ForegroundColor Green -BackgroundColor Black
}
} Until ($Input2ndIPAddress -eq 'Q' -or $Input3rdIPAddress -eq 'Q' -or $Input4thIpAddress -eq 'Q' -or $Input5thIPAddress -eq 'Q') 
    }
    
    }} Until ($ConnectionNum -eq 'Q') 

    }
    2 { do {
Clear
Write-Host "
=====================================
       Network Monitoring Tool       
-------------------------------------" -ForegroundColor Cyan -BackgroundColor Black
Get-NetIPConfiguration | Out-Host
Write-Host "
    [Q] Quit to Main Menu" -ForegroundColor Cyan -BackgroundColor Black
    $NetInfoQuit = Read-Host " "
    } Until ($NetInfoQuit -eq 'Q') }

    3 { do {
    Clear
Write-Host "
=====================================
       Network Monitoring Tool       
-------------------------------------" -ForegroundColor Cyan -BackgroundColor Black
    Write-Host "
What is the alias of the network card you would like to configure?
    [Q] Quit to Main Menu" -ForegroundColor Cyan -BackgroundColor Black
   $NetworkAlias = Read-Host " "
   if ($NetworkAlias -eq 'Q') {Break}
   Write-Host "
What IP address would you like for this network card?
    [Q] Quit to Main Menu" -ForegroundColor Cyan -BackgroundColor Black
   $NewIP = Read-Host " "
   if ($NewIP -eq 'Q') {Break}
   Write-Host "
What do you want for network prefix length 8, 16, 24?
    [Q] Quit to Main Menu" -ForegroundColor Cyan -BackgroundColor Black
   $PrefixInput = Read-Host " "
   if ($PrefixInput -eq 'Q') {Break}
   Write-Host "
What address do you want the default gateway to be set to?
    [Q] Quit to Main Menu" -ForegroundColor Cyan -BackgroundColor Black
   $GWInput = Read-Host " "
   if ($GWInput -eq 'Q') {Break}
    New-NetIPAddress -InterfaceAlias $NetworkAlias -IpAddress $NewIP -PrefixLength $PrefixInput -DefaultGateway $GWInput
    Clear
    Write-Host "
Now Displaying New configuration" 
    Get-NetIPConfiguration | Out-Host
    Write-Host "
[Q] Quit to Main Menu" -ForegroundColor Cyan -BackgroundColor Black
$IPChangeQuit = Read-Host " "
    } Until ($IPChangeQuit -eq 'Q')}

    }} Until ($NetMonQuit -eq 'Q') 


