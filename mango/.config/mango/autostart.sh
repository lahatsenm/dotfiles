#! /bin/bash

set +e

systemctl --user set-environment XDG_CURRENT_DESKTOP=wlroots; systemctl --user import-environment WAYLAND_DISPLAY; systemctl --user start xdg-desktop-portal-wlr.service

# notify
#dunst -config ~/.config/dunst/mango/dunstrc &

# night light
#wlsunset -T 3501 -t 3500 &

# wallpaper daemon
swww-daemon &

# status bar
#waybar -c ~/.config/waybar/mango/config -s ~/.config/waybar/mango/style.css &

# keep clipboard content
wl-clip-persist --clipboard regular --reconnect-tries 0 &

# clipboard content manager
wl-paste --type text --watch cliphist store & 

# default text scaling 
gsettings set org.gnome.desktop.interface text-scaling-factor

# Permission authentication
/usr/lib/polkit-kde-authentication-agent-1 &

# Network Manager
#nm-applet --indicator &
#systemctl start NetworkManager

# idle daemon
#hypridle &

# Use Dms shell
dms run &
