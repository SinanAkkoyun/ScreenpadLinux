#!/bin/sh

#Only works when NVIDIA optimus is set to NVIDIA

notify-send 'Screenpad' 'Enabling Screenpad...'
echo 255 | tee '/sys/class/leds/asus::screenpad/brightness'
sleep 5s
xrandr --newmode "screenpad" 140.00 1080 1150 1170 1195 1920 1924 1926 1930 -hsync -vsync
xrandr --addmode HDMI-0 "screenpad"
xrandr --output HDMI-0 --mode "screenpad" --rotate "right" --pos 0x1080
echo "true" > /opt/screenpad/screenpad_on
notify-send 'Screenpad' 'Enabled Screenpad'
