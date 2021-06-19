# ASUS Screenpad on Linux
My solution to make the Screenpad work! (UX580GE and probably all models with trackpad screenpad)

# Installation

Run the following line in your terminal and install your Screenpad!
```bash
wget https://raw.githubusercontent.com/SinanAkkoyun/ScreenpadLinux/main/installer.sh && chmod +x installer.sh && ./installer.sh
```
Make sure to reboot after installation.

(if you run this again, make sure to manually remove the shortkey group beforehand)

# Update

Go into your .screenpad/ScreenpadLinux directory and run update.sh
```bash
cd ~/.screenpad/ScreenpadLinux
chmod +x update.sh
./update.sh
```

# Finding out adapter names (necessary if model is not UX580GE)
You probably realized that after installation and a reboot the screenpad does not turn on.
It is recommended that you do this *after* installation.
It is time to edit the configuration to make it work!

Open ~/.screenpad/ScreenpadLinux/config.json with your favorite text editor, it should look like this:
```json
{
"intel": "HDMI-1-0",
"nvidia": "HDMI-0"
}
```

Do you see HDMI-1-0 and HDMI-0? You have to change them according to your own system.
In order to find out which names do correlate to what, you first need to change your system to *hybrid* or *integrated*.
```bash
optimus-manager --switch hybrid #or integrated
```
Now disable your screenpad. Run this script in your terminal:
```bash
~/.screenpad/ScreenpadLinux/disable_screenpad.sh
```

Now, either take a look in your GUI display settings or run
```bash
xrandr --query | grep " connected"
```
You should only see your main monitor. Note that name, because **this is the one we will be ignoring**.

Now, enable the screenpad
```bash
~/.screenpad/ScreenpadLinux/enable_screenpad.sh
```
And wait until it has finished. Now run xrandr again
```bash
xrandr --query | grep " connected"
```
**Note down the new connection. This is the intel one**

Repeat this process with Optimus set to NVIDIA
```bash
optimus-manager --switch nvidia
#wait
~/.screenpad/ScreenpadLinux/enable_screenpad.sh
#wait
xrandr --query | grep " connected"
```

**Open ~/.screenpad/ScreenpadLinux/config.json and replace the adapter names to the ones you just noted:**
```json
{
"intel": "youradaptername1",
"nvidia": "youradaptername2"
}
```

You are done! Now go ahead and press the shortcut to activate the Screenpad and enjoy! (Shift+ToggleTouchpad / SHIFT+Fn+F6)

Does it work? Great! Now do the final step and create an issue here on github, put as the title "Data", write me your laptop model number and paste your config.json here! If you do this I can also automate the process you just did! Thank you :)

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


# TODO: Add model support and lookup table
# TODO: Remove old shortcuts
