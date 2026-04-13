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
flowchart LR
    subgraph Host[Windows Host]
      SPL[Splunk Enterprise\nWeb:8000 Mgmt:8089\nReceiver:9997]
      VBox[VirtualBox]
    end

    subgraph Lab[Active Directory Lab (192.168.180.0/24)]
      DC[DC01\nWindows Server\n192.168.180.10]
      CL[CLIENT01\nWindows Client\n192.168.180.20]
      KA[KALI01\nAttacker Node\n192.168.180.30]
    end

    VBox --- DC
    VBox --- CL
    VBox --- KA
    DC -->|WinEventLog Security/System| SPL
    CL -->|WinEventLog Security/System| SPL
    KA -->|Attack Traffic + Validation| DC
    KA -->|Attack Traffic + Validation| CL
```

## Data Flow

1. `DC01` and `CLIENT01` generate Windows security telemetry.
2. Splunk Universal Forwarder ships events to host Splunk on port `9997`.
3. Splunk dashboards and SPL detections identify suspicious authentication behavior.
4. Attack simulation scripts emulate brute-force and valid-account activity for detection validation.
