#Your Name - Marcela Ghoghawala
#Class Period - Fall 2020 Infrastructure Automation Online
#Description of Project - Project 1 

### Step 1 - Create Your Script ###

#For each command you have the following 3 lines:
#1 is a comment line in your script that provides information about what your script is doing.  Example: "1. Outputing information about installed hotfixes"
#2 is header infomration for your report file. Example: Write-Output 'Header/Title of Output' | out-file report.txt
#3 is the command itself
#Example of a single command:
#Ex1. Outputing Servcies that are running
# Write-Output "#1: Outputing Services that are running" | Out-File report.txt
# Get-Service | Where-Object Status -eq 'Running' | Out-File report.txt -Append

#Repeat the above 3 lines for the all of the commands project 1

#Script:

## Run the command below separated from the rest of the script to parameterize script with a computername parameter:
$computername = "WIN10-CLIENT" 

## The script below determines the Operating System information and output only the OS Name, 
##    Build (Build Number and Build Type) and the Version Number to the report file and command line.
## The script below also has the mandatory computername parameter:
Get-CimInstance -Classname Win32_OperatingSystem -ComputerName $computername `
| Format-Table -Property `
@{label='Name';expression={$_.PSComputerName}}, `
@{label='Build';expression={$_.BuildNumber,$_.BuildType}}, `
@{label='Version Number';expression={$_.Version}} 

## Adding the commands bellow to the script above will output the script to the designated file.
# | Out-File -FilePath C:\Users\Administrator\Documents\get-computerstatus-mghoghawala\Get-ComputerStatus.ps1

## Once the file is generated, the command below will generate the following output listed under #Output:
# .\Get-ComputerStatus.ps1 -host WIN10-CLIENT -Verbose


#Output:
# Name         Build                        Version Number
# ----         -----                        --------------
# WIN10-CLIENT {17763, Multiprocessor Free} 10.0.17763    

#####################################################################################

### Step 2 - Gather Information about a Windows 2016 Server ###

# 1. Operation System Information - OS Name, build and version number:

# Script: #
Get-CimInstance -Classname Win32_OperatingSystem -ComputerName SERVER1 `
| Format-Table -Property `
@{label='Name';expression={$_.PSComputerName}}, `
@{label='Build';expression={$_.BuildNumber,$_.BuildType}}, `
@{label='Version Number';expression={$_.Version}} 

# Output: #
# Name    Build                        Version Number
# ----    -----                        --------------
# SERVER1 {14393, Multiprocessor Free} 10.0.14393

# 2. Processor Information - Device ID, name and max clock speed:
# Script: #
Get-CimInstance -Classname Win32_Processor -ComputerName SERVER1 `
| Format-Table -Property `
@{label='Device ID';expression={$_.DeviceID}}, `
@{label='Name';expression={$_.Name}}, `
@{label='Max Clock Speed';expression={$_.MaxClockSpeed}} 

# Output: #
# Device ID Name                                     Max Clock Speed
# --------- ----                                     ---------------
# CPU0      Intel(R) Xeon(R) Gold 5115 CPU @ 2.40GHz            2394
# CPU1      Intel(R) Xeon(R) Gold 5115 CPU @ 2.40GHz            2394
# CPU2      Intel(R) Xeon(R) Gold 5115 CPU @ 2.40GHz            2394
# CPU3      Intel(R) Xeon(R) Gold 5115 CPU @ 2.40GHz            2394

# 3. IP Address Configuration - IP Address,  Subnet Mask, Default Gateway and whether system uses DHCP:
# Script: #
Get-CimInstance -Classname Win32_NetworkAdapterConfiguration -ComputerName SERVER1 `
| Format-Table -Property `
@{label='IP Address';expression={$_.IPAddress}}, `
@{label='Subnet Mask';expression={$_.IpSubnet}}, `
@{label='Default Gateway';expression={$_.DefaultIPGateway}}, `
@{label='Use DHCP';expression={$_.DHCPEnabled}}

# Output: #
# IP Address                                 Subnet Mask         Default Gateway Use DHCP
# ----------                                 -----------         --------------- --------
#                                                                                    True
# {192.168.95.20, fe80::18cd:5296:5d98:454b} {255.255.255.0, 64} 192.168.95.254     False
#                                                                                   False
#                                                                                   False

# 4. DNS Client Server Address - Output only from the DNS Client Server IP Address:
# Script: #
Get-CimInstance -Classname Win32_NetworkAdapterConfiguration -ComputerName SERVER1 `
| Format-Table -Property `
@{label='DNS Client Server Address';expression={$_.DNSServerSearchOrder}}

# Output: #
# DNS Client Server Address
# -------------------------

# {192.168.95.10, 4.2.2.1}

# 5. System Memory in GB:
# Script: #
Get-CimInstance -Classname Win32_ComputerSystem -ComputerName SERVER1 `
| Format-Table -Property `
@{label='System Memory in GB';expression={$_.TotalPhysicalMemory / 1GB}}

# Output: #
# System Memory in GB
# -------------------
#    3.99894332885742

# 6. Amount of free space in GB for the c:\ drive :
# Script: #
Get-CimInstance -Classname Win32_LogicalDisk -ComputerName SERVER1 `
-Filter "DeviceID='C:'"| Format-Table -Property `
@{label='Free Space in GB - C:';expression={$_.FreeSpace / 1GB}}

# Output: #
# Free Space in GB - C:
# ----------------------
#      35.4931755065918

# 7. Last bootup date and time - Output computer's name and last bootup time:
# Script: #
Get-CimInstance -Classname Win32_OperatingSystem -ComputerName SERVER1 `
 | Select -Property `
 @{label='Computer Name';expression={$_.CSName}}, `
 @{label='Last Bootup Time';expression={$_.LastBootUpTime}}

