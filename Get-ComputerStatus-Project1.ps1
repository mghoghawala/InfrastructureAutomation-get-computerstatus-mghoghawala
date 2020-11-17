#Your Name - Marcela Ghoghawala
#Class Period - Fall 2020 Infrastructure Automation Online
#Description of Project - Project1

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



