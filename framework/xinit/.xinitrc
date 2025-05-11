#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.config/xmodmap/xmodmaprc
sysresources=/etc/X11/xinit/.Xresources
export PATH=$HOME/.local/bin:$PATH
export QT_QPA_PLATFORMTHEME=qt6ct

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

if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/?*.sh; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

if [ -e $XDG_RUNTIME_DIR ]; then
    export SSH_AUTH_SOCK=$XDG_RUNTIME_DIR/gcr/ssh
fi

# start polkit agent
/usr/lib/mate-polkit/polkit-mate-authentication-agent-1 &
# decrease keyboard repeat delay
/usr/bin/xset r rate 300 50 &
# usb automounter
/usr/bin/udiskie &
# increase screen dpi
/usr/bin/xrandr --output eDP-1 --scale 0.85x0.85
# x color management daemon
/usr/bin/xiccd &

exec /usr/bin/i3
