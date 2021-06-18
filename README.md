# ASUS Screenpad on Linux
My solution to make the Screenpad work! (UX580GE)

INSTALL:
https://github.com/Plippo/asus-wmi-screenpad

RUN:
echo 255 | sudo tee '/sys/class/leds/asus::screenpad/brightness'
# Does your screenpad light up after a few seconds? If yes, AWESOME, you are on the right track!

RUN: (optional, enables all users brightness control)
sudo chmod a+w '/sys/class/leds/asus::screenpad/brightness'
# chmod has to be executed again after every reboot, so it is advisable to add the call to a boot script, e.g. /etc/rc.local.
# from now on echo 255 | tee '/sys/class/leds/asus::screenpad/brightness' will be sufficient, no sudo required

ADD:
Option "ModeValidation" "NoDFPNativeResolutionCheck,NoVirtualSizeCheck,NoMaxPClkCheck,NoHorizSyncCheck,NoEdidDFPMaxSizeCheck,NoVertRefreshCheck,NoWidthAlignmentCheck,NoEdidMaxPClkCheck,NoMaxSizeCheck"
add to /usr/share/X11/xorg.conf.d/10-nvidia*.conf AFTER: Driver "nvidia"


RUN:
mkdir /opt/screenpad
cd /opt/screenpad

DOWNLOAD (into /opt/screenpad):
enable_screenpad.sh
set_screenpad_brightness.sh

RUN:
chmod +x /opt/screenpad/*


MAKE SURE TO SET OPTIMUS TO NVIDIA BEFORE RUNNING
# optimus-manager --switch nvidia --no-confirm

RUN:
chmod +x enable_screenpad.sh
./enable_screenpad.sh

et voilà


# TODO: write about shortcuts

(l8r I will write a completely automated script)




resources and big thanks to:
https://gitlab.com/screenpad-linux/ux480f/-/blob/master/screenpad.sh
https://github.com/Plippo/asus-wmi-screenpad
