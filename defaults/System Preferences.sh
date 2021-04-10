#!/bin/bash

# constants
my_login_items=(
	/Applications/Contexts.app
	/Applications/Hammerspoon.app
	/Applications/iTerm.app
	/Applications/LaunchBar.app
	/Applications/Shifty.app
	/Applications/Dropbox.app
)

##################################################################
### General
##################################################################
# Show scroll bars: (·) Always
defaults write -g AppleShowScrollBars -string Always
# don't close windows when quitting an app
defaults write -g NSQuitAlwaysKeepsWindows -bool false

##################################################################
### Desktop & Screen Saver
##################################################################

##################################################################
### Dock & Menu Bar
##################################################################
# always prefer tabs when opening documents
defaults write -g AppleWindowTabbingMode -string always
# automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true
# Show only open applications in the Dock
defaults write com.apple.dock static-only -bool true
# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 3600
# minimize windows using scale effect
defaults write com.apple.dock mineffect -string scale

# Show bluetooth in menu bar
defaults write com.apple.controlcenter "NSStatusItem Visible Bluetooth" -bool false
# Always show sound
defaults write com.apple.controlcenter "NSStatusItem Visible Sound" -bool false
# show battery percentage
echo "TODO: show battery percentage"
# don't show day of the week
# don't show date
defaults write com.apple.menuextra.clock DateFormat -string H:mm
defaults write com.apple.menuextra.clock ShowDayOfMonth -bool false
defaults write com.apple.menuextra.clock ShowDayOfWeek -bool false
# Don't show spotlight
defaults delete com.apple.Spotlight "NSStatusItem Visible Item-0" &>/dev/null

##################################################################
### Mission Control
##################################################################
# group windows by application
defaults write com.apple.dock expose-group-apps -bool true

##################################################################
### Siri
##################################################################
# Enable Ask Siri
defaults write com.apple.assistant.support "Assistant Enabled" -bool true
# Ask Siri in U.S. English (Female)
defaults write com.apple.Siri.SiriTodayExtension AppleLanguages -array en-US
defaults write com.apple.SiriNCService AppleLanguages -array en-US
defaults write com.apple.assistant.backedup "Output Voice" -dict-add Language -string en-US
defaults write com.apple.assistant.backedup "Output Voice" -dict-add Gender -int 2
defaults write com.apple.assistant.backedup "Output Voice v3" -dict-add Language -string en-US
defaults write com.apple.assistant.backedup "Output Voice v3" -dict-add Gender -int 2
defaults write com.apple.assistant.backedup "Session Language" -string en-US
# Keyboard Shortcut: [Off]
defaults write com.apple.Siri HotKeyTag -int 0
defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add 176 "<dict><key>enabled</key><false/></dict>"
# don't show in status bar
defaults write com.apple.systemuiserver "NSStatusItem Visible Siri" -bool false
defaults write com.apple.Siri StatusMenuVisible -bool false

##################################################################
### Language & Region
##################################################################
# Add Hebrew as an input source
defaults write -g AppleLanguages -array en-IL he-IL

##################################################################
### Notifications
##################################################################
# accept repeated calls while in do not disturb
defaults write com.apple.messageshelper.FavoritesController FaceTimeTwoTimeCallthroughEnabled -bool true

##################################################################
### Users & Groups
##################################################################
# dont allow guests to log in to this computer
if ! sysadminctl -guestAccount status 1>/dev/null 2>&1 | grep --silent disabled; then
	sudo sysadminctl -guestAccount off 1>/dev/null 2>&1
fi
# Show input menu in login window
login_window_input_menu=$(defaults read /Library/Preferences/com.apple.loginwindow showInputMenu 2>/dev/null)
if [ -z "$login_window_input_menu" ] || [ "$login_window_input_menu" -eq 0 ]; then
	sudo defaults write /Library/Preferences/com.apple.loginwindow showInputMenu -bool true
fi
# Show fast user switching menu as account name
defaults write -g userMenuExtraStyle -int 1

##################################################################
### Displays
##################################################################
# don't "show mirroring options in the menu bar when available"
# defaults write com.apple.airplay showInMenuBarIfPresent -bool false

##################################################################
### Users & Groups
##################################################################

