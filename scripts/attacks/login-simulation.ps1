param(
    [string]$TargetHost = "\\DC01\\IPC$",
    [string]$DomainUser = "corp\\Administrator",
    [Parameter(Mandatory = $true)]
    [string]$Password,
    [int]$Count = 3
)

<#!
.SYNOPSIS
Safe lab-only successful authentication simulator.

.DESCRIPTION
Generates controlled successful logon events to create Event ID 4624 telemetry.
Run only in your isolated training lab.
#>

Write-Host "Starting successful login simulation against $TargetHost with user $DomainUser"

for ($i = 1; $i -le $Count; $i++) {
    Write-Host "Successful auth simulation $i/$Count"
    $cmd = "net use $TargetHost /user:$DomainUser $Password"
    cmd.exe /c $cmd | Out-Null
    Start-Sleep -Milliseconds 700
    cmd.exe /c "net use $TargetHost /delete" | Out-Null
}

Write-Host "Simulation complete. Validate Event ID 4624 in Splunk."
