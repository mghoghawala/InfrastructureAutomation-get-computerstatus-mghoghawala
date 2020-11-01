#Your Name
#Class Period
#Description of Project

#For each command you have the following 3 lines:
#1 is a comment line in your script that provides information about what your script is doing.  Example: "1. Outputing information about installed hotfixes"
#2 is header infomration for your report file. Example: Write-Output 'Header/Title of Output' | out-file report.txt
#3 is the command itself
#Example of a single command:
#Ex1. Outputing Servcies that are running
Write-Output "#1: Outputing Services that are running" | Out-File report.txt
Get-Service | Where-Object Status -eq 'Running' | Out-File report.txt -Append

#Repeat the above 3 lines for the all of the commands project 1
