#!/bin/bash

# Function to get CPU utilization percentage
get_cpu_usage() {
    local cpu_usage=$(mpstat 1 1 | awk '/Average/ {print 100 - $NF}')
    echo "${cpu_usage%.*}"  # Convert float to integer
}

# Function to get Memory utilization percentage
get_memory_usage() {
    local mem_total=$(awk '/MemTotal/ {print $2}' /proc/meminfo)
    local mem_available=$(awk '/MemAvailable/ {print $2}' /proc/meminfo)
    local mem_usage=$(( ( (mem_total - mem_available) * 100 ) / mem_total ))
    echo "$mem_usage"
}

# Function to get Disk utilization percentage
get_disk_usage() {
    local disk_usage=$(df / | awk 'NR==2 {print ($3/$2)*100}')
    echo "${disk_usage%.*}"  # Convert float to integer
}

# Get current utilization values
cpu_usage=$(get_cpu_usage)
memory_usage=$(get_memory_usage)
disk_usage=$(get_disk_usage)

# Determine VM health
if [[ $cpu_usage -gt 60 || $memory_usage -gt 60 || $disk_usage -gt 60 ]]; then
    health_status="Not Healthy"
else
    health_status="Healthy"
fi

# Print health status
if [[ "$1" == "explain" ]]; then
    echo "Health Status: $health_status"
    echo "Reason:"
    echo "CPU Usage: $cpu_usage%"
    echo "Memory Usage: $memory_usage%"
    echo "Disk Usage: $disk_usage%"
else
    echo "Health Status: $health_status"
fi
