#Your Name - Marcela Ghoghawala
#Class Period - Fall 2020 Infrastructure Automation Online
#Description of Project - Project 1 

### !!!Script needs to be run on the c:\ drive (run first cd c:\ to make sure you are in the C:)!!! ###
$date = (Get-Date).AddDays(-1).ToString('MM-dd-yyyy')
$computername = 'WIN10-CLIENT-SERVER1-DC1'

$filename = ($computername+'-'+$date)

Write-Output "### Project1 ###" | Out-File ($filename+'.txt')
Write-Output "" | Out-File ($filename+'.txt') -Append

Write-Output "#1: Outputing Services that are running" | Out-File ($filename+'.txt') -Append
Get-Service | Where-Object Status -eq 'Running' | Out-File ($filename+'.txt') -Append

## Use One to Many:
$computername = 'WIN10-CLIENT', 'SERVER1', 'DC1'

# ---------------------------------------------------------------- #
# 1. Operation System Information - OS Name, build and version number:
# Output: #
# Name         Build                        Version Number
# ----         -----                        --------------
# WIN10-CLIENT {17763, Multiprocessor Free} 10.0.17763

# SERVER1      {14393, Multiprocessor Free} 10.0.14393

# DC1          {14393, Multiprocessor Free} 10.0.14393

# 1: #
Write-Output "#1. Operation System Information - OS Name, build and version number:" | Out-File ($filename+'.txt') -Append

Get-CimInstance -Classname Win32_OperatingSystem -ComputerName $computername `
| Format-Table -Property `
@{label='Name';expression={$_.PSComputerName}}, `
@{label='Build';expression={$_.BuildNumber,$_.BuildType}}, `
@{label='Version Number';expression={$_.Version}} | Out-File ($filename+'.txt') -Append

# 2. Processor Information - Device ID, name and max clock speed:
# Output: #
# Device ID Name                                     Max Clock Speed
# --------- ----                                     ---------------
# CPU0      Intel(R) Xeon(R) Gold 5115 CPU @ 2.40GHz            2394
# CPU1      Intel(R) Xeon(R) Gold 5115 CPU @ 2.40GHz            2394

# CPU0      Intel(R) Xeon(R) Gold 5115 CPU @ 2.40GHz            2394
# CPU1      Intel(R) Xeon(R) Gold 5115 CPU @ 2.40GHz            2394
# CPU2      Intel(R) Xeon(R) Gold 5115 CPU @ 2.40GHz            2394
# CPU3      Intel(R) Xeon(R) Gold 5115 CPU @ 2.40GHz            2394

# CPU0      Intel(R) Xeon(R) Gold 5115 CPU @ 2.40GHz            2394
# CPU1      Intel(R) Xeon(R) Gold 5115 CPU @ 2.40GHz            2394

# 2: #
Write-Output "#2. Processor Information - Device ID, name and max clock speed:" | Out-File ($filename+'.txt') -Append

Get-CimInstance -Classname Win32_Processor -ComputerName $computername `
| Format-Table -Property `
@{label='Device ID';expression={$_.DeviceID}}, `
@{label='Name';expression={$_.Name}}, `
@{label='Max Clock Speed';expression={$_.MaxClockSpeed}} | Out-File ($filename+'.txt') -Append

# 3. IP Address Configuration - IP Address,  Subnet Mask, Default Gateway and whether system uses DHCP:
# Output: #
# IP Address                                 Subnet Mask         Default Gateway Use DHCP
# ----------                                 -----------         --------------- --------
#                                                                                    True
# {192.168.95.20, fe80::18cd:5296:5d98:454b} {255.255.255.0, 64} 192.168.95.254     False
#                                                                                   False
#                                                                                   False

#                                                                                    True
# {192.168.95.10, fe80::dd6b:bcf3:bd:ef05}   {255.255.255.0, 64} 192.168.95.254     False
#                                                                                   False
#                                                                                   False

#                                                                                    True
#                                                                                   False
#                                                                                   False
#                                                                                   False
#                                                                                   False
#                                                                                   False
#                                                                                   False
#                                                                                   False
#                                                                                   False
# {192.168.95.130, fe80::ad25:ed16:6336:30f} {255.255.255.0, 64} 192.168.95.254     False

# 3: #
Write-Output "#3. IP Address Configuration - IP Address,  Subnet Mask, Default Gateway and whether system uses DHCP:" | Out-File ($filename+'.txt') -Append