# returns all registered login items.
# May contain duplicates, invalid apps ("missing value") and trashed apps
unexpected_login_items=$(
	osascript - "${my_login_items[@]}" <<-EOF
		on run argv

		set theInput to items of argv
		set unexpected to {}
		tell application "System Events"
		set theTrash to "/Users/" & name of current user & "/Trash"
		set myItems to items of theInput
		set loginItems to every login item
		set loginItemPaths to path of every login item
		repeat with i from 1 to count myItems
		set myItem to item i of myItems
		if (exists disk item myItem) then
			if (loginItemPaths does not contain myItem) then
				make new login item with properties {hidden:true, path:myItem}
			end if
		else
			-- flag nonexistent apps
			set end of unexpected to item i of myItems
		end if
		end repeat
		set seenItems to {}
		repeat with i from 1 to count loginItems
		set theItem to item i of loginItems
		tell theItem
			-- flag nonexistent apps, remove duplicates
			if path is missing value or path begins with theTrash or seenItems contains path then
				delete theItem
			else
				set hidden to true
				-- flag apps not listed in my list
				if myItems does not contain path then
					set end of unexpected to path
				end if
			end if
			set end of seenItems to path
		end tell
		end repeat
		end tell
		set {saveTID, text item delimiters of AppleScript} to {text item delimiters of AppleScript, {linefeed}}
		return unexpected as text
		set text item delimiters of AppleScript to saveTID
		end run
	EOF
)

if echo "$unexpected_login_items" | grep -E "\w"; then
	echo "Found unexpected login items:"
	echo "$unexpected_login_items"
fi

##################################################################
### Accessibility
##################################################################
# use scroll gesture with modifier keys (⌃⌥⌘) to zoom
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
defaults write com.apple.universalaccess closeViewScrollWheelModifiersInt -integer 1835008
defaults write com.apple.AppleMultitouchTrackpad HIDScrollZoomModifierMask -integer 1835008
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad HIDScrollZoomModifierMask -integer 1835008
# Zoom follows the keyboard focus
defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true
# enable three finger dragging
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -bool true
# enable type to siri
defaults write com.apple.Siri TypeToSiriEnabled -bool true
# disable Zoom, VoiceOver, Sticky Keys, Slow keys, Mouse Keys, Accessibility Keyboard, Invert Display Color
defaults write com.apple.universalaccess axShortcutExposedFeatures -dict \
	feature.displayFilters -bool false \
	feature.invertDisplayColor -bool false \
	feature.mouseKeys -bool false \
	feature.slowKeys -bool false \
	feature.stickyKeys -bool false \
	feature.switchControl -bool false \
	feature.virtualKeyboard -bool false \
	feature.voiceOver -bool false \
	feature.zoom -bool false

##################################################################
### Extensions
##################################################################
# enable finder extensions
defaults write pbs FinderActive -dict \
	APPEXTENSION-com.apple.finder.CreatePDFQuickAction -bool true \
	APPEXTENSION-com.apple.finder.MarkupQuickAction -bool true \
	APPEXTENSION-com.apple.finder.RotateQuickAction -bool true \
	APPEXTENSION-com.apple.finder.TrimQuickAction -bool true

##################################################################
### Security & Privacy
##################################################################
# GENERAL
# approve all quicklook plugins
xattr -d -r com.apple.quarantine ~/Library/QuickLook
# FIREWALL
# turn on firewall
sudo defaults write /Library/Preferences/com.apple.alf globalstate -int 1

##################################################################
### Software Update
##################################################################
# automatically keep Mac up to date
# https://macadminsdoc.readthedocs.io/en/master/Profiles-and-Settings/OS-X-Updates.html
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate.plist AutomaticallyInstallMacOSUpdates -bool true

##################################################################
### Keyboard
##################################################################
# KEYBOARD
# faster key repeat
defaults write -g KeyRepeat -int 6
# shorter delay until repeat
defaults write -g InitialKeyRepeat -int 15
# touch bar shows f1, f2, etc. keys
defaults write com.apple.touchbar.agent PresentationModeGlobal -string functionKeys
# press fn key to show control strip
defaults write com.apple.touchbar.agent PresentationModeFnModes -dict \
	appWithControlStrip -string fullControlStrip \
	functionKeys -string fullControlStrip
# use F1, F2, etc. keys as standard function keys
defaults write -g com.apple.keyboard.fnState -bool true
# Customzie Touch Bar
defaults write com.apple.controlstrip FullCustomized -array NSTouchBarItemIdentifierFlexibleSpace \
	com.apple.system.brightness \
	com.apple.system.mission-control \
	com.apple.system.launchpad \
	com.apple.system.group.keyboard-brightness \
	com.apple.system.group.media \
	NSTouchBarItemIdentifierFlexibleSpace \
	com.apple.system.mute \
	com.apple.system.volume

