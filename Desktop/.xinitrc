#!/bin/sh

userresources=$HOME/.Xresources  sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap
# usermodmap=$HOME/scripts/xmodmap

# merge in defaults and keymaps
setxkbmap eu
xset r rate 350 70

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi


if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# see https://unix.stackexchange.com/a/295652/332452
source /etc/X11/xinit/xinitrc.d/50-systemd-user.sh

# see https://wiki.archlinux.org/title/GNOME/Keyring#xinitrc
eval $(/usr/bin/gnome-keyring-daemon --start)
export SSH_AUTH_SOCK

# Setup the ssh authentication agent
eval $(ssh-agent)

# see https://github.com/NixOS/nixpkgs/issues/14966#issuecomment-520083836
mkdir -p "$HOME"/.local/share/keyrings

# Env variables
export PATH="${PATH}:${HOME}/.local/bin:${HOME}/go/bin:${HOME}/.ghcup/bin:${HOME}.dotnet/tools"
export QT_QPA_PLATFORMTHEME=qt5ct

# Start window manager
/usr/lib/xfce-polkit/xfce-polkit &
exec i3
