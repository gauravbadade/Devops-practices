#!/bin/bash

# Function to display total CPU usage
cpu_usage() {
    echo "Total CPU Usage:"
    # Get total CPU usage as a percentage
    uptime | awk -F'[a-z]:' '{ print $2}' | awk '{ print $1 }'
}

# Function to display memory usage
memory_usage() {
    echo "Total Memory Usage:"
    # Get memory usage
    free -h | awk '/^Mem:/{printf("Used: %s (%.2f%%), Free: %s\n", $3, $3/$2*100, $7)}'
}

# Function to display disk usage
disk_usage() {
    echo "Total Disk Usage:"
    # Get disk usage for root filesystem
    df -h / | awk 'NR==2{printf("Used: %s (%.2f%%), Free: %s\n", $3, $3/$2*100, $4)}'
}

# Function to display top 5 processes by CPU usage
top_cpu_processes() {
    echo "Top 5 Processes by CPU Usage:"
    ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
}

# Function to display top 5 processes by memory usage
top_memory_processes() {
    echo "Top 5 Processes by Memory Usage:"
    ps -eo pid,comm,%mem --sort=-%mem | head -n 6
}

# Main script execution
echo "=== Server Performance Stats ==="
cpu_usage
memory_usage
disk_usage
echo ""
top_cpu_processes
echo ""
top_memory_processes
