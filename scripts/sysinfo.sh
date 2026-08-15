#!/bin/bash
# sysinfo.sh - prints basic system information

echo "===== System Info ====="
echo "Current user: $(whoami)"
echo "Current date: $(date)"
echo "Disk usage:"
df -h
