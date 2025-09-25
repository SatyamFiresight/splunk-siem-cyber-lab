# simulate_filedrop.ps1
# Simulate a suspicious file drop + a log + application event
# Run as Administrator inside VM.

# paths
$dropName = "suspicious_tool.exe"
$source = "C:\Users\Public\Documents\$dropName"
$destFolder = "C:\Windows\Temp"
$dest = Join-Path $destFolder $dropName
$logFile = "C:\Logs\malware_audit.log"

# create directories
New-Item -ItemType Directory -Path (Split-Path $logFile) -Force | Out-Null
New-Item -ItemType Directory -Path $destFolder -Force | Out-Null

# create dummy executable (zero-byte or small text file renamed .exe)
"REM dummy binary for demo" | Out-File -FilePath $source -Encoding ASCII

# copy to dest (simulate drop)
Copy-Item -Path $source -Destination $dest -Force

# write structured log entry
$ts = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$entry = "$ts ALERT USER=$env:USERNAME ACTION=FILE_DROP FILE=`"$dest`" HASH=DEADBEEF TOOL=Copy"
$entry | Out-File -FilePath $logFile -Append -Encoding UTF8

# create an Application event
if (-not [System.Diagnostics.EventLog]::SourceExists("SimMalware")) {
    New-EventLog -LogName Application -Source "SimMalware"
}
Write-EventLog -LogName Application -Source "SimMalware" -EntryType Warning -EventId 9100 -Message "Suspicious file dropped: $dest"
Write-Output "Dropped $dest and logged to $logFile and Application event 9100."

