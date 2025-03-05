#!/usr/bin/bash

echo "Welcome to \"monitor.sh\"!  (Press ctrl-c to exit.)"

while : ; do
	latest_line=$(tail -n 1 ../state/log.txt)
	if [[ "$latest_line" =~ green ]]; then
		curl http://192.168.204.21/green
		echo \"green\" is the current state.
	elif [[ "$latest_line" =~ alloff ]]; then
		curl http://192.168.204.21/alloff
		echo \"alloff\" is the current state.
	elif [[ "$latest_line" =~ redon ]]; then
		curl http://192.168.204.21/redon
		echo \"redon\" is the current state.
	elif [[ "$latest_line" =~ redoff ]]; then
		curl http://192.168.204.21/redoff
		echo \"redoff\" is the current state.
	fi
	sleep 1
done 

# 