# Output: #
# Computer Name Last Bootup Time
# ------------- ----------------
# SERVER1       11/14/2020 9:44:02 PM

# 8. Last user login date and time - Output user name and the last boot time:
# Script: #
# # Get-CimInstance -Classname Win32_UserAccount -ComputerName SERVER1 `
# # | Format-Table -Property `
# # @{label='User Name';expression={$_.Name}}, `

# Output: #
# # PS C:\Users\Administrator> Get-CimInstance -Classname Win32_UserAccount -ComputerName SERVER1 `
# # >> | Format-Table -Property `
# # >> @{label='User Name';expression={$_.Name}}, `
# # >> @{label='Last Boot Time';expression={$_.LastUseTime}}


# # User Name      Last Boot Time
# # ---------      --------------
# # Administrator
# # DefaultAccount
# # Guest

 Get-CimInstance -Classname Win32_UserAccount -ComputerName SERVER1 `
 | Format-Table -Property `
 @{label='User Name';expression={$_.Name}}, `
 @{label='Last Boot Time';expression={(Get-CimInstance -Classname Win32_UserProfile -ComputerName Server1 | FT -Property $_.LastUseTime)}}


# # User Name      Last Boot Time
# # ---------      --------------
# # Administrator  {Microsoft.PowerShell.Commands.Internal.Format.FormatStartData, Microsoft.PowerShell.Commands.Int...
# # DefaultAccount {Microsoft.PowerShell.Commands.Internal.Format.FormatStartData, Microsoft.PowerShell.Commands.Int...
# # Guest          {Microsoft.PowerShell.Commands.Internal.Format.FormatStartData, Microsoft.PowerShell.Commands.Int...

# 9. All user accounts on the system - Output only account name:
# Script: #
Get-CimInstance -Classname Win32_UserAccount -ComputerName SERVER1 `
| Format-Table -Property `
@{label='User Accounts';expression={$_.Name}}

# Output: #
# User Accounts
# -------------
# Administrator
# DefaultAccount
# Guest

# 10. Installed hotfixes - Output only hotfix ID:
# Script: #
Get-CimInstance -Classname Win32_QuickFixEngineering -ComputerName SERVER1 `
| Format-Table -Property `
@{label='Hotfix ID';expression={$_.HotFixID}}

# Output: #
# Hotfix ID
# ---------
# KB4049065
# KB4494175
# KB4520724
# KB4565912
# KB4565511

# 11. All installed applications - Output only application name, vendor and version:
# Script: #
Get-CimInstance -Classname Win32_Product -ComputerName Server1 `
| Format-Table -Property Name, Vendor, Version

# Output: #
# Name                                                           Vendor                Version
# ----                                                           ------                -------
# Microsoft Visual C++ 2019 X86 Minimum Runtime - 14.20.27508    Microsoft Corporation 14.20.27508
# Microsoft Visual C++ 2019 X64 Minimum Runtime - 14.20.27508    Microsoft Corporation 14.20.27508
# Microsoft Visual C++ 2019 X86 Additional Runtime - 14.20.27508 Microsoft Corporation 14.20.27508
# Google Update Helper                                           Google LLC            1.3.36.31
# Microsoft Visual C++ 2019 X64 Additional Runtime - 14.20.27508 Microsoft Corporation 14.20.27508
# VMware Tools                                                   VMware, Inc.          11.0.0.14549434

#############################################################################################

### Step 3 - Convert Your Commands to Run Remotely ###

# *** Run the Parameter command before running the rest of the script! *** #
# Parameter:

## Use One to One: 
$computername = 'SERVER1'

## OR

## Use One to Many:
$computername = 'WIN10-CLIENT', 'SERVER1', 'DC1'

# ---------------------------------------------------------------- #
# 1. Operation System Information - OS Name, build and version number:

# Script: #
Get-CimInstance -Classname Win32_OperatingSystem -ComputerName $computername `
| Format-Table -Property `
@{label='Name';expression={$_.PSComputerName}}, `
@{label='Build';expression={$_.BuildNumber,$_.BuildType}}, `
@{label='Version Number';expression={$_.Version}} 

# Output: #
# Name         Build                        Version Number
# ----         -----                        --------------
# WIN10-CLIENT {17763, Multiprocessor Free} 10.0.17763

# SERVER1      {14393, Multiprocessor Free} 10.0.14393

# DC1          {14393, Multiprocessor Free} 10.0.14393

