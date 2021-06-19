#!/bin/bash

# $1 equals to the first argument (12 equals 5%, range = 0-255)
incr=$1

bright=$(cat ~/.screenpad/screenpad_brightness)
if [ -z "$bright" ]
then
	bright="255"
fi

bright=$(( bright + incr ))

if [ $bright -gt 255 ]
then
	bright="255"
fi
# screenpad turns off at exactly 0, hence why 1
if [ 1 -gt $bright ]
then
	bright="1"
fi
if [ $bright -eq 1 ]
then
	# uncomment if you want to disable your screenpad by setting it to low brightness
	# bright="0"
	echo "Already at minimum brightness"
fi

echo $bright

ison=$(cat ~/.screenpad/screenpad_on)
if [ -z "$ison" ]
then
ison=false
fi

if [ "$ison" = true ]; then
	~/.screenpad/ScreenpadLinux/set_screenpad_brightness.sh $bright
fi
