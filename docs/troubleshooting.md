# ActiveDoom Troubleshooting

## Splunk Port 9997 Not Listening

Symptoms:
- Forwarders cannot connect
- No incoming events

Checks:

```powershell
netstat -ano | findstr :9997
```

Actions:
- In Splunk Web, enable receiving on port `9997`
- Confirm Windows Firewall allows inbound `9997`
- Restart Splunk service

## Universal Forwarder Not Running

Symptoms:
- No logs from `DC01` or `CLIENT01`

Checks:

```powershell
Get-Service splunkforwarder
```

Actions:
- Start service: `Start-Service splunkforwarder`
- Re-run setup scripts if binary/config is missing
- Validate `outputs.conf` target (`192.168.180.1:9997`)

## Log Ingestion Failure in Splunk

Symptoms:
- Searches for `WinEventLog:Security` return no results

Checks:

```spl
index=main sourcetype=WinEventLog:Security
| head 20
```

Actions:
- Confirm forwarder inputs include Security log
- Verify time synchronization across host and VMs
- Check index assignment and retention in Splunk

## Domain Join or Authentication Failures

Symptoms:
- `CLIENT01` cannot join `corp.local`
- Authentication tests fail unexpectedly

Checks:
- DNS on `CLIENT01` points to `192.168.180.10`
- `DC01` reachable on host-only network
- Time skew between systems is minimal

Actions:
- Reapply static IP and DNS settings
- Validate AD DS services on `DC01`
- Retry join with known-good credentials

## Detection Query Returns No Brute-force Hits

Symptoms:
- 4625 events exist but brute-force SPL returns empty results

Actions:
- Increase simulation attempts (`-Attempts 10` or higher)
- Expand search time window in Splunk
- Lower threshold in aggregation query from `>= 5` to `>= 3` for testing
