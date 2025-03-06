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
		new_state=redon
		if [[ ! $new_state =~ $current_state ]]; then
			current_state=redon
			$connection_string$current_state
			echo \"$current_state\"
		fi
	elif [[ "$latest_line" =~ redoff ]]; then
		new_state=redoff
		if [[ ! $new_state =~ $current_state ]]; then
			current_state=redoff
			$connection_string$current_state
			echo \"$current_state\"
		fi
	elif [[ "$latest_line" =~ yellowon ]]; then
		new_state=yellowon
		if [[ ! $new_state =~ $current_state ]]; then
			current_state=yellowon
			$connection_string$current_state
			echo \"$current_state\"
		fi
	elif [[ "$latest_line" =~ yellowoff ]]; then
		new_state=yellowoff
		if [[ ! $new_state =~ $current_state ]]; then
			current_state=yellowoff
			$connection_string$current_state
			echo \"$current_state\"
		fi
	elif [[ "$latest_line" =~ greenon ]]; then
		new_state=greenon
		if [[ ! $new_state =~ $current_state ]]; then
			current_state=greenon
			$connection_string$current_state
			echo \"$current_state\"
		fi
	elif [[ "$latest_line" =~ greenoff ]]; then
		new_state=greenoff
		if [[ ! $new_state =~ $current_state ]]; then
			current_state=greenoff
			$connection_string$current_state
			echo \"$current_state\"
		fi
	elif [[ "$latest_line" =~ automaticon ]]; then
		new_state=automaticon
		if [[ ! $new_state =~ $current_state ]]; then
			current_state=automaticon
			$connection_string$current_state
			echo \"$current_state\"
		fi
	elif [[ "$latest_line" =~ automaticoff ]]; then
		new_state=automaticoff
		if [[ ! $new_state =~ $current_state ]]; then
			current_state=automaticoff
			$connection_string$current_state
			echo \"$current_state\"
		fi
	elif [[ "$latest_line" =~ timechange ]]; then
		timechange_string=$(echo $latest_line | tr ' ' '\n' | grep timechange | tr -d '/')
		undefined_to_zero="${timechange_string//undefined/0}"
		new_state=$undefined_to_zero
		if [[ ! $new_state =~ $current_state ]]; then
			current_state=$new_state
			$connection_string$current_state
			echo \"$current_state\"
		fi
	fi
	sleep 0.25
done 


