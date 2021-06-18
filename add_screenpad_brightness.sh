#!/bin/bash

# $1 equals to the first argument (12 equals 5%, range = 0-255)
incr=$1

# touch /opt/screenpad/screenpad_brightness
# chmod 777 /opt/screenpad/screenpad_brightness
bright=$(cat /opt/screenpad/screenpad_brightness)
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
	bright="0"
fi

echo $bright
/opt/screenpad/set_screenpad_brightness.sh $bright
