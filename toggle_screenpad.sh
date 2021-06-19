#!/bin/bash

ison=$(cat ~/.screenpad/screenpad_on)
if [ -z "$ison" ]
then
	ison=false
fi

if [ "$ison" = false ]
theScreenpadLinux/n
	~/.screenpad/ScreenpadLinux/enable_screenpad.sh
fi

if [ "$ison" = true ]
then
	~/.screenpad/ScreenpadLinux/disable_screenpad.sh
fi

echo "Toggled to: $(cat ~/.screenpad/screenpad_on)"
