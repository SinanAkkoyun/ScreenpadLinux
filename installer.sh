#!/bin/bash

echo "Checking if user is running as root..."

if [ "$EUID" -ne 0 ]
then
	echo "Running as normal usr, continuing..."
else
	echo "Please do NOT run as root! Root will be necessary later. Aborting..."
	exit
fi



echo "Welcome to the Screenpad for Linux installer!"
echo "Please make sure you installed asus-wmi-screenpad beforehand."
echo "https://github.com/Plippo/asus-wmi-screenpad"

echo "Did you install asus-wmi-screenpad?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) echo "Proceeding with installaton"; break;;
        No ) echo "Aborting..."; exit;;
    esac
done

echo "We are now going to make a new directory where all the scripts are housed."
echo "It's name is .screenpad inside your home directory. I will create it."

mkdir ~/.screenpad
cd ~/.screenpad

echo "Now I am going to clone all scripts into here. I will make a backup of the old repo."
mv ScreenpadLinux backup
git clone https://github.com/SinanAkkoyun/ScreenpadLinux

echo "Done! Your scripts are now in place."
cd ~/.screenpad/ScreenpadLinux

echo "Setting permissions to executable..."
chmod a+x *
echo "Done!"

echo "Now we will configure shortcuts. This script will only automatically configure shortcuts for KDE. Do you want me to add new shortcuts automatically (Yes) or do you want to manually add them later (Skip)? WARNING: If you already did this step, we advise you do skip it, otherwise you will import these shortcuts again."
select yn in "Yes" "Skip"; do
    case $yn in
        Yes ) 
		echo "Proceeding with installing shortcuts..."
		if [ -f "/usr/share/khotkeys/screenpad_shortcuts.khotkeys" ];
		then
			echo "Shortcuts already exist. Continuing..."
		else
			cp ~/.screenpad/ScreenpadLinux/screenpad_shortcuts.khotkeys /usr/share/khotkeys/
			echo "Copied screenpad_shortcuts.khotkeys into place. Changes occur after reboot."
		fi
		break
		;;
        Skip ) echo "In order to add your own shortcuts, you need to know how to use the scripts. For adding/subtracting brightness please set this as your execution command for brightness control: \"~/.screenpad/ScreenpadLinux/add_screenpad_brightness.sh +12/-12\". 12 roughly equals to 5%, because you can set values from 0-255.\nIn order to set the brightness to an absolute value, do \"~/.screenpad/ScreenpadLinux/set_screenpad_brightness.sh 255\".\nIn order to toggle the screenpad, do \"~/.screenpad/ScreenpadLinux/toggle_screenpad.sh\"\nYou can also find this info on my GitHub page."; break;;
    esac
done

echo "TEST"
