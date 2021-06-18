#!/bin/sh

# echo 0 | tee '/sys/class/leds/asus::screenpad/brightness'
/opt/screenpad/set_screenpad_brightness.sh 0
xrandr --output HDMI-0 --off
echo "false" > /opt/screenpad/screenpad_on
notify-send 'Screenpad' 'Disabled Screenpad'
