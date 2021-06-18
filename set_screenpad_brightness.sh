#!/bin/bash

echo $1 | tee '/sys/class/leds/asus::screenpad/brightness'
echo $1 > /tmp/screenpad_brightness
