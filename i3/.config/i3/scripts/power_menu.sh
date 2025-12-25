#!/bin/bash

I3LOCK_FLAGS=(--blur=1 --clock --indicator --ring-width=15.0 --radius=200 --inside-color=000000aa --ring-color=4C7899FF --line-color=00000000 --date-color=4C7899FF --time-color=4C7899FF --time-str="%I:%M:%S %p" --date-str="%A, %B %d, %Y" --time-font=JetBrainsMono --date-font=JetBrainsMono --verif-font=JetBrainsMono --wrong-font=JetBrainsMono --greeter-font=JetBrainsMono --time-size=40 --date-size=20)

DMENU_FLAGS=(-i -nf '#BBBBBB' -nb '#222222' -sb '#005577' -sf '#EEEEEE' -fn 'Iosevka-12')

chosen=$(echo -e "Shutdown\nReboot\nSuspend\nLock\nLogout\n" | dmenu "${DMENU_FLAGS[@]}" -p "Power Menu:")

if [[ $chosen = "Shutdown" ]]; then
	confirm=$(echo -e "Yes\nNo" | dmenu "${DMENU_FLAGS[@]}" -p "Really shutdown?")
	if [[ $confirm = "Yes" ]]; then
		systemctl poweroff
	fi
elif [[ $chosen = "Reboot" ]]; then
	confirm=$(echo -e "Yes\nNo" | dmenu "${DMENU_FLAGS[@]}" -p "Really Reboot?")
	if [[ $confirm = "Yes" ]]; then
		systemctl reboot
	fi
elif [[ $chosen = "Suspend" ]]; then
	confirm=$(echo -e "Yes\nNo" | dmenu "${DMENU_FLAGS[@]}" -p "Really Suspend?")
	if [[ $confirm = "Yes" ]]; then
		systemctl suspend
	fi
elif [[ $chosen = "Lock" ]]; then
	i3lock --nofork "${I3LOCK_FLAGS[@]}" # or loginctl lock-session
elif [[ $chosen = "Logout" ]]; then
	confirm=$(echo -e "Yes\nNo" | dmenu "${DMENU_FLAGS[@]}" -p "Really Logout?")
	if [[ $confirm = "Yes" ]]; then
		pkill i3
	fi
fi
