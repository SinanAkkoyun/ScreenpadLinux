#!/bin/bash

sudo chmod a+w '/sys/class/leds/asus::screenpad/brightness'
echo -e "Screenpad service done!"

/home/youruser/.screenpad/ScreenpadLinux/disable_screenpad.sh
