# ASUS Screenpad on Linux
My solution to make the Screenpad work! (UX580GE and probably all models with trackpad screenpad)

# Installation

DISCLAIMER
If something does not work, join this Discord server: https://www.discord.gg/5uXFfsV
When my script does not work for your model, it can very likely just be because of my scripts targeting the wrong display adapter name, just take a look in the Discord Server under useful-links!
It enabled me to even write this

INSTALL:
https://github.com/Plippo/asus-wmi-screenpad
Also install NVIDIA drivers and optimus-manager

# Compatibility test
In order to test compatibility AFTER installing asus-wmi-screenpad, run this:
```bash
echo 255 | sudo tee '/sys/class/leds/asus::screenpad/brightness'
```

Does your screenpads backlight light up after a few seconds (for me, my screen was black but my backlight lit up)? If yes, AWESOME, you are on the right track! If not, my scripts may not work for you, look for the discord linked below.

Create a new directory for your new scripts:
```bash
mkdir /opt/screenpad
cd /opt/screenpad
```

Extract the following files from this repo into /opt/screenpad:
```bash
enable_screenpad.sh
disable_screenpad.sh
toggle_screenpad.sh
set_screenpad_brightness.sh
add_screenpad_brightness.sh
startup_screenpad_service.sh
```

Give all of them permissions to run:
```bash
chmod 755 /opt/screenpad/*
```

Add the following line to /usr/share/X11/xorg.conf.d/10-nvidia*.conf after Driver "nvidia" (replace the old Option line):
```bash
Option "ModeValidation" "NoDFPNativeResolutionCheck,NoVirtualSizeCheck,NoMaxPClkCheck,NoHorizSyncCheck,NoEdidDFPMaxSizeCheck,NoVertRefreshCheck,NoWidthAlignmentCheck,NoEdidMaxPClkCheck,NoMaxSizeCheck"
```

This is my /usr/share/X11/xorg.conf.d/10-nvidia-drm-outputclass.conf for reference:
```bash
Section "OutputClass"
Identifier "nvidia"
MatchDriver "nvidia-drm"
Driver "nvidia"
Option "ModeValidation" "NoDFPNativeResolutionCheck,NoVirtualSizeCheck,NoMaxPClkCheck,NoHorizSyncCheck,NoEdidDFPMaxSizeCheck,NoVertRefreshCheck,NoWidthAlignmentCheck,NoEdidMaxPClkCheck,NoMaxSizeCheck"
ModulePath "/usr/lib/nvidia/xorg"
ModulePath "/usr/lib/xorg/modules"
EndSection
```

# Autostart
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
> shift+MonitorBrightnessUp  ->  /opt/screenpad/add_screenpad_brightness.sh +12
> shift+MonitorBrightnessDown -> /opt/screenpad/add_screenpad_brightness.sh -12
> shift+ToggleTouchpad     ->    /opt/screenpad/toggle_screenpad.sh

I put them into a custom group called "Screenpad" in KDE:
![image](https://user-images.githubusercontent.com/43215895/122568580-6fa91f80-d039-11eb-8379-0e2c1361b0dd.png)

# Reboot

Now reboot your system.

# NVIDIA Optimus
Set your Optimus to NVIDIA. This internally activates the NVIDIA GPU and connects the screenpad. It might be that your model does not have a dedicated NVIDIA GPU, I am working on implementing it.
```bash
optimus-manager --switch nvidia --no-confirm
```

You HAVE TO set it to NVIDIA before using the screenpad, otherwise it won't work. I set my laptop to automatically boot into NVIDIA. (I am working on integrated)

# Start Screenpad

You are done! Yay! In order to enable your screenpad, simply press your custom shortcut (in my case it is SHIFT+Fn+F6).
You should get a notification and after about 5 seconds your screenpad should turn on and just work!
You can press the same shortcut in order to disable it again!

# Controls (CLI, for your own custom scripts)

```bash
# Brightness controll (relative):
/opt/screenpad/add_screenpad_brightness.sh +12/-12
# (12 corresponds to about 5% brightness level)

# Brightness controll (absolute):
/opt/screenpad/set_screenpad_brightness.sh 255 (0-255)
# NOTE: when you set the brightness to 0, the laptop automatically disconnects the screenpad.

# Toggle screenpad on/off:
/opt/screenpad/toggle_screenpad.sh
/opt/screenpad/enable_screenpad.sh
/opt/screenpad/disable_screenpad.sh
```

(l8r I will write a completely automated script)


# Motivation

I struggled to get this to work for about a whole year now. Now I FINALLY got it to work, and it is beautiful.
We don't buy this hardware just to not have it working in linux.
I hope I saved you months or years of struggle with this. Have fun!

Resources and big thanks to:
https://github.com/Plippo/asus-wmi-screenpad
https://www.discord.gg/5uXFfsV
https://gitlab.com/screenpad-linux/ux480f/-/blob/master/screenpad.sh
