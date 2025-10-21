#!/bin/bash

# ---------------------------
# Configuration
# ---------------------------
CPU_THRESHOLD=80
MEM_THRESHOLD=75
DISK_THRESHOLD=85
EMAIL="admin@example.com"
HOSTNAME=$(hostname)
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

# ---------------------------
# Functions to get usage
# ---------------------------
# CPU usage (average of all cores)
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{usage=100-$8} END {print usage}' | cut -d'.' -f1)

# Memory usage %
MEM_USAGE=$(free | awk '/Mem/ {printf("%.0f", $3/$2 * 100)}')

# Disk usage %
DISK_USAGE=$(df -h / | awk 'NR==2 {gsub("%",""); print $5}')

# System load average (1 min)
LOAD_AVG=$(uptime | awk -F'load average:' '{print $2}' | awk '{print $1}' | sed 's/,//')

# ---------------------------
# Check thresholds and send email
# ---------------------------
ALERT=false
MESSAGE="Resource Alert on $HOSTNAME - $TIMESTAMP\n\n"

if [ "$CPU_USAGE" -ge "$CPU_THRESHOLD" ]; then
    ALERT=true
    MESSAGE+="CPU Usage: $CPU_USAGE% (Threshold: $CPU_THRESHOLD%)\n"
fi

if [ "$MEM_USAGE" -ge "$MEM_THRESHOLD" ]; then
    ALERT=true
    MESSAGE+="Memory Usage: $MEM_USAGE% (Threshold: $MEM_THRESHOLD%)\n"
fi

if [ "$DISK_USAGE" -ge "$DISK_THRESHOLD" ]; then
    ALERT=true
    MESSAGE+="Disk Usage: $DISK_USAGE% (Threshold: $DISK_THRESHOLD%)\n"
fi

MESSAGE+="System Load Average (1 min): $LOAD_AVG\n"

if [ "$ALERT" = true ]; then
    echo -e "$MESSAGE" | mailx -s "System Resource Alert on $HOSTNAME" "$EMAIL"
fi
