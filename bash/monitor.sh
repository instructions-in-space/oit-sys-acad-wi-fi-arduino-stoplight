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

# Set default values for light duration for Automatic Mode
red_duration=3
yellow_duration=3
green_duration=3

while : ; do
	latest_line=$(tail -n 1 ../state/log.txt)
	#echo $latest_line
	#echo Run
	if [[ "$latest_line" =~ redon ]]; then
		new_state=redon
		automatic_was_on_last=0
		if [[ ! $new_state =~ $current_state ]]; then
			current_state=redon
			echo \"$current_state\"
			$connection_string$current_state
		fi
	elif [[ "$latest_line" =~ redoff ]]; then
		new_state=redoff
		automatic_was_on_last=0
		if [[ ! $new_state =~ $current_state ]]; then
			current_state=redoff
			echo \"$current_state\"
			$connection_string$current_state
		fi
	elif [[ "$latest_line" =~ yellowon ]]; then
		new_state=yellowon
		automatic_was_on_last=0
		if [[ ! $new_state =~ $current_state ]]; then
			current_state=yellowon
			echo \"$current_state\"
			$connection_string$current_state
		fi
	elif [[ "$latest_line" =~ yellowoff ]]; then
		new_state=yellowoff
		automatic_was_on_last=0
		if [[ ! $new_state =~ $current_state ]]; then
			current_state=yellowoff
			echo \"$current_state\"
			$connection_string$current_state
		fi
	elif [[ "$latest_line" =~ greenon ]]; then
		new_state=greenon
		automatic_was_on_last=0
		if [[ ! $new_state =~ $current_state ]]; then
			current_state=greenon
			echo \"$current_state\"
			$connection_string$current_state
		fi
	elif [[ "$latest_line" =~ greenoff ]]; then
		new_state=greenoff
		automatic_was_on_last=0
		if [[ ! $new_state =~ $current_state ]]; then
			current_state=greenoff
			echo \"$current_state\"
			$connection_string$current_state
		fi
	elif [[ "$latest_line" =~ automaticon ]]; then
		# --------------------------------
		# Turn off all lights that were turned on
		# manually (previously).
		automatic_was_on_last=1
		current_state=automaticoff
		echo \"automatic off \(reset\)\"
		$connection_string$current_state
		# --------------------------------
		current_state=yellowon
		echo \"automatic yellow\" \($yellow_duration\)
		$connection_string$current_state
		sleep $yellow_duration
		current_state=yellowoff
		$connection_string$current_state
		# --------------------------------
		current_state=redon
		echo \"automatic red\" \($red_duration\)
		$connection_string$current_state
		sleep $red_duration
		current_state=redoff
		$connection_string$current_state
		# --------------------------------
		current_state=greenon
		echo \"automatic green\" \($green_duration\)
		$connection_string$current_state
		sleep $green_duration
		current_state=greenoff
		$connection_string$current_state
		# --------------------------------
	elif [[ "$latest_line" =~ automaticoff ]]; then
		new_state=automaticoff
		if [[ ! $new_state =~ $current_state ]]; then
			current_state=automaticoff
			echo \"$current_state\"
			$connection_string$current_state
		fi
	elif [[ "$latest_line" =~ timechange ]]; then
		timechange_string=$(echo $latest_line | tr ' ' '\n' | grep timechange | tr -d '/')
		undefined_to_zero="${timechange_string//undefined/3}"
		new_state=$undefined_to_zero
		current_state=$new_state
		# ----------------------------------------------------------
		# Set the new durations.
		red_duration=$(echo $current_state | grep -o '[0-9]\+' | head -1)
		yellow_duration=$(echo $current_state | grep -o '[0-9]\+' | head -2 | tail -1)
		green_duration=$(echo $current_state | grep -o '[0-9]\+' | tail -1)
		# ----------------------------------------------------------
		# Be sure to continue Automatic mode after the time update.
		if [ $automatic_was_on_last -eq 1 ]; then
			echo "automaticon" >> ../state/log.txt
		fi
	fi
	sleep 0.25
done 


