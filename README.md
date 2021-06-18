# ASUS Screenpad on Linux
My solution to make the Screenpad work! (UX580GE)

INSTALL:
https://github.com/Plippo/asus-wmi-screenpad

ADD:
Option "ModeValidation" "NoDFPNativeResolutionCheck,NoVirtualSizeCheck,NoMaxPClkCheck,NoHorizSyncCheck,NoEdidDFPMaxSizeCheck,NoVertRefreshCheck,NoWidthAlignmentCheck,NoEdidMaxPClkCheck,NoMaxSizeCheck"
add to /usr/share/X11/xorg.conf.d/10-nvidia*.conf AFTER: Driver "nvidia"


DOWNLOAD:
enable_screenpad.sh

SET OPTIMUS TO NVIDIA BEFORE RUNNING


chmod +x enable_screenpad.sh
./enable_screenpad.sh

et voilà





resources and thanks to:
https://gitlab.com/screenpad-linux/ux480f/-/blob/master/screenpad.sh
https://github.com/Plippo/asus-wmi-screenpad
