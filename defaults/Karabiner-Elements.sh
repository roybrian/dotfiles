#!/bin/sh

if ! launchctl list | grep --silent "org.pqrs.karabiner.karabiner_console_user_server"; then
	open -a "Karabiner-Elements"
	sleep 2
	killall "Karabiner-Elements"
fi

# start on login
launchctl kickstart -k "gui/$(id -u)/org.pqrs.karabiner.karabiner_console_user_server"
