#!/bin/sh

echo 0 | tee '/sys/class/leds/asus::screenpad/brightness'
xrandr --output HDMI-0 --off
echo "false" > /opt/screenpad/screenpad_on
notify-send 'Screenpad' 'Disabled Screenpad'
