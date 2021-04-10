#!/bin/sh

plist="$HOME/Library/Preferences/com.latenightsw.ScriptDebugger7.plist"

# For New Documents: (·) Use template: AppleScript
defaults write "$plist" PrefDefaultTemplate -string "/Applications/Script Debugger.app/Contents/Library/Templates/AppleScript/AppleScript/AppleScript.sdtemplate"
defaults write "$plist" PrefUseDefaultTemplate -bool true

# Text Substituions: [ ] Enabled
defaults write "$plist" PrefEditorDoTextSubstitution -bool false

# Dont bring to foreground when script ends
defaults write "$plist" PrefActivateOnScriptEnd -bool false

# Dont bring to foreground when script pauses
defaults write "$plist" PrefActivateOnScriptPause -bool false

# Enable automatic updates
defaults write "$plist" SUAutomaticallyUpdate -bool true
defaults write "$plist" SUHasLaunchedBefore -bool true

defaults write "$plist" PrefRelaunchCreateNew -bool false
defaults write "$plist" PrefStartupCreateNew -bool false

/usr/libexec/PlistBuddy -c "Delete LNSUserDefaultsKeyEquivs" "$plist" 2>/dev/null
/usr/libexec/PlistBuddy -c 'Add LNSUserDefaultsKeyEquivs:doComment\::key string "/"' "$plist"
/usr/libexec/PlistBuddy -c 'Add LNSUserDefaultsKeyEquivs:doComment\::mask integer 1048576' "$plist"
/usr/libexec/PlistBuddy -c 'Add LNSUserDefaultsKeyEquivs:doUncomment\::key string "/"' "$plist"
/usr/libexec/PlistBuddy -c 'Add LNSUserDefaultsKeyEquivs:doUncomment\::mask integer 1572864' "$plist"
/usr/libexec/PlistBuddy -c "Add LNSUserDefaultsKeyEquivs:gotoNextTab\::key string \"\\t\"" "$plist"
/usr/libexec/PlistBuddy -c "Add LNSUserDefaultsKeyEquivs:gotoNextTab\::mask integer 262144" "$plist"
/usr/libexec/PlistBuddy -c "Add LNSUserDefaultsKeyEquivs:gotoPrevTab\::key string \"\\t\"" "$plist"
/usr/libexec/PlistBuddy -c "Add LNSUserDefaultsKeyEquivs:gotoPrevTab\::mask integer 393216" "$plist"