Get-CimInstance -Classname Win32_NetworkAdapterConfiguration -ComputerName $computername `
| Format-Table -Property `
@{label='IP Address';expression={$_.IPAddress}}, `
@{label='Subnet Mask';expression={$_.IpSubnet}}, `
@{label='Default Gateway';expression={$_.DefaultIPGateway}}, `
@{label='Use DHCP';expression={$_.DHCPEnabled}} | Out-File ($filename+'.txt') -Append

# 4. DNS Client Server Address - Output only from the DNS Client Server IP Address:
# Output: #
# DNS Client Server Address
# -------------------------
# {4.2.2.1, 8.8.8.8}

# {192.168.95.10, 4.2.2.1}

# {192.168.95.10, 4.2.2.1}

# 4: #
Write-Output "#4. DNS Client Server Address - Output only from the DNS Client Server IP Address:" | Out-File ($filename+'.txt') -Append

Get-CimInstance -Classname Win32_NetworkAdapterConfiguration -ComputerName $computername `
| Format-Table -Property `
@{label='DNS Client Server Address';expression={$_.DNSServerSearchOrder}} | Out-File ($filename+'.txt') -Append

# 5. System Memory in GB:
# Output: #
# System Memory in GB
# -------------------
#    3.99894332885742

#    5.99956130981445

#    3.99894332885742

# 5: #
Write-Output "#5. System Memory in GB:" | Out-File ($filename+'.txt') -Append

Get-CimInstance -Classname Win32_ComputerSystem -ComputerName $computername `
| Format-Table -Property `
@{label='System Memory in GB';expression={$_.TotalPhysicalMemory / 1GB}} | Out-File ($filename+'.txt') -Append

# 6. Amount of free space in GB for the c:\ drive :
# Output: #
# Free Space in GB - C:
# ---------------------
#      35.4798049926758

#      59.0340385437012

#      35.4604568481445

# 6: #
Write-Output "#6. Amount of free space in GB for the c:\ drive:" | Out-File ($filename+'.txt') -Append

Get-CimInstance -Classname Win32_LogicalDisk -ComputerName $computername `
-Filter "DeviceID='C:'"| Format-Table -Property `
@{label='Free Space in GB - C:';expression={$_.FreeSpace / 1GB}} | Out-File ($filename+'.txt') -Append

# 7. Last bootup date and time - Output computer's name and last bootup time:
# Output: #
# Computer Name Last Bootup Time
# ------------- ----------------
# DC1           11/15/2020 2:25:27 AM

# SERVER1       11/15/2020 2:25:27 AM

# WIN10-CLIENT  11/15/2020 2:25:26 AM

# 7: #
Write-Output "#7. Last bootup date and time - Output computer's name and last bootup time:" | Out-File ($filename+'.txt') -Append

Get-CimInstance -Classname Win32_OperatingSystem -ComputerName $computername `
| Select-Object -Property `
@{label='Computer Name';expression={$_.CSName}}, `
@{label='Last Bootup Time';expression={$_.LastBootUpTime}} | Out-File ($filename+'.txt') -Append

# 8. Last user login date and time - Output user name and the last boot time:
# Output: #
# User Name                                 Last Boot Time
# ---------                                 --------------
# C:\Users\Administrator                    10/24/2020 5:49:06 PM  
# C:\Windows\ServiceProfiles\NetworkService 11/16/2020 12:15:12 AM 
# C:\Windows\ServiceProfiles\LocalService   11/16/2020 12:15:12 AM 
# C:\Windows\system32\config\systemprofile  11/16/2020 12:15:12 AM 

# C:\Users\Administrator                    10/17/2020 11:18:20 AM 
# C:\Users\Administrator.IALAB              11/15/2020 2:20:30 AM  
# C:\Windows\ServiceProfiles\NetworkService 11/16/2020 12:15:12 AM 
# C:\Windows\ServiceProfiles\LocalService   11/16/2020 12:15:12 AM 
# C:\Windows\system32\config\systemprofile  11/16/2020 12:15:12 AM 

# C:\Users\Administrator.WIN10-CLIENT       11/15/2020 2:20:12 AM  
# C:\Users\Administrator                    11/16/2020 12:15:12 AM 
# C:\Windows\ServiceProfiles\NetworkService 11/16/2020 12:15:12 AM 
# C:\Windows\ServiceProfiles\LocalService   11/16/2020 12:15:12 AM 
# C:\Windows\system32\config\systemprofile  11/16/2020 12:15:12 AM 

