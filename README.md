VM Health Check Script

Description

This script analyzes the health of a virtual machine based on CPU usage, memory usage, and disk space utilization. If any of these exceed 60% usage, the script declares the VM as Not Healthy; otherwise, it is Healthy.

Additionally, the script supports an optional explain argument to display the reasons behind the health status.

Features

. Checks CPU usage using mpstat

. Checks Memory usage using /proc/meminfo

. Checks Disk usage using df /

. Provides detailed output when run with explain

