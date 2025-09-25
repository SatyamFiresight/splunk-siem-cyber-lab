# simulate_bruteforce.ps1
# Create many failed logon attempts (EventID 4625). Run as Administrator inside VM.

param(
  [int]$Attempts = 50,
  [int]$DelayMs = 300
)

Write-Output "Running $Attempts failed login attempts (delay ${DelayMs}ms each)."

# use a safe variable name
$hostname = $env:COMPUTERNAME

for ($i=1; $i -le $Attempts; $i++) {
    # generate fake user names to vary events
    $user = "attacker$([int](Get-Random -Minimum 1 -Maximum 9999))"
    # perform a failed IPC$ connection (will produce a failed logon event)
    # suppress output
    try {
        net use \\127.0.0.1\IPC$ /user:$hostname\$user "WrongP@ssw0rd!" > $null 2>&1
        # immediately delete connection in case it succeeded (should not)
        net use \\127.0.0.1\IPC$ /delete > $null 2>&1
    } catch {}
    Start-Sleep -Milliseconds $DelayMs
}

Write-Output "Failed attempts complete."

# Optionally prompt user to create a successful local auth (4624) manually:
Write-Output ""
Write-Output "To generate a successful login (4624) for demo, either:"
Write-Output "  1) Use Switch user -> log in with a valid account, or"
Write-Output "  2) Run (interactive) 'runas /user:$env:USERNAME cmd' and enter your password."
Write-Output "Press Enter to finish."
Read-Host

