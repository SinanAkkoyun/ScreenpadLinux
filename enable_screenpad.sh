#!/bin/sh

# xrandr display adapters connected to Screenpad, adjust for your model (current model: UX580GE)
screenpad_intel="HDMI-1-0"
screenpad_nvidia="HDMI-0"

screenpad_output=$screenpad_intel
optimus_mode=$(optimus-manager --print-mode)

if [[ "$optimus_mode" == *"hybrid"* ]]; then
	echo "Intel"
	screenpad_output=$screenpad_intel
elif [[ "$optimus_mode" == *"nvidia"* ]]; then
	echo "NVIDIA"
	screenpad_output=$screenpad_nvidia
elif [[ "$optimus_mode" == *"integrated"* ]]; then
	echo "Integrated, on your model this will not work."
	notify-send "Screenpad" "Screenpad not enabled, please switch to Hybrid or NVIDIA in Optimus Manager."
	exit 1

	# If this will work on your model, uncomment following line:
	# screenpad_output=$screenpad_intel
else
	echo "Optimus not installed, defaulting to Intel."
	screenpad_output=$screenpad_intel
fi

notify-send 'Screenpad' 'Enabling Screenpad...'
/opt/screenpad/set_screenpad_brightness.sh 255

# Adjust and shrink as you can
sleep 5s

xrandr --newmode "screenpad" 140.00 1080 1150 1170 1195 1920 1924 1926 1930 -hsync -vsync
xrandr --addmode "$screenpad_output" "screenpad"
xrandr --output "$screenpad_output" --mode "screenpad" --rotate "right" --pos 0x1080
echo "true" > /opt/screenpad/screenpad_on
notify-send 'Screenpad' 'Enabled Screenpad'
