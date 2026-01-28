
#!/usr/bin/env bash
set -Eeuo pipefail

CPU_THRESHOLD=80
MEMORY_THRESHOLD=8000   # MB

CPU_USAGE=$(top -l 1 | grep "CPU usage" | awk '{print int($3 + $5)}')
DATE=$(date "+%Y-%m-%d_%H-%M-%S")

PAGE_SIZE=4096

PAGES_ACTIVE=$(vm_stat | grep "Pages active" | awk '{print $3}' | sed 's/\.//')
PAGES_INACTIVE=$(vm_stat | grep "Pages inactive" | awk '{print $3}' | sed 's/\.//')
PAGES_WIRED_DOWN=$(vm_stat | grep "Pages wired down" | awk '{print $4}' | sed 's/\.//')

MEMORY_USAGE=$(((PAGES_ACTIVE + PAGES_INACTIVE + PAGES_WIRED_DOWN) * PAGE_SIZE / 1024 / 1024))

if [ "$CPU_USAGE" -ge "$CPU_THRESHOLD" ]; then
    echo "ALERT: CPU usage is high at $CPU_USAGE% [$DATE]" >> logfile.log

fi

if [ "$MEMORY_USAGE" -ge "$MEMORY_THRESHOLD" ]; then
    echo "ALERT: Memory usage is high at ${MEMORY_USAGE}MB [$DATE]" >> logfile.log
fi

echo "Have a nice day $DATE" >> logfile.log
