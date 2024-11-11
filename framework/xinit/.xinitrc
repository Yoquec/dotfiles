#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.config/xmodmap/xmodmaprc
sysresources=/etc/X11/xinit/.Xresources
export PATH=$HOME/.local/bin:$PATH
export QT_QPA_PLATFORMTHEME=qt5ct

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f $usermodmap ]; then
    setxkbmap eu
    xmodmap $usermodmap
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

# decrease keyboard repeat delay
xset r rate 300 50 &
# usb automounter
udiskie &
# increase screen dpi
xrandr --output eDP-1 --scale 0.85x0.85
# x color management daemon
xiccd &

# pipewire
/usr/bin/pipewire &
/usr/bin/pipewire-pulse &
/usr/bin/wireplumber &

# bluetooth
/usr/bin/blueberry-tray &

# some other nice programs
nextcloud &
mpd &
redshift &


eval $(ssh-agent) > /dev/null
exec i3
