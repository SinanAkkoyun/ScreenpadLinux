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
sudo cp screenpad.service /etc/systemd/system/

echo -e "Reloading systemctl daemon"
sudo systemctl daemon-reload
sudo systemctl start screenpad.service
sudo systemctl enable screenpad.service

echo -e "Done! Enjoy."
