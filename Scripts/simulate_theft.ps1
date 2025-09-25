# simulate_theft.ps1  - safe, local simulation of file-theft activity
# Run as Administrator inside VM.

# prepare paths
$sensitive = "C:\Users\Public\Documents\sensitive_data.txt"
$exfilFolder = "C:\exfil"
$logFile = "C:\Logs\security_audit.log"

# create directories
New-Item -ItemType Directory -Path (Split-Path $logFile) -Force | Out-Null
New-Item -ItemType Directory -Path $exfilFolder -Force | Out-Null

# create a dummy sensitive file (dummy data only)
"Name,SSN,Account" | Out-File -FilePath $sensitive -Encoding UTF8
"Jane Doe,000-11-2222,ACCT9999" | Out-File -FilePath $sensitive -Append -Encoding UTF8

# simulate stealthy copy (the "theft")
Start-Sleep -Seconds 1
Copy-Item -Path $sensitive -Destination $exfilFolder -Force

# write structured audit log line (easy to parse in Splunk)
$ts = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$entry = "$ts ALERT USER=satyam ACTION=EXFIL_COPY SRC=`"$sensitive`" DEST=`"$exfilFolder`" TOOL=PowerShell.exe"
$entry | Out-File -FilePath $logFile -Append -Encoding UTF8

# write a Windows Application event to make it more interesting for Splunk
if (-not [System.Diagnostics.EventLog]::SourceExists("SimTheft")){
    New-EventLog -LogName Application -Source "SimTheft"
}
Write-EventLog -LogName Application -Source "SimTheft" -EntryType Warning -EventId 9001 -Message "Sensitive file copied to exfil folder by user satyam"

