RUN ------
chmod +x organize.sh
./organize.sh
--------------------
This is a simple bash script for monitoring CPU and memory usage on macOS.

The script checks current CPU and memory usage and writes an alert to a log file if usage goes above a set limit.

What it does

Gets CPU usage using top

Gets memory usage using vm_stat

Converts memory pages to MB

Logs alerts with date and time when limits are crossed
