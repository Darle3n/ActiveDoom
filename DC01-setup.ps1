# ================================
# DC01 CONFIGURATION SCRIPT
# ================================

# VARIABLES
$IPAddress = "192.168.180.10"
$Gateway = "192.168.180.1"
$DNS = "127.0.0.1"
$Interface = "Ethernet"
$UFPath = "C:\Installers\splunkforwarder.msi"

# 1. Rename Computer
Rename-Computer -NewName "DC01" -Force

# 2. Set Static IP
New-NetIPAddress -InterfaceAlias $Interface -IPAddress $IPAddress -PrefixLength 24 -DefaultGateway $Gateway
Set-DnsClientServerAddress -InterfaceAlias $Interface -ServerAddresses $DNS

# 3. Install Splunk Universal Forwarder
Start-Process msiexec.exe -ArgumentList "/i $UFPath /quiet AGREETOLICENSE=Yes RECEIVING_INDEXER=192.168.180.1:9997" -Wait

# 4. Configure Splunk Forwarder
$SplunkPath = "C:\Program Files\SplunkUniversalForwarder\bin\splunk.exe"

& $SplunkPath start --accept-license --answer-yes --no-prompt
& $SplunkPath add forward-server 192.168.180.1:9997
& $SplunkPath add monitor WinEventLog:Security
& $SplunkPath add monitor WinEventLog:System

# 5. Enable Forwarder at Boot
& $SplunkPath enable boot-start

# 6. Restart Service
Restart-Service splunkforwarder

Write-Host "DC01 setup completed successfully"
