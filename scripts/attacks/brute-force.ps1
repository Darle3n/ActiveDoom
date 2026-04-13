param(
    [string]$TargetHost = "\\DC01\\IPC$",
    [string]$DomainUser = "corp\\Administrator",
    [int]$Attempts = 8,
    [string]$BadPassword = "WrongPassword!123"
)

<#!
.SYNOPSIS
Safe lab-only failed authentication simulator.

.DESCRIPTION
Generates controlled failed logon attempts against a lab SMB endpoint.
This is intended to create Event ID 4625 telemetry for Splunk detection testing.
Run only in your isolated training lab.
#>

Write-Host "Starting failed login simulation against $TargetHost with user $DomainUser"

for ($i = 1; $i -le $Attempts; $i++) {
    Write-Host "Attempt $i/$Attempts"
    $cmd = "net use $TargetHost /user:$DomainUser $BadPassword"
    cmd.exe /c $cmd | Out-Null
    Start-Sleep -Milliseconds 700
}

cmd.exe /c "net use $TargetHost /delete" | Out-Null
Write-Host "Simulation complete. Validate Event ID 4625 in Splunk."
