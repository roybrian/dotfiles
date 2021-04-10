#!/bin/sh

code=/usr/local/bin/code
settings_sync_extension_id="Shan.code-settings-sync"

if ! "$code" --list-extensions | grep --silent "$settings_sync_extension_id" 1>/dev/null 2>&1; then
	"$code" --install-extension "$settings_sync_extension_id"
fi

defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
defaults write com.microsoft.VSCodeInsiders ApplePressAndHoldEnabled -bool false
