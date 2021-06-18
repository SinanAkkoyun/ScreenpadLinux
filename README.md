# ASUS Screenpad on Linux
My solution to make the Screenpad work! (UX580GE)

INSTALL:
https://github.com/Plippo/asus-wmi-screenpad

RUN:
mkdir /opt/screenpad
cd /opt/screenpad

DOWNLOAD (into /opt/screenpad):
enable_screenpad.sh
set_screenpad_brightness.sh
add_screenpad_brightness.sh
startup_screenpad_service.sh

RUN:
chmod 755 /opt/screenpad/*

RUN:
echo 255 | sudo tee '/sys/class/leds/asus::screenpad/brightness'
//Does your screenpad light up after a few seconds? If yes, AWESOME, you are on the right track!

RUN: (optional, enables all users brightness control)
sudo chmod a+w '/sys/class/leds/asus::screenpad/brightness'
//chmod has to be executed again after every reboot, so it is advisable to add the call to a boot script, e.g. /etc/rc.local.
If you are running Garuda Linux (systemd), create a new service like so (replace vim with your editor):
SPOILER
sudo vim /etc/systemd/system/screenpad.service
PASTE:
[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/opt/screenpad/startup_screenpad_service.sh

[Install]
WantedBy=multi-user.target

RUN:
systemctl enable screenpad.service
systemctl start screenpad.service

//does it work? TODO

From now on echo 255 | tee '/sys/class/leds/asus::screenpad/brightness' will be sufficient, no sudo required

ADD:
Option "ModeValidation" "NoDFPNativeResolutionCheck,NoVirtualSizeCheck,NoMaxPClkCheck,NoHorizSyncCheck,NoEdidDFPMaxSizeCheck,NoVertRefreshCheck,NoWidthAlignmentCheck,NoEdidMaxPClkCheck,NoMaxSizeCheck"
add to /usr/share/X11/xorg.conf.d/10-nvidia*.conf AFTER: Driver "nvidia"


MAKE SURE TO SET OPTIMUS TO NVIDIA BEFORE RUNNING
//optimus-manager --switch nvidia --no-confirm

RUN:
chmod +x enable_screenpad.sh
./enable_screenpad.sh

et voilà

# Controls

change brightness by /opt/screenpad/add_screenpad_brightness.sh +12 or -12 (12 corresponds to about 5% brightness level)

when you manually set the brightness to 0 (/opt/screenpad/set_screenpad_brightness.sh 0), the laptop automatically disconnects the screenpad.
To activate it again you don't need to run enable_screenpad.sh again! Just set the brightness to something above 0!

# TODO: implement enable_screenpad.sh only after optimus NVIDIA has been enabled on login!!!


# TODO: write about shortcuts
you can add shortcuts:
shift+MonitorBrightnessUp  ->  /opt/screenpad/add_screenpad_brightness.sh +12
shift+MonitorBrightnessDown -> /opt/screenpad/add_screenpad_brightness.sh -12

(l8r I will write a completely automated script)




resources and big thanks to:
https://gitlab.com/screenpad-linux/ux480f/-/blob/master/screenpad.sh
https://github.com/Plippo/asus-wmi-screenpad
