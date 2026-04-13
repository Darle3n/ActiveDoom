# ActiveDoom Setup Guide

## 1. Prerequisites

- Windows host with VirtualBox installed
- 3 VMs: `DC01`, `CLIENT01`, `KALI01`
- Splunk Enterprise on host
- Splunk Universal Forwarder installer at `C:\Installers\splunkforwarder.msi`
- Host-only network: `192.168.180.0/24`

## 2. Network Plan

- Host/Splunk receiver: `192.168.180.1:9997`
- `DC01`: `192.168.180.10`
- `CLIENT01`: `192.168.180.20`
- `KALI01`: `192.168.180.30`

## 3. Configure Splunk Receiver

1. Open Splunk Web (`http://localhost:8000`).
2. Go to `Settings > Forwarding and Receiving`.
3. Click `Configure receiving`.
4. Add port `9997`.
5. Verify listener with:

```spl
index=_internal splunkd "TcpInputProc" 9997
```

## 4. Configure DC01

1. Copy `scripts/setup/DC01-setup.ps1` to `DC01`.
2. Run in elevated PowerShell:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
.\DC01-setup.ps1
```

3. Reboot when prompted.

## 5. Configure CLIENT01

1. Copy `scripts/setup/CLIENT01-setup.ps1` to `CLIENT01`.
2. Run in elevated PowerShell:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
.\CLIENT01-setup.ps1
```

3. Ensure domain join to `corp.local` succeeds.

## 6. Validate Log Ingestion

Run in Splunk:

```spl
index=main sourcetype=WinEventLog:Security (EventCode=4624 OR EventCode=4625)
| stats count by host EventCode
```

If events are visible for both hosts, telemetry pipeline is healthy.

## 7. Run Attack Simulations

From `CLIENT01` (or a designated simulation node):

Failed logins:

```powershell
.\scripts\attacks\brute-force.ps1 -TargetHost "\\DC01\\IPC$" -DomainUser "corp\Administrator" -Attempts 10
```

Successful logins:

```powershell
.\scripts\attacks\login-simulation.ps1 -TargetHost "\\DC01\\IPC$" -DomainUser "corp\Administrator" -Password "Password@1234" -Count 5
```

## 8. Run Detection Queries

Use `splunk/queries/detection-queries.spl` in Search & Reporting to validate detections.
