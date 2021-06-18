#!/bin/bash

sudo chmod a+w '/sys/class/leds/asus::screenpad/brightness'
sudo touch /tmp/screenpad_brightness
sudo chmod 777 /tmp/screenpad_brightness
echo "255" > /tmp/screenpad_brightness

# ADD CHOICE IN INSTALLER
# isNVIDIA=$(optimus-manager --print-mode)
# Current GPU mode : nvidia
# /opt/screenpad/enable_screenpad.sh
