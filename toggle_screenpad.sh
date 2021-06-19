#!/bin/bash

touch /home/youruser/.screenpad/screenpad_on

ison=$(cat /home/youruser/.screenpad/screenpad_on)
if [ -z "$ison" ]
then
	ison=false
fi

if [ "$ison" = false ]
then
	/home/youruser/.screenpad/ScreenpadLinux/enable_screenpad.sh
fi

if [ "$ison" = true ]
then
	/home/youruser/.screenpad/ScreenpadLinux/disable_screenpad.sh
fi

echo "Toggled to: $(cat /home/youruser/.screenpad/screenpad_on)"
