#!/bin/sh

# [ ] Tell macOS to open archives in BetterZip
# [ ] Add a BetterZip button to Finder's toolbar
# [ ] Add services... to the macOS services menu
defaults write com.macitbetter.betterzip MIBFirstStart -int 100
defaults write com.macitbetter.betterzip MIBMoreOptions -bool false
# [✓] Quit after the last window...
defaults write com.macitbetter.betterzip MIBShouldTerminateAfterLastWindowClosed2 -bool true
# [✓] Opening an archive from the Finder immediately extracts it
defaults write com.macitbetter.betterzip MIBDirectExtractByDefault -bool true
# Update automatically
defaults write com.macitbetter.betterzip SUAutomaticallyUpdate -bool true
defaults write com.macitbetter.betterzip SUEnableAutomaticChecks -bool true
defaults write com.macitbetter.betterzip SUHasLaunchedBefore -bool true
# Quick Look
# Dont exapnd packages
defaults write com.macitbetter.betterzip.quicklookgenerator-config showPackageContents -bool false
# Dont show hidden files
defaults write com.macitbetter.betterzip.quicklookgenerator-config showHiddenFiles -bool false
