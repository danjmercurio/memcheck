#!/bin/bash 
#######################################################################################
# Script Name    :memcheck.sh
# Description    :notify when memory is running low
# Args           :       
# Author         :Aaron Kili Kisinga and revised by Dan Mercurio
# Email          :aaronkilik@gmail.com; dan.j.mercurio@gmail.com
# License        :GNU GPL-3	
# Modified       :Aug 31, 2018, 23:15:16
#######################################################################################

# You are welcome to change these from their defaults based on your own hardware
MEMORY_CRITICAL_LIMIT=100 # 100mb
MEMORY_LOW_LIMIT=300 # 300mb
CHECK_INTERVAL='5s' # Check memory levels every 5 seconds. Run man sleep for details on possible arguments
LOG_DIR="$HOME/.memcheck"

mkdir -p "$LOG_DIR" # Create directory for log files if it doesn't exist

while true
do
	# Get total free memory size in megabytes (MB) 
	free=$(free -mt | grep Total | awk '{print $4}')
	# Check if free memory is less or equals to 100MB
	if [[ "$free" -le "$MEMORY_CRITICAL_LIMIT"  ]]; then
		# Get top processes consuming system memory and save to log file 
		ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head > "$LOG_DIR/top_proccesses_consuming_memory.log"
		echo "$(date '+%x %I:%M:%S %p %Z') ($(date '+%s')s): Critically low memory: $free megabytes" >> "$LOG_DIR/memcheck.log" # Append to log

		# Raise alert
		notify-send -u critical -t 2000 "Warning, memory is running dangerously low" "Free memory: $free MB"
	elif [[ "$free" -le "$MEMORY_LOW_LIMIT" ]]; then
		notify-send -u normal -t 1500 "Warning, memory is getting low" "Free memory: $free MB"
		echo "$(date '+%x %I:%M:%S %p %Z') ($(date '+%s')s): Low Memory - $free megabytes" >> "$LOG_DIR/memcheck.log" # Append to log
	else
	   echo "$(date '+%x %I:%M:%S %p %Z') ($(date '+%s')s): Current available memory OK - $free megabytes" >> "$LOG_DIR/memcheck.log"

	fi
	sleep "$CHECK_INTERVAL" # Wait for next poll event
done
