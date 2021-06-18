#!/bin/bash

# touch /opt/screenpad/screenpad_on
# chmod 777 /opt/screenpad/screenpad_on
ison=$(cat /opt/screenpad/screenpad_on)
if [ -z "$ison" ]
then
	ison=false
fi

if [ "$ison" = false ]
then
	/opt/screenpad/enable_screenpad.sh
fi

if [ "$ison" = true ]
then
	/opt/screenpad/disable_screenpad.sh
fi

echo "Toggled to: $(cat /opt/screenpad/screenpad_on)"
