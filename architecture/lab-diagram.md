# ActiveDoom Lab Architecture

This document describes the ActiveDoom hybrid attack-and-detection lab architecture.

## Network Segment

- Lab subnet: `192.168.180.0/24`
- Splunk host listener: `192.168.180.1:9997`
- DC01: `192.168.180.10`
- CLIENT01: `192.168.180.20`
- KALI01: `192.168.180.30`

## Diagram
```mermaid
flowchart TD

subgraph HOST["Windows Host"]
    H1["VirtualBox + Splunk Enterprise"]
    H2["Splunk Web :8000"]
    H3["Splunk Mgmt :8089"]
    H4["Ingest 192.168.180.1:9997"]
end

NET["Host-only Network\n192.168.180.0/24"]

subgraph LAB["AD Lab Machines"]
    DC["DC01\n192.168.180.10\nUF → 9997"]
    CL["CLIENT01\n192.168.180.20\nUF → 9997"]
    KA["KALI01\n192.168.180.30\nAttacker"]
    NIC["Host-only NIC\n(on host)"]
end

H1 --> NET
NET --> DC
NET --> CL
NET --> KA
NET --> NIC

DC -->|Logs| H4
CL -->|Logs| H4
```

## Data Flow

1. `DC01` and `CLIENT01` generate Windows security telemetry.
2. Splunk Universal Forwarder ships events to host Splunk on port `9997`.
3. Splunk dashboards and SPL detections identify suspicious authentication behavior.
4. Attack simulation scripts emulate brute-force and valid-account activity for detection validation.