# 8: #
Write-Output "#8. Last user login date and time - Output user name and the last boot time:" | Out-File ($filename+'.txt') -Append

Get-CimInstance -Classname Win32_UserProfile -ComputerName $computername `
| Select-Object -Property `
@{label='User Name';expression={$_.LocalPath}}, `
@{label='Last Boot Time';expression={$_.LastUseTime}} | Out-File ($filename+'.txt') -Append

# 9. All user accounts on the system - Output only account name:
# Output: #
# User Accounts
# -------------
# Administrator
# Guest
# krbtgt
# DefaultAccount
# mscott
# pbeesly
# jhalpert
# Administrator
# DefaultAccount
# Guest

# Administrator
# DefaultAccount
# Guest

# WDAGUtilityAccount
# Administrator
# Guest
# krbtgt
# DefaultAccount
# mscott
# pbeesly
# jhalpert

# 9: #
Write-Output "#9. All user accounts on the system - Output only account name:" | Out-File ($filename+'.txt') -Append

Get-CimInstance -Classname Win32_UserAccount -ComputerName $computername `
| Format-Table -Property `
@{label='User Accounts';expression={$_.Name}} | Out-File ($filename+'.txt') -Append

# 10. Installed hotfixes - Output only hotfix ID:
# Output: #
# Hotfix ID
# ---------
# KB4580422
# KB4470788
# KB4487038
# KB4494174
# KB4537759
# KB4549947
# KB4558997
# KB4561600
# KB4566424
# KB4570332
# KB4577667
# KB4580325
# KB4587735
# KB4586793

# KB4049065
# KB4494175
# KB4520724
# KB4565912
# KB4565511

# KB4049065
# KB4494175
# KB4520724
# KB4565912
# KB4565511

# 10: #
Write-Output "#10. Installed hotfixes - Output only hotfix ID:" | Out-File ($filename+'.txt') -Append

Get-CimInstance -Classname Win32_QuickFixEngineering -ComputerName $computername `
| Format-Table -Property `
@{label='Hotfix ID';expression={$_.HotFixID}} | Out-File ($filename+'.txt') -Append

# 11. All installed applications - Output only application name, vendor and version:
# Output: #
# Name                                                           Vendor                Version
# ----                                                           ------                -------
# Microsoft Visual C++ 2008 Redistributable - x64 9.0.30729.6161 Microsoft Corporation 9.0.30729.6161
# Microsoft Visual C++ 2008 Redistributable - x86 9.0.30729.6161 Microsoft Corporation 9.0.30729.6161
# Google Update Helper                                           Google LLC            1.3.36.31
# VMware Tools                                                   VMware, Inc.          10.2.5.8068406

# Microsoft Visual C++ 2019 X86 Minimum Runtime - 14.20.27508    Microsoft Corporation 14.20.27508
# Microsoft Visual C++ 2019 X64 Minimum Runtime - 14.20.27508    Microsoft Corporation 14.20.27508
# Microsoft Visual C++ 2019 X86 Additional Runtime - 14.20.27508 Microsoft Corporation 14.20.27508
# Google Update Helper                                           Google LLC            1.3.36.31
# Microsoft Visual C++ 2019 X64 Additional Runtime - 14.20.27508 Microsoft Corporation 14.20.27508
# VMware Tools                                                   VMware, Inc.          11.0.0.14549434

# Microsoft Visual C++ 2019 X86 Minimum Runtime - 14.20.27508    Microsoft Corporation 14.20.27508
# Microsoft Visual C++ 2019 X64 Minimum Runtime - 14.20.27508    Microsoft Corporation 14.20.27508
# Microsoft Visual C++ 2019 X86 Additional Runtime - 14.20.27508 Microsoft Corporation 14.20.27508
# Google Update Helper                                           Google LLC            1.3.36.31
# Microsoft Visual C++ 2019 X64 Additional Runtime - 14.20.27508 Microsoft Corporation 14.20.27508
# VMware Tools                                                   VMware, Inc.          11.0.0.14549434

# 11: #
Write-Output "#11. All installed applications - Output only application name, vendor and version:" | Out-File ($filename+'.txt') -Append

Get-CimInstance -Classname Win32_Product -ComputerName $computername `
| Format-Table -Property Name, Vendor, Version `
| Out-File ($filename+'.txt') -Append

Write-Output "Project 1 - ########################## The End ########################" | Out-File ($filename+'.txt') -Append