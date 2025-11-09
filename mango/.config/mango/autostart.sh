#! /bin/bash

set +e

systemctl --user set-environment XDG_CURRENT_DESKTOP=wlroots; systemctl --user import-environment WAYLAND_DISPLAY; systemctl --user start xdg-desktop-portal-wlr.service

# Wallpaper daemon
swww-daemon &

# Keep clipboard content
wl-clip-persist --clipboard regular --reconnect-tries 0 &

# Clipboard content manager
wl-paste --type text --watch cliphist store & 

# Default text scaling 
gsettings set org.gnome.desktop.interface text-scaling-factor

# Permission authentication
/usr/lib/polkit-kde-authentication-agent-1 &

# Use Dms shell
dms run &
