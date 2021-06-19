#!/bin/bash

echo -e "Updating Screenpad... (Making backup to backup_update/)"
cd ~/.screenpad/
rm -f -r backup_update
cp * backup_update/

echo -e "Git pulling..."
git pull

echo -e "Updating systemd service..."
sudo systemctl stop screenpad.service
sudo rm -f /etc/systemd/system/screenpad.service
sudo cp ScreenpadLinux/screenpad.service /etc/systemd/system/

echo -e "Reloading systemctl daemon"
sudo systemctl daemon-reload
sudo systemctl start screenpad.service
sudo systemctl enable screenpad.service


echo -e "Updating shortcuts..."
select yn in "Yes" "No"; do
    case $yn in
        Yes )
		cp ~/-config/khotkeysrc ~/.screenpad/backup_khotkeysrc
		sed -i 's/,screenpad_shortcuts//' ~/.config/khotkeysrc
		sudo rm -f /usr/share/khotkeys/screenpad_shortcuts.khotkeys
		sudo cp ScreenpadLinux/screenpad_shortcuts.khotkeys /usr/share/khotkeys/
		echo -e "NOTE: You need to remove your old shortcuts manually in the GUI."
		break;;
        No )
		echo -e "Shortcuts not updated"
		break;;
    esac
done

echo -e "Done! Enjoy."