# 2. Processor Information - Device ID, name and max clock speed:
# Script: #
Get-CimInstance -Classname Win32_Processor -ComputerName $computername `
| Format-Table -Property `
@{label='Device ID';expression={$_.DeviceID}}, `
@{label='Name';expression={$_.Name}}, `
@{label='Max Clock Speed';expression={$_.MaxClockSpeed}} 

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

# 3. IP Address Configuration - IP Address,  Subnet Mask, Default Gateway and whether system uses DHCP:
# Script: #
Get-CimInstance -Classname Win32_NetworkAdapterConfiguration -ComputerName $computername `
| Format-Table -Property `
@{label='IP Address';expression={$_.IPAddress}}, `
@{label='Subnet Mask';expression={$_.IpSubnet}}, `
@{label='Default Gateway';expression={$_.DefaultIPGateway}}, `
@{label='Use DHCP';expression={$_.DHCPEnabled}}

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

# 4. DNS Client Server Address - Output only from the DNS Client Server IP Address:
# Script: #
Get-CimInstance -Classname Win32_NetworkAdapterConfiguration -ComputerName $computername `
| Format-Table -Property `
@{label='DNS Client Server Address';expression={$_.DNSServerSearchOrder}}

# Output: #
# DNS Client Server Address
# -------------------------
# {4.2.2.1, 8.8.8.8}

# {192.168.95.10, 4.2.2.1}

# {192.168.95.10, 4.2.2.1}


# 5. System Memory in GB:
# Script: #
Get-CimInstance -Classname Win32_ComputerSystem -ComputerName $computername `
| Format-Table -Property `
@{label='System Memory in GB';expression={$_.TotalPhysicalMemory / 1GB}}

# Output: #
# System Memory in GB
# -------------------
#    3.99894332885742

#    5.99956130981445

#    3.99894332885742

# 6. Amount of free space in GB for the c:\ drive :
# Script: #
Get-CimInstance -Classname Win32_LogicalDisk -ComputerName $computername `
-Filter "DeviceID='C:'"| Format-Table -Property `
@{label='Free Space in GB - C:';expression={$_.FreeSpace / 1GB}}

# Output: #
# Free Space in GB - C:
# ---------------------
#      35.4798049926758

#      59.0340385437012

#      35.4604568481445

# 7. Last bootup date and time - Output computer's name and last bootup time:
# Script: #
Get-CimInstance -Classname Win32_OperatingSystem -ComputerName $computername `
| Select -Property `
@{label='Computer Name';expression={$_.CSName}}, `
@{label='Last Bootup Time';expression={$_.LastBootUpTime}}

# Output: #
# Computer Name Last Bootup Time
# ------------- ----------------
# DC1           11/15/2020 2:25:27 AM

# SERVER1       11/15/2020 2:25:27 AM

# WIN10-CLIENT  11/15/2020 2:25:26 AM

# 8. Last user login date and time - Output user name and the last boot time:
# Script: #
# # Get-CimInstance -Classname Win32_UserAccount -ComputerName $computername `
# # | Format-Table -Property `
# # @{label='User Name';expression={$_.Name}}, `

# Output: #
Get-CimInstance -Classname Win32_UserAccount -ComputerName SERVER1 `
| Format-Table -Property `
@{label='User Name';expression={$_.Name}}, `
@{label='Last Boot Time';expression={$_.LastUseTime}}


# # User Name      Last Boot Time
# # ---------      --------------
# # Administrator
# # DefaultAccount
# # Guest


# # PS C:\Users\Administrator> Get-CimInstance -Classname Win32_UserAccount -ComputerName SERVER1 `
# # >> | Format-Table -Property `
# # >> @{label='User Name';expression={$_.Name}}, `
# # >> @{label='Last Boot Time';expression={(Get-CimInstance -Classname Win32_UserProfile -ComputerName Server1 | FT -Property $_.LastUseTime)}}


# # User Name      Last Boot Time
# # ---------      --------------
# # Administrator  {Microsoft.PowerShell.Commands.Internal.Format.FormatStartData, Microsoft.PowerShell.Commands.Int...
# # DefaultAccount {Microsoft.PowerShell.Commands.Internal.Format.FormatStartData, Microsoft.PowerShell.Commands.Int...
# # Guest          {Microsoft.PowerShell.Commands.Internal.Format.FormatStartData, Microsoft.PowerShell.Commands.Int...

# 9. All user accounts on the system - Output only account name:
# Script: #
Get-CimInstance -Classname Win32_UserAccount -ComputerName $computername `
| Format-Table -Property `
@{label='User Accounts';expression={$_.Name}}

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

# 10. Installed hotfixes - Output only hotfix ID:
# Script: #
Get-CimInstance -Classname Win32_QuickFixEngineering -ComputerName $computername `
| Format-Table -Property `
@{label='Hotfix ID';expression={$_.HotFixID}}

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

# 11. All installed applications - Output only application name, vendor and version:
# Script: #
Get-CimInstance -Classname Win32_Product -ComputerName $computername `
| Format-Table -Property Name, Vendor, Version

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


