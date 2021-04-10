#!/bin/bash

yn() {
	if test -z "${1}"; then
		echo "Error: no prompt text provided"
		exit 1
	fi

	while true; do
		echo "${1} "
		read -r reply
		test "$reply" = "Y" && exit 0
		test "$reply" = "N" && exit 1
		echo "Invalid option. Try again."
	done
}

dotfiles_plist="${1:?ERR! no dotfiles_plist argument supplied}"
config_files_dir="${2:?ERR! no config_files_dir argument supplied}"

privacy_apps="
/Applications/1Password 7.app > ScreenCapture
/Applications/Contexts.app > Accessibility
/Applications/Dropbox.app > Accessibility
/Applications/Hammerspoon.app > Accessibility SystemPolicyAllFiles
/Applications/iTerm.app > Accessibility SystemPolicyAllFiles DeveloperTool
/Applications/LaunchBar.app > Accessibility SystemPolicyAllFiles ScreenCapture
/Applications/Paletro.app > Accessibility
/Applications/Script Debugger.app > Accessibility SystemPolicyAllFiles
/Applications/UI Browser.app > Accessibility
/Applications/Visual Studio Code.app > Accessibility SystemPolicyAllFiles
/Applications/Xcode.app > Accessibility SystemPolicyAllFiles DeveloperTool
/Library/Application Support/org.pqrs/Karabiner-Elements/bin/karabiner_grabber > kTCCServiceListenEvent
/Library/Application Support/org.pqrs/Karabiner-Elements/bin/karabiner_observer > kTCCServiceListenEvent
/System/Applications/Utilities/Terminal.app > Accessibility SystemPolicyAllFiles DeveloperTool
/System/Library/CoreServices/System Events.app > Accessibility
/System/Library/CoreServices/Sos.app > Accessibility
"

echo '
manual configuration/security
=============================
Notifications
- turn on do not disturb when the display is sleeping and/or screen is locked

Apple ID preferece pane
- Free Downloads: Never Require
- Purchases: Require After 15 minutes

Finder preferences
- tick "Computer" + tick "Hard disks" in the sidebar

Safari preferences
- Websites tab
	- Downloads: allow
	- Location: deny
- Enable Safari Extensions

Dropbox preferences
- General tab
	- Open folders in: Finder
- Backups tab
	- untick "Enable camera uploads for:"...
	- untick "Share screenshots using Dropbox"...

iTerm
- Install the python runtime

Toggle
- log in
'

# Privacy
approve() {
	osascript - "$1" "$2" &>/dev/null <<-EOF
		on run argv
			set theFolder to item 1 of argv
			set theAnchor to item 2 of argv
			tell application "Finder"
					reveal items of (POSIX file theFolder as alias)
					activate
			end tell
			tell application "System Preferences"
					reveal anchor theAnchor of pane id "com.apple.preference.security"
					activate
					authorize current pane
			end tell
		end run
	EOF
}

auth_types=(Accessibility SystemPolicyAllFiles DeveloperTool ListenEvent ScreenCapture)
anchors=(Privacy_Accessibility Privacy_AllFiles Privacy_Accessibility Privacy_Accessibility Privacy_Accessibility)

tccdb="/Library/Application Support/com.apple.TCC/TCC.db"

db_output="$(sqlite3 "$tccdb" "SELECT service, client, auth_value FROM access")"

for ((i = 0; i < ${#auth_types[@]}; i++)); do
	to_approve=()
	auth="${auth_types[i]}"
	filtered="$(echo "$privacy_apps" | grep "$auth")"
	while IFS=$'\n' read -r line; do
		path="$(echo "$line" | cut -d'>' -f1 | sed -E 's/ $//')"
		if test -e "$path"; then
			identifier="$(/usr/libexec/PlistBuddy -c "Print :CFBundleIdentifier" "$path/Contents/Info.plist" 2>/dev/null)"
			test "$?" -ne 0 && identifier="$path" # not all apps have bundle identifier
			if echo "$db_output" | grep -q "kTCCService$auth|$identifier|0"; then
				to_approve+=("$path")
			fi
		fi
	done <<<"${filtered}"
	if [[ "${#to_approve[@]}" -gt 0 ]]; then
		echo "The following apps:"
		printf "%s\n" "${to_approve[@]}"
		read -rp "Require $auth access. Y to proceed, N to skip. " REPLY
		if [[ "$REPLY" == [Yy] ]]; then
			cd "$(mktemp -d)" || exit
			for a in "${to_approve[@]}"; do
				ln -s "$a" .
			done
			approve "$(pwd)" "${anchors[i]}"
		fi
	fi
done

# Make sure File Vault is on
if ! fdesetup status | grep --silent "On"; then
	if yn "FileVault is turned off. Enable in System Preferences? Y = proceed, N = skip."; then
		osascript &>/dev/null <<-EOF
			tell application "System Preferences"
				reveal anchor "FDE" of pane id "com.apple.preference.security"
				authorize current pane
				activate
			end tell
		EOF
		echo "Press any key to continue."
		read -r -n 1
	fi
fi

# require password immediately after sleep or screen saver begins
immediate_screen_lock=$(/usr/libexec/PlistBuddy -c "Print :screenLockHasBeenSet" "$dotfiles_plist" 2>/dev/null)
if [ -z "${immediate_screen_lock}" ]; then
	printf "%s " "To require password [immediately] after sleep or screen saver begins,"
	sysadminctl -screenLock immediate -password -
	/usr/libexec/PlistBuddy -c "Add :screenLockHasBeenSet bool true" "$dotfiles_plist"
fi

for f in "$config_files_dir/"*; do
	echo ">>> $(basename "$f")"
	"$f"
done
