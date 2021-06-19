#!/bin/bash

echo -e "Updating Screenpad... (Making backup to backup_update/)"
cd ~/.screenpad/
rm -f -r backup_update
cp * backup_update/

echo -e "Git pulling..."
git pull

echo -e "Done! Enjoy."