# TEXT
# Spelling: automatic by language
defaults write -g NSSpellCheckerAutomaticallyIdentifiesLanguages -bool true
# spelling: 1st english, then hebrew
defaults write -g NSPreferredSpellServers '( (en, Apple), (he_IL, Open) )'
defaults write -g NSPreferredSpellServerLanguage -string en
defaults write -g NSPreferredSpellServerVendors -dict en -string Apple
# use smart quotes and dashes
defaults write -g NSAutomaticDashSubstitutionEnabled -bool true
defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool true
# use keyboard navigation to move focus between controls
defaults write -g AppleKeyboardUIMode -int 2

# SHORTCUTS
setkey() {
	index="$1"
	flag="$2"
	param1="$3"
	param2="$4"
	param3="$5"
	defaults write com.apple.symbolichotkeys AppleSymbolicHotKeys -dict-add "$index" \
		"<dict>
		<key>enabled</key>
		<$flag/>
		<key>value</key>
			<dict>
				<key>type</key>
				<string>standard</string>
				<key>parameters</key>
					<array>
						<integer>$param1</integer>
						<integer>$param2</integer>
						<integer>$param3</integer>
					</array>
			</dict>
		</dict>"
}

setkey 10 false 65535 96 8650752
setkey 11 false 65535 97 8650752
setkey 118 false 65535 18 262144
setkey 12 false 65535 122 8650752
setkey 13 false 65535 98 8650752
setkey 15 false 56 28 1572864
setkey 160 false 65535 65535 0
setkey 162 false 65535 96 9961472
setkey 163 false 65535 65535 0
setkey 17 false 61 24 1572864
setkey 175 false 65535 65535 0
setkey 179 false 65535 65535 0
setkey 181 false 54 22 1179648
setkey 182 false 54 22 1441792
setkey 184 false 53 23 1179648
setkey 19 false 45 27 1572864
setkey 21 false 56 28 1835008
setkey 23 false 92 42 1572864
setkey 25 false 46 47 1835008
setkey 26 false 44 43 1835008
setkey 27 false 96 50 1048576
setkey 28 false 51 20 1179648
setkey 29 false 51 20 1441792
setkey 30 false 52 21 1179648
setkey 31 false 52 21 1441792
setkey 32 true 65535 126 8650752
setkey 33 true 65535 125 8650752
setkey 34 true 65535 126 8781824
setkey 35 true 65535 125 8781824
setkey 36 false 65535 103 8388608
setkey 37 false 65535 103 8519680
setkey 51 false 39 50 1572864
# turn dock hiding on/off: OFF
setkey 52 false 100 2 1572864
setkey 53 false 65535 107 8388608
setkey 55 false 65535 107 8912896
setkey 54 false 65535 113 8388608
setkey 56 false 65535 113 8912896
setkey 57 false 65535 100 8650752
setkey 59 false 65535 96 9437184
setkey 60 false 32 49 262144
setkey 61 false 32 49 786432
setkey 62 false 65535 111 8388608
setkey 63 false 65535 111 8519680
# show spotlight search: ⌥SPACE
setkey 64 true 32 49 524288
setkey 65 false 32 49 1572864
setkey 7 false 65535 120 8650752
setkey 79 false 65535 123 8650752
setkey 8 false 65535 99 8650752
setkey 80 false 65535 123 8781824
setkey 81 false 65535 124 8650752
setkey 82 false 65535 124 8781824
setkey 9 false 65535 118 8650752
# show help menu: OFF
setkey 98 false 47 44 1179648

# App Shortcuts
# ----------- #
# the DSL is -> @ = command, $ = shift, ~ = alt, ^ = ctrl
# For individual app shortcuts, see the app's .sh file.
# See also:
# https://ryanmo.co/2017/01/05/setting-keyboard-shortcuts-from-terminal-in-macos/
# http://hints.macworld.com/article.php?story=20131123074223584

# Services
pbslist=~/Library/Preferences/pbs.plist
mylist=~/Library/Preferences/com.roeybiran.dotfiles.plist

test ! -f "$pbslist" && defaults write "$pbslist" NSServicesStatus -dict
test ! -f "$mylist" && defaults write "$mylist" NSServicesStatus -dict

