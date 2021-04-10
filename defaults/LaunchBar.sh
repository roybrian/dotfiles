#!/bin/sh

# Show all subtitles
defaults write at.obdev.LaunchBar ShowItemListSubtitles -bool true
# visible rows in abbreviation search
defaults write at.obdev.LaunchBar ItemListVisibleRows -int 32
# visible rows while browsing
defaults write at.obdev.LaunchBar ItemListVisibleRowsWhileBrowsing -int 64
# don't always show abbreviation
defaults write at.obdev.LaunchBar ShowAbbreviation -bool false
# [ ] Search in Spotlight
defaults write at.obdev.LaunchBar SpotlightHotKeyEnabled -bool false
# Instant Send: [Double Shift]
defaults write at.obdev.LaunchBar ModifierTapInstantSend -int 24
# instant info browsing
defaults write at.obdev.LaunchBar InstantInfoBrowsing -bool true
###
### ACTIONS
###
### DEFAULT ACTIONS
# instant-open folders: browse in LaunchBar
defaults write at.obdev.LaunchBar InstantOpenBrowseFolders -bool true
# open applescripts with editor
defaults write at.obdev.LaunchBar RunAppleScripts -bool false
# open automator workflows with automator
defaults write at.obdev.LaunchBar RunWorkflows -bool false
# implement a custom applescript that clicks the "Call" button after choosing the number
defaults write at.obdev.LaunchBar PhoneHandler -string "$HOME/Library/Application Support/LaunchBar/Actions/contacts-call-with-iphone.lbaction"
### OPTIONS
# [✓] Show files and folders in currnet Finder window
defaults write at.obdev.LaunchBar UseCurrentFileBrowserWindow -bool true
# preferred file browser: finder
defaults write at.obdev.LaunchBar PreferredFileBrowser -int 1
# create emails with Mail
defaults write at.obdev.LaunchBar EmailHandler -string com.apple.mail
# preferred terminal: iterm
defaults write at.obdev.LaunchBar PreferredTerminal -int 1
# play songs: play single song
defaults write at.obdev.LaunchBar SongPlaybackMode -int 2
###
### CALCULATOR
###
# don't switch to calculator when typing digits
defaults write at.obdev.LaunchBar SwitchToCalculatorAutomatically -bool false
# clipboard capacity: 1 week
defaults write at.obdev.LaunchBar ClipboardHistoryCapacity -string -7
# enable clipmerge
defaults write at.obdev.LaunchBar ClipMergeEnabled -bool true
# make the clipboard ignore apps
defaults write at.obdev.LaunchBar ClipboardHistoryIgnoreApplicationsEnabled -bool true
# ignore these apps in clipboard history
defaults write at.obdev.LaunchBar ClipboardHistoryIgnoreApplications -array com.apple.keychainaccess com.agilebits.onepassword
# [✓] Show clipboard history: ⌃⌥⇧⌘V
defaults write at.obdev.LaunchBar ShowClipboardHistoryHotKey -string 6912@9
defaults write at.obdev.LaunchBar ShowClipboardHistoryHotKeyEnabled -bool false
# [ ] Select from history
defaults write at.obdev.LaunchBar SelectFromClipboardHistoryHotKeyEnabled -bool false
# [ ] Paste and remove from history
defaults write at.obdev.LaunchBar PasteClipboardHistoryHotKeyEnabled -bool false
# [✓] Abbreviate home folder with ~ in copied paths
defaults write at.obdev.LaunchBar AbbreviateFilePaths -bool false
# [✓] Convert filename extension to lowercase when renaming
defaults write at.obdev.LaunchBar RenameConvertsExtensionToLowercase -bool true
# [ ] Show Dock Icon
defaults write at.obdev.LaunchBar ShowDockIcon -bool false
# Preferred input source: [ABC]
defaults write at.obdev.LaunchBar PreferredKeyboardInputSource -string com.apple.keylayout.ABC
# Skip the welcome window
defaults write at.obdev.LaunchBar WelcomeWindowVersion -int 2
# snippets
defaults write at.obdev.LaunchBar SnippetsHotKey -string 6912@27
defaults write at.obdev.LaunchBar SnippetsHotKeyEnabled -bool false
