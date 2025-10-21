
# 🧠 Task #17: Resource Monitoring, Alerting, and Log Management Automation

## 📌 Objective

This project automates **system resource monitoring**, **email alerting**, and **log management** using Bash scripts and cron jobs.  
It helps system administrators proactively track CPU, memory, disk usage, and manage growing log files efficiently.

---

## ⚙️ Components Overview

### 1️⃣ Resource Monitoring & Alert System (`resource_monitor.sh`)

**Purpose:**  
Continuously monitor key system resources and send **email alerts** when usage exceeds defined thresholds.

**Monitored Parameters:**
- CPU usage
- Memory (RAM) usage
- Disk usage
- System load average

**Alert Triggers (default thresholds):**
| Resource | Threshold |
|-----------|------------|
| CPU | > 80% |
| Memory | > 75% |
| Disk | > 85% |

**Alert Email Includes:**
- Hostname  
- Timestamp  
- Current usage summary  
- System load average  

---

### 2️⃣ Log Management & Backup System (`log_backup.sh`)

**Purpose:**  
Automate the process of backing up and cleaning up old logs to maintain a healthy log storage environment.

**Actions Performed:**
- Identify logs older than 7 days from `/var/logs/checkins/`
- Compress them using `tar.gz`
- Move the compressed backups to `/backup/logs/`
- Delete the original old logs
- Maintain an activity log at `/var/log/log_backup.log`

---

## 📂 Directory Structure

strapi-17/  
├── resource_monitor.sh   # System resource monitoring and alert script  
├── log_backup.sh             # Log backup and cleanup script  
├── README.md                # Documentation

---

## ⚡ Setup & Configuration

### Step 1: Update Email Settings
Edit `resource_monitor.sh` and replace the email variable with your admin email:
```bash
EMAIL="admin@example.com"
```

### Step 2: Give Execute Permissions
```
chmod +x resource_monitor.sh
chmod +x log_backup.sh
```

### Step 3: Verify Dependencies

Ensure the following tools are installed:
```
sudo apt install mailx tar gzip -y
```

### Step 4: Create Required Directories
```
sudo mkdir -p /var/logs/checkins /backup/logs
```

---

## 🕒 Automate with Cron Jobs

### Resource Monitoring (every 10 minutes)

```
*/10 * * * * /path/to/resource_monitor.sh
```

### Log Backup (daily at 2 AM)

```
0 2 * * * /path/to/log_backup.sh
```

## To edit cron jobs:

```
crontab -e
```

---

## 📧 Sample Email Alert

```
Subject: System Resource Alert on server1

Resource Alert on server1 - 2025-10-21 11:30:00

CPU Usage: 85% (Threshold: 80%)
Memory Usage: 78% (Threshold: 75%)
Disk Usage: 90% (Threshold: 85%)
System Load Average (1 min): 2.15
```

---

## 🗂️ Sample Log Entry (`/var/log/log_backup.log`)

```
[2025-10-21 02:00:01] Backup and deleted: /var/logs/checkins/checkin_20251014.log -> /backup/logs/checkin_20251014.log_2025-10-21_02-00-01.tar.gz
```

---

## ✅ Deliverables

| File                  | Description                                  |
| --------------------- | -------------------------------------------- |
| `resource_monitor.sh` | Monitors CPU, Memory, Disk and sends alerts  |
| `log_backup.sh`       | Backs up and deletes logs older than 7 days  |
| `README.md`           | Project documentation and setup instructions |
| `crontab entries`     | Scheduling automation                        |

---

## 🧩 Future Enhancements

- Add Slack or Teams webhook alerts
    
- Include network I/O monitoring
    
- Integrate system metrics into Grafana dashboards
    
- Store backups in AWS S3 automatically

---

**Sai Ram Reddy Badari**  
_DevOps Engineer | PearlThoughts Internship Project_  
📧 [sairambadari038@gmail.com]  
📅 October 2025

---
