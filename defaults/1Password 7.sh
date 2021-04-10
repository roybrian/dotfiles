#!/bin/sh

for plist in "$HOME/Library/Group Containers/"*".com.agilebits/Library/Preferences/"*".com.agilebits.plist" \
	"$HOME/Library/Containers/com.agilebits.onepassword7/Data/Library/Preferences/com.agilebits.onepassword7.plist"; do
	test -f "$plist" || continue
	# hide in menu bar
	defaults write "$plist" ShowStatusItem -bool false
	# don't lock on sleep
	defaults write "$plist" LockOnSleep -bool false
	# don't lock when screen saver is activated
	defaults write "$plist" LockOnScreenSaver -bool false
	# don't lock when fast user switching
	defaults write "$plist" LockOnUserSwitch -bool false
	# don't lock after computer is idle for [5] minutes
	defaults write "$plist" LockOnIdle -bool false

	# Lock 1Password
	/usr/libexec/PlistBuddy -c 'Delete :"ShortcutRecorder GlobalLock"' "$plist" 1>/dev/null 2>&1
	/usr/libexec/PlistBuddy -c 'Add :"ShortcutRecorder GlobalLock" dict' "$plist"
	/usr/libexec/PlistBuddy -c 'Add :"ShortcutRecorder GlobalLock":keyCode integer -1' "$plist"
	/usr/libexec/PlistBuddy -c 'Add :"ShortcutRecorder GlobalLock":modifierFlags integer 0' "$plist"
	/usr/libexec/PlistBuddy -c 'Add :"ShortcutRecorder GlobalLock":modifiers integer 0' "$plist"

	# Fill Login or Show 1Password: ⌃⌥⌘⇧\
	/usr/libexec/PlistBuddy -c 'Delete :"ShortcutRecorder BrowserActivation"' "$plist" 1>/dev/null 2>&1
	/usr/libexec/PlistBuddy -c 'Add :"ShortcutRecorder BrowserActivation" dict' "$plist"
	/usr/libexec/PlistBuddy -c 'Add :"ShortcutRecorder BrowserActivation":keyChars string \\034' "$plist"
	/usr/libexec/PlistBuddy -c 'Add :"ShortcutRecorder BrowserActivation":keyCharsIgnoringModifiers string |' "$plist"
	/usr/libexec/PlistBuddy -c 'Add :"ShortcutRecorder BrowserActivation":keyCode integer 42' "$plist"
	/usr/libexec/PlistBuddy -c 'Add :"ShortcutRecorder BrowserActivation":modifierFlags integer 1966080' "$plist"
	/usr/libexec/PlistBuddy -c 'Add :"ShortcutRecorder BrowserActivation":modifiers integer 6912' "$plist"

	# Show 1Password: ⌃⌥⌘⇧'
	/usr/libexec/PlistBuddy -c 'Delete :"ShortcutRecorder GlobalActivation"' "$plist" 1>/dev/null 2>&1
	/usr/libexec/PlistBuddy -c 'Add :"ShortcutRecorder GlobalActivation" dict' "$plist"
	/usr/libexec/PlistBuddy -c 'Add :"ShortcutRecorder GlobalActivation":keyChars string '"\'" "$plist"
	/usr/libexec/PlistBuddy -c 'Add :"ShortcutRecorder GlobalActivation":keyCharsIgnoringModifiers string \"' "$plist"
	/usr/libexec/PlistBuddy -c 'Add :"ShortcutRecorder GlobalActivation":keyCode integer 39' "$plist"
	/usr/libexec/PlistBuddy -c 'Add :"ShortcutRecorder GlobalActivation":modifierFlags integer 1966080' "$plist"
	/usr/libexec/PlistBuddy -c 'Add :"ShortcutRecorder GlobalActivation":modifiers integer 6912' "$plist"

done
