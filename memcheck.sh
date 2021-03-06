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

mkdir -p ~/.memcheck

while true 
do
	# Get total free memory size in megabytes (MB) 
	free=$(free -mt | grep Total | awk '{print $4}')
	## check if free memory is less or equals to 100MB
	if [[ "$free" -le "$MEMORY_CRITICAL_LIMIT"  ]]; then
		## get top processes consuming system memory and save to temporary file 
		ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head > "$HOME/.memcheck/top_proccesses_consuming_memory.txt"
		# Raise alert
		notify-send -u critical -t 2000 "Warning, memory is running dangerously low" "Free memory: $free MB"
	elif [[ "$free" -le "$MEMORY_LOW_LIMIT" ]]; then
		notify-send -u normal -t 1500 "Warning, memory is getting low" "Free memory: $free MB"
	else
	   echo "Current available memory: $free"
	fi
	sleep "$CHECK_INTERVAL" # Wait for next poll event
done
