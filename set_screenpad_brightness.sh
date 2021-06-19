#!/bin/bash

echo $1 | tee '/sys/class/leds/asus::screenpad/brightness'
echo $1 > /home/youruser/.screenpad/screenpad_brightness
# notify-send "Screenpad" "Set brightness to $1"