python3 - "$mylist" "$pbslist" <<-EOF
	import plistlib
	import sys

	my_plist_path = sys.argv[1]
	pbs_plist_path = sys.argv[2]

	my_plist_obj = {}
	pbs_plist_obj = {}

	with open(pbs_plist_path, "rb") as pbs_plist_fp, open(my_plist_path, "rb") as my_plist_fp:
	    pbs_plist_obj = plistlib.load(pbs_plist_fp)
	    my_plist_obj = plistlib.load(my_plist_fp)

	    system_services = pbs_plist_obj.get("NSServicesStatus", {}).keys()
	    my_services = my_plist_obj.get("NSServicesStatus", [])

	    union = set(system_services) | set(my_services)

	    for service in union:
	        pbs_plist_obj["NSServicesStatus"][service] = {
	            "enabled_context_menu": False,
	            "enabled_services_menu": False,
	            "key_equivalent": "",
	            "presentation_modes": {
	                "ContextMenu": False,
	                "ServicesMenu": False,
	                "TouchBar": False,
	            },
	        }

	    my_plist_obj["NSServicesStatus"] = list(union)

	with open(pbs_plist_path, "wb") as pbs_plist_fp, open(my_plist_path, "wb") as my_plist_fp:
	    # update my file
	    plistlib.dump(my_plist_obj, my_plist_fp)
	    # write the system file
	    plistlib.dump(pbs_plist_obj, pbs_plist_fp)
EOF

# INPUT SOURCES
defaults write com.apple.HIToolbox AppleEnabledInputSources '(
	{ InputSourceKind = "Keyboard Layout"; "KeyboardLayout ID" = 252; "KeyboardLayout Name" = ABC; },
	{ InputSourceKind = "Keyboard Layout"; "KeyboardLayout ID" = "-18432"; "KeyboardLayout Name" = Hebrew; },
	{ "Bundle ID" = "com.apple.PressAndHold"; InputSourceKind = "Non Keyboard Input Method"; },
	{ "Bundle ID" = "com.apple.CharacterPaletteIM"; InputSourceKind = "Non Keyboard Input Method"; },
	{ "Bundle ID" = "com.apple.inputmethod.EmojiFunctionRowItem"; InputSourceKind = "Non Keyboard Input Method"; }
)'
# hebrew: dont use split cursor
defaults write -g NSUseSplitCursor -bool false
# hebrew: enable keyboard shortcuts
defaults write -g NSAllowsBaseWritingDirectionKeyBindings -bool true

# DICTATION
# shortcut: OFF
setkey 164 false 65535 65535 0

##################################################################
### Trackpad
##################################################################
trackpadsetting() {
	for domain in com.apple.AppleMultitouchTrackpad com.apple.driver.AppleBluetoothMultitouch.trackpad; do
		defaults write "$domain" "$1" "$2" "$3"
	done
}

# POINT & CLICK
# Loop up and data detectors: tap with 3 fingers
trackpadsetting TrackpadThreeFingerTapGesture -int 2
# enable tap to click
trackpadsetting Clicking -bool true

# SCROLL & ZOOM
# disable "natural" scroll
defaults write -g com.apple.swipescrolldirection -bool false

# MORE GESTURES
# swipe between pages: off
defaults write -g AppleEnableSwipeNavigateWithScrolls -bool false
# swipe between full screen apps: off
trackpadsetting TrackpadFourFingerHorizSwipeGesture -int 0
trackpadsetting TrackpadThreeFingerHorizSwipeGesture -int 0
# notification center: off
trackpadsetting TrackpadTwoFingerFromRightEdgeSwipeGesture -int 0
# mission control: off
defaults write com.apple.dock showMissionControlGestureEnabled -bool false
trackpadsetting TrackpadFourFingerVertSwipeGesture -int 0
trackpadsetting TrackpadThreeFingerVertSwipeGesture -int 0
# Launchpad: off
defaults write com.apple.dock showLaunchpadGestureEnabled -bool false
# show desktop: off
defaults write com.apple.dock showDesktopGestureEnabled -bool false
trackpadsetting TrackpadFiveFingerPinchGesture -int 0
trackpadsetting TrackpadFourFingerPinchGesture -int 0

##################################################################
### Mouse
##################################################################
mousesetting() {
	for domain in com.apple.AppleMultitouchMouse com.apple.driver.AppleBluetoothMultitouch.mouse; do
		defaults write "$domain" "$1" "$2" "$3"
	done
}

# POINT & CLICK
# disable natural scroll direction
# ...see trackpad preference pane
# secondary click: click on right side
mousesetting MouseButtonMode -string TwoButton
# enable smart zoom
mousesetting MouseOneFingerDoubleTapGesture -int 1

# MORE GESTURES
# Swipe between pages: swipe left or right with one finger
defaults write -g AppleEnableMouseSwipeNavigateWithScrolls -bool true
# disable swipe between full screen apps
mousesetting MouseTwoFingerHorizSwipeGesture -int 0
# Disable mission control
mousesetting MouseTwoFingerDoubleTapGesture -int 0

##################################################################
### Battery
##################################################################
# Enable Power Nap (while on battery power)
sudo pmset -a powernap 1
