# ASUS Screenpad on Linux
My solution to make the Screenpad work! (UX580GE and probably all models with trackpad screenpad)

# Installation

DISCLAIMER
If something does not work, join this Discord server: discord.gg/5uXFfsV
It enabled me to even write this

INSTALL:
https://github.com/Plippo/asus-wmi-screenpad
Also install NVIDIA drivers and optimus-manager

# Initial test
RUN:
echo 255 | sudo tee '/sys/class/leds/asus::screenpad/brightness'

Does your screenpads backlight light up after a few seconds (for me, my screen was black but my backlight lit up)? If yes, AWESOME, you are on the right track! If not, maybe my scripts do work, maybe not, but you can try to proceed.

RUN:
mkdir /opt/screenpad
cd /opt/screenpad

DOWNLOAD (into /opt/screenpad):
enable_screenpad.sh
disable_screenpad.sh
toggle_screenpad.sh
set_screenpad_brightness.sh
add_screenpad_brightness.sh
startup_screenpad_service.sh

RUN:
chmod 755 /opt/screenpad/*

ADD:
Option "ModeValidation" "NoDFPNativeResolutionCheck,NoVirtualSizeCheck,NoMaxPClkCheck,NoHorizSyncCheck,NoEdidDFPMaxSizeCheck,NoVertRefreshCheck,NoWidthAlignmentCheck,NoEdidMaxPClkCheck,NoMaxSizeCheck"
add to /usr/share/X11/xorg.conf.d/10-nvidia*.conf AFTER: Driver "nvidia"

This is my /usr/share/X11/xorg.conf.d/10-nvidia-drm-outputclass.conf for reference:
Section "OutputClass"
Identifier "nvidia"
MatchDriver "nvidia-drm"
Driver "nvidia"
Option "ModeValidation" "NoDFPNativeResolutionCheck,NoVirtualSizeCheck,NoMaxPClkCheck,NoHorizSyncCheck,NoEdidDFPMaxSizeCheck,NoVertRefreshCheck,NoWidthAlignmentCheck,NoEdidMaxPClkCheck,NoMaxSizeCheck"
ModulePath "/usr/lib/nvidia/xorg"
ModulePath "/usr/lib/xorg/modules"
EndSection

Now, add /opt/screenpad/startup_screenpad_service.sh to your Autostart of your distro.
Put /opt/screenpad/startup_screenpad_service.sh to "after log in"
And /opt/screenpad/disable_screenpad.sh to "after log out"

I will show the process for KDE:
![image](https://user-images.githubusercontent.com/43215895/122564947-746bd480-d035-11eb-8bf7-cb3e6b79b8db.png)
Choose /opt/screenpad/startup_screenpad_service.sh
Do the same but on log out with /opt/screenpad/disable_screenpad.sh
Your configuration should look like this:
![image](https://user-images.githubusercontent.com/43215895/122565203-bbf26080-d035-11eb-9a32-c2ae254025f5.png)

# Shortcuts
Add these shortcuts to your system but do not activate them until the last step!:
shift+MonitorBrightnessUp  ->  /opt/screenpad/add_screenpad_brightness.sh +12
shift+MonitorBrightnessDown -> /opt/screenpad/add_screenpad_brightness.sh -12

# Testing
Set your Optimus to NVIDIA. This internally activates the NVIDIA GPU and connects the screenpad. It might be that your model does not have a dedicated NVIDIA GPU, in that case join this discord for assistance: discord.gg/5uXFfsV
optimus-manager --switch nvidia --no-confirm

RUN:
chmod +x enable_screenpad.sh
./enable_screenpad.sh

et voilà

# Controls

change brightness by /opt/screenpad/add_screenpad_brightness.sh +12 or -12 (12 corresponds to about 5% brightness level)

when you manually set the brightness to 0 (/opt/screenpad/set_screenpad_brightness.sh 0), the laptop automatically disconnects the screenpad.
To activate it again you don't need to run enable_screenpad.sh again! Just set the brightness to something above 0!

You can manually control the brightness via: echo 255 | tee '/sys/class/leds/asus::screenpad/brightness'

# TODO: implement enable_screenpad.sh only after optimus NVIDIA has been enabled on login!!!

(l8r I will write a completely automated script)




resources and big thanks to:
https://gitlab.com/screenpad-linux/ux480f/-/blob/master/screenpad.sh
https://github.com/Plippo/asus-wmi-screenpad
