#!/bin/sh

/home/youruser/.screenpad/ScreenpadLinux/set_screenpad_brightness.sh 0

# xrandr display adapters connected to Screenpad, adjust for your model (current model: UX580GE)
screenpad_intel=$(jq -r .intel /home/youruser/.screenpad/ScreenpadLinux/config.json)
screenpad_nvidia=$(jq -r .nvidia /home/youruser/.screenpad/ScreenpadLinux/config.json)

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

	# If this will work on your model, comment following line:
	exit 1
	# And uncomment following line:
	# screenpad_output=$screenpad_intel
else
	echo "Optimus not installed, defaulting to Intel."
	screenpad_output=$screenpad_intel
fi

xrandr --output "$screenpad_output" --off
echo "false" > /home/youruser/.screenpad/screenpad_on
notify-send 'Screenpad' 'Disabled Screenpad'
