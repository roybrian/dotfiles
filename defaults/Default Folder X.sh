#!/bin/sh

plist="${HOME}/Library/Preferences/com.stclairsoft.DefaultFolderX5.plist"

# default to the document's folder in save dialogs
defaults write "$plist" defaultToDocumentFolder -bool true
# use a minimal bezel
defaults write "$plist" toolbarStyle -int 4
# hide menu bar icon and surpress subsequent warning
defaults write "$plist" showStatusItem -bool false
defaults write "$plist" suppressQuitWarnings -bool true
# List folders before files
defaults write "$plist" menusSortFoldersFirst -bool true
# Disable Finder-click
defaults write "$plist" finderClick -bool false
# Don't show extra info below Open dialogs
defaults write "$plist" toolbarShowAttributesOnOpen -bool false
# Don't show extra info below Save dialogs
defaults write "$plist" toolbarShowAttributesOnSave -bool false
# don't enable favorites shortcuts
defaults write "$plist" hotkeysOutsideFileDialogs -bool false
# Open folders in Finder's frontmost window
defaults write "$plist" openInFrontFinderWindow -bool true
# Automatically update
defaults write "$plist" SUEnableAutomaticChecks -bool true
defaults write "$plist" SUAutomaticallyUpdate -bool true
# Animate the toolbar window fade in
defaults write "$plist" bezelFades -bool false
# Animate Finder-click window fade in
defaults write "$plist" finderClickFades -bool false

plutil -convert xml1 "$plist"
# shortcuts
python - "$plist" <<-EOF
	import plistlib
	import sys
	path = sys.argv[1]
	entire_plist = plistlib.readPlist(path)
	if not "keyBindings" in entire_plist:
	    entire_plist["keyBindings"] = []
	for key_binding in entire_plist["keyBindings"]:
	    key_dict = key_binding["key"]
	    if len(key_dict.values()) == 0:
	        continue
	    if key_dict["charactersIgnoringModifiers"] == "":
	        continue
	    key_dict["charactersIgnoringModifiers"] = ""
	    key_dict["keyCode"] = "-1"
	    key_dict["characters"] = ""
	    key_dict["modifierFlags"] = 0
	plistlib.writePlist(entire_plist, path)
EOF
