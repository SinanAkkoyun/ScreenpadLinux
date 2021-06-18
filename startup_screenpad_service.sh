#!/bin/bash

sudo chmod a+w '/sys/class/leds/asus::screenpad/brightness'
sudo touch /opt/screenpad/screenpad_brightness
sudo touch /opt/screenpad/screenpad_on
sudo chmod 777 /opt/screenpad/screenpad_brightness
sudo chmod 777 /opt/screenpad/screenpad_on
echo "0" > /opt/screenpad/screenpad_brightness
echo "false" > /opt/screenpad/screenpad_on

# ADD CHOICE IN INSTALLER
# isNVIDIA=$(optimus-manager --print-mode)
# Current GPU mode : nvidia
# /opt/screenpad/enable_screenpad.sh
