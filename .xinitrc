#!/bin/sh
# ==============================================================================
# = paradigm's .xinitrc                                                        =
# ==============================================================================

# Use a solid black background.
xsetroot -solid "#000000"

# set dpi
xrandr --dpi 96

# Remap caps_lock act like ctrl.
xmodmap -e "clear Lock"
xmodmap -e "keycode 0x42 = Control_L"
xmodmap -e "add Control = Control_L"

# Disable the system beep.
xset s off

# This is required for qgtkstyle.
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

# add 100dpi fonts to PATH, fixes steam
xset +fp /usr/share/fonts/X11/100dpi
# adds arch's terminus font to font sources irrelevant of who provides Xorg
if [ -e /bedrock/clients/arch/usr/share/fonts/local/fonts.dir ]
then
	xset +fp /bedrock/clients/arch/usr/share/fonts/local
fi

if [ "$(uname -n)" = "am" ]
then
	rmmouse&
	xbacklight -set 30%
fi

if [ "$(conctl --state xorg)" = "starting" ]
then
	conctl k USR1 xorg >/dev/null 2>&1
elif which dwm >/dev/null 2>&1
then
	dwm &
	dwmstatus &
elif which openbox >/dev/null 2>&1
then
	openbox &
else
	xterm &
fi

# Do not close X11 automatically when the window manager closes.
mkfifo ~/.block
while read PAUSE < ~/.block; do true; done
