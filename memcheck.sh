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
while true
do
	## get total free memory size in megabytes(MB) 
	free=$(free -mt | grep Total | awk '{print $4}')
	## check if free memory is less or equals to  100MB
	if [[ "$free" -le 100  ]]; then
		## get top processes consuming system memory and save to temporary file 
		ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head > /home/demo/Desktop/top_proccesses_consuming_memory.txt
		#file=/home/demo/top_proccesses_consuming_memory.txt
		## raise alert
		notify-send -u critical -t 2000 "Warning, memory is running dangerously low" "Free memory: $free MB"
	elif [[ "$free" -le 301]]; then
		notify-send -u normal -t 1500 "Warning, memory is getting low" "Free memory: $free MB"
	fi
	
	sleep 5s # Five second interval between checks
done
