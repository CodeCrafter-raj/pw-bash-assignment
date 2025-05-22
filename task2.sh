#!/bin/bash

LOG_FILE="system_health.log"
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

# Get CPU load using powershell (average over all cores)
CPU_LOAD=$(powershell -Command "Get-Counter '\Processor(_Total)\% Processor Time' | Select -ExpandProperty CounterSamples | Select -ExpandProperty CookedValue")
CPU_LOAD_INT=$(printf "%.0f" "$CPU_LOAD")

# Get available memory and total memory using powershell
MEMORY_STATS=$(powershell -Command "Get-CimInstance Win32_OperatingSystem | Select-Object FreePhysicalMemory,TotalVisibleMemorySize")
FREE_MEM=$(echo "$MEMORY_STATS" | grep FreePhysicalMemory | awk '{print $2}')
TOTAL_MEM=$(echo "$MEMORY_STATS" | grep TotalVisibleMemorySize | awk '{print $2}')

# Convert to percent
MEMORY_USAGE_PERCENT=$(( (100 * (TOTAL_MEM - FREE_MEM)) / TOTAL_MEM ))
AVAILABLE_MEM_PERCENT=$((100 - MEMORY_USAGE_PERCENT))

# Prepare log message
LOG_MSG="$TIMESTAMP - CPU: $CPU_LOAD_INT%%, Available Memory: $AVAILABLE_MEM_PERCENT%%"

# Check thresholds
if [ "$CPU_LOAD_INT" -gt 80 ] || [ "$AVAILABLE_MEM_PERCENT" -lt 20 ]; then
    LOG_MSG="$LOG_MSG - ⚠️ Alert: System under high load or low memory"
fi

# Write to log
echo "$LOG_MSG" >> "$LOG_FILE"
echo "System health check completed. Log saved to $LOG_FILE"

