#!/bin/bash

echo -e "Checking if user is running as root..."

theuser=$(whoami)
echo "Detected user: $theuser"

if [ "$EUID" -ne 0 ]
then
	echo "Running as normal usr, continuing..."
else
	echo "Please do NOT run as root! Root will be necessary later. Aborting..."
	exit
fi



echo -e "Welcome to the Screenpad for Linux installer!"
echo -e "Please make sure you installed asus-wmi-screenpad and jq beforehand."
echo -e "https://github.com/Plippo/asus-wmi-screenpad AND jq"

echo -e "\nDid you install asus-wmi-screenpad and jq?"
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

rm -f -r backup_update
cp * backup_update/

echo -e "\nNow I am going to clone all scripts into here. I will make a backup of the old repo."
rm -f -r backup_all
mv ScreenpadLinux backup_all
git clone https://github.com/SinanAkkoyun/ScreenpadLinux

echo -e "\nDone! Your scripts are now in place."

cd ~/.screenpad/ScreenpadLinux

echo -e "Editing files to match your user name..."
sed -i "s/youruser/$theuser/g" *

echo -e "Setting permissions to executable..."
chmod a+x *
echo -e "Done!"

echo -e "\nFirst off we need to set the display adapter names to the correct ones of your screenpad (you can skip this if your model is the UX580GE)."

echo "Do you know your adapter names and want to change them now? (You can also do this after installation, the config file is ~/.screenpad/config.json) If you are not sure about the editor, choose Nano."
select yn in "Vim" "Nano" "No"; do
    case $yn in
        Vim ) vim config.json; break;;
	Nano ) nano config.json; break;;
        No ) echo -e "Continuing installation. Please edit the config file later (look for instructions on my GitHub page https://github.com/SinanAkkoyun/ScreenpadLinux"; break;;
    esac
done

echo -e "\nYou can always change the config and try out which ones do work and which ones don't. Keep in mind that when your device is in hybrid or nvidia mode your adapter name changes! Look at the GitHub page for further instructions: https://github.com/SinanAkkoyun/ScreenpadLinux"

echo -e "\nNow we need to edit some files in order to make your screenpad work on NVIDIA mode. Do you have the nvidia drivers installed and want to make them work with the screenpad? (Yes RECOMMENDED), (No) if you explicitly do not want NVIDIA support."
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

echo -e "Do you wish to install your shortcuts automatically? (Only KDE)"
select yn in "Yes" "No"; do
	case $yn in
	Yes )
		cp ~/.config/khotkeysrc ~/.screenpad/backup_khotkeysrc
		sed -i 's/,screenpad_shortcuts//' ~/.config/khotkeysrc
		sudo rm -f /usr/share/khotkeys/screenpad_shortcuts.khotkeys
		sed -i "s/youruser/$theuser/g" screenpad_shortcuts.khotkeys
		sudo cp screenpad_shortcuts.khotkeys /usr/share/khotkeys/
		echo -e "NOTE: You need to remove your old shortcuts manually in the GUI."
		break;;
	No )
		echo -e "Shortcuts not updated"
		break;;
	esac
done
echo -e "I did not get this to work, so please manually import the file."

echo -e "\nCool! Last step is to create a new systemd service that gives you permissions to access the screen brightness settings..."

echo -e "Updating systemd service file screenpad.service..."
sudo systemctl stop screenpad.service
sudo rm -f /etc/systemd/system/screenpad.service
sed -i "s/youruser/$theuser/g" screenpad.service
sudo cp screenpad.service /etc/systemd/system/

echo -e "Reloading systemctl daemon"
sudo systemctl daemon-reload
sudo systemctl start screenpad.service
sudo systemctl enable screenpad.service

echo -e "Everything set! In order to actiavte your screenpad, press SHIFT+FN+F6 (Shift + Toggle Touchpad)! To change brightness, you can press SHIFT+FN+F4/F5 (Shift + brightness up/down). But first, you need to reboot in order to set all changes."

echo -e "Do you want to reboot?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) sudo reboot; break;;
        No ) echo -e "Please reboot your system manually before trying to access the screenpad."; exit;;
    esac
done
