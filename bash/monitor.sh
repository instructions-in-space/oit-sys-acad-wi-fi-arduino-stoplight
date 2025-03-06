#!/usr/bin/bash

# -----------------------------------------------------------------------
# Assign command line arguments to variables.
mode=$1
arduino_ip_address=$2
# -----------------------------------------------------------------------
# Handle input errors.
error_text="Error, check input.  (The first command line argument\n
should be the mode [either \"prod\" or \"test\"]. In \"prod\"\n
mode, the second command line argument should be the IP\n
address of the Arduino.)"
if [[ $mode =~ prod ]]; then
	connection_string="curl http://$arduino_ip_address/"
	if [ -z $arduino_ip_address ]; then
		echo -e $error_text
		exit
	fi
elif [[ $mode =~ test ]]; then
	connection_string=""
else
	echo -e $error_text
	exit
fi
# -----------------------------------------------------------------------
# Main part of the script

echo "Welcome to \"monitor.sh\"!  (Press ctrl-c to exit.)"

while : ; do
	latest_line=$(tail -n 1 ../state/log.txt)
	if [[ "$latest_line" =~ redon ]]; then
		$connection_string
		new_state=redon
		if [[ ! $new_state =~ $current_state ]]; then
			current_state=redon
			echo \"$current_state\" is the latest command.
		fi
	elif [[ "$latest_line" =~ redoff ]]; then
		$connection_string
		new_state=redoff
		if [[ ! $new_state =~ $current_state ]]; then
			current_state=redoff
			echo \"$current_state\" is the latest command.
		fi
	elif [[ "$latest_line" =~ yellowon ]]; then
		$connection_string
		new_state=yellowon
		if [[ ! $new_state =~ $current_state ]]; then
			current_state=yellowon
			echo \"$current_state\" is the latest command.
		fi
	elif [[ "$latest_line" =~ yellowoff ]]; then
		$connection_string
		new_state=yellowoff
		if [[ ! $new_state =~ $current_state ]]; then
			current_state=yellowoff
			echo \"$current_state\" is the latest command.
		fi
	elif [[ "$latest_line" =~ greenon ]]; then
		$connection_string
		new_state=greenon
		if [[ ! $new_state =~ $current_state ]]; then
			current_state=greenon
			echo \"$current_state\" is the latest command.
		fi
	elif [[ "$latest_line" =~ greenoff ]]; then
		$connection_string
		new_state=greenoff
		if [[ ! $new_state =~ $current_state ]]; then
			current_state=greenoff
			echo \"$current_state\" is the latest command.
		fi




	fi
	sleep 1
done 

# 

