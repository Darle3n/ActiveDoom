# ActiveDoom: Active Directory Attack & Detection Lab

## 📌 Project Overview
ActiveDoom is a cybersecurity lab project focused on performing **Active Directory Enumeration and Post-Enumeration Attacks** and detecting them using **log correlation with Splunk SIEM**.

This project demonstrates both **Red Team (Attack)** and **Blue Team (Detection)** capabilities in a controlled lab environment.

---

## 🎯 Objectives
- Simulate real-world Active Directory attacks
- Perform enumeration and privilege escalation
- Capture logs using Splunk Universal Forwarder
- Detect attacks using correlation rules
- Visualize security events in SIEM dashboards

---

## 🏗️ Architecture
```
Attacker Machine (Kali Linux)
        ↓
Active Directory Server (Windows Server)
        ↓
Log Generation (Security Events)
        ↓
Splunk Forwarder (Port 9997)
        ↓
Splunk SIEM Server
        ↓
Detection & Alerts
```

---

## 🧪 Lab Setup
- VirtualBox Environment
- Windows Server (Active Directory)
- Windows Client Machine
- Kali Linux Attacker Machine
- Splunk Enterprise (SIEM)
- Splunk Universal Forwarder

---

## ⚔️ Attacks Performed
- User Enumeration
- Network Enumeration
- Privilege Escalation
- Credential Access
- Lateral Movement

---

## 📡 Detection Strategy
- Log collection via Splunk Forwarder
- Monitoring Windows Event Logs
- Correlation Rules:
  - Multiple failed login attempts
  - Suspicious privilege changes
  - Unauthorized access patterns

---

## 📊 Key Features
- Real-time log monitoring
- Attack detection using SIEM
- Hands-on Red Team + Blue Team lab
- Structured workflow for cybersecurity learning

---

## 🚀 How to Run
1. Setup Virtual Machines
2. Configure Active Directory
3. Install Splunk Enterprise
4. Install and configure Forwarder
5. Perform attacks from attacker machine
6. Monitor logs in Splunk dashboard

---

## 📂 Project Structure
```
/ActiveDoom
 ├── report/
 ├── configs/
 ├── scripts/
 ├── screenshots/
 └── README.md
```

---

## 🔮 Future Enhancements
- Automated attack scripts
- AI-based anomaly detection
- Integration with SOAR tools
- Cloud-based AD simulation

---

## 👨‍💻 Author
Final Year Cybersecurity Project

---

## ⭐ Acknowledgment
Developed as part of final year academic project.