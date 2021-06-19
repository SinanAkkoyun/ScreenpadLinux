#!/bin/bash

echo -e "Checking if user is running as root..."

if [ "$EUID" -ne 0 ]
then
	echo "Running as normal usr, continuing..."
else
	echo "Please do NOT run as root! Root will be necessary later. Aborting..."
	exit
fi



echo -e "Welcome to the Screenpad for Linux installer!"
echo -e "Please make sure you installed asus-wmi-screenpad beforehand."
echo -e "https://github.com/Plippo/asus-wmi-screenpad"

echo -e "\nDid you install asus-wmi-screenpad?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) echo "Proceeding with installaton"; break;;
        No ) echo "Aborting..."; exit;;
    esac
done

echo -e "\nWe are now going to make a new directory where all the scripts are housed."
echo -e "It's name is .screenpad inside your home directory. I will create it."

mkdir ~/.screenpad
cd ~/.screenpad

echo -e "\nNow I am going to clone all scripts into here. I will make a backup of the old repo."
rm -f -r backup_all
mv ScreenpadLinux backup_all
git clone https://github.com/SinanAkkoyun/ScreenpadLinux

echo -e "\nDone! Your scripts are now in place."

cd ~/.screenpad/ScreenpadLinux

echo -e "Setting permissions to executable..."
chmod a+x *
echo -e "Done!"

echo -e "Now we need to edit some files in order to make your screenpad work on NVIDIA mode. Do you have the nvidia drivers installed and want to make them work with the screenpad? (Yes RECOMMENDED), (No) if you explicitly do not want NVIDIA support."
select yn in "Yes" "No"; do
    case $yn in
        Yes )
	       	echo -e "Copying a backup of your /usr/share/X11/xorg.conf.d/10-nvidia*.conf into ~/.screenpad/"
		cp /usr/share/X11/xorg.conf.d/10-nvidia*.conf ~/.screenpad/
		echo -e "Editing NVIDIA config to let the screenpad have it's correct resolution..."
		sudo sed -i '/Option/c\	Option "ModeValidation" "NoDFPNativeResolutionCheck,NoVirtualSizeCheck,NoMaxPClkCheck,NoHorizSyncCheck,NoEdidDFPMaxSizeCheck,NoVertRefreshCheck,NoWidthAlignmentCheck,NoEdidMaxPClkCheck,NoMaxSizeCheck"' /usr/share/X11/xorg.conf.d/10-nvidia*.conf
		echo -e "Done!"
		break
		;;
        No ) echo -e "Keep in mind that you can not use the screenpad in NVIDIA mode."; break;;
    esac
done

echo -e "\nNow we need to edit some files..."


