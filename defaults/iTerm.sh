#!/bin/sh

# Specify the preferences directory
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "$HOME/Library/Application Support/iTerm2/Config"
# Tell iTerm2 to use the custom preferences in the directory
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
defaults write com.googlecode.iterm2 NeverWarnAboutMeta_selection -int 0
defaults write com.googlecode.iterm2 NeverWarnAboutOverrides_selection -int 0
defaults write com.googlecode.iterm2 NoSyncEnableAPIServer -bool true
defaults write com.googlecode.iterm2 NoSyncHaveUsedCopyMode -bool true
defaults write com.googlecode.iterm2 NoSyncNeverRemindPrefsChangesLostForFile -bool true
defaults write com.googlecode.iterm2 NoSyncNeverRemindPrefsChangesLostForFile_selection -int 0
defaults write com.googlecode.iterm2 NoSyncOnboardingWindowHasBeenShown -bool true
defaults write com.googlecode.iterm2 NoSyncOpenNewPythonScriptInDefaultEditor -bool true
defaults write com.googlecode.iterm2 NoSyncOpenNewPythonScriptInDefaultEditor_selection -int 0
defaults write com.googlecode.iterm2 NoSyncPermissionToShowTip -bool false
defaults write com.googlecode.iterm2 NoSyncSuppressMissingProfileInArrangementWarning -bool true
defaults write com.googlecode.iterm2 NoSyncSuppressRestartSessionConfirmationAlert -bool true
defaults write com.googlecode.iterm2 NoSyncSuppressRestartSessionConfirmationAlert_selection -int 0
defaults write com.googlecode.iterm2 NoSyncTipsDisabled -bool true
defaults write com.googlecode.iterm2 NeverWarnAboutMeta -bool true
defaults write com.googlecode.iterm2 NeverWarnAboutOverrides -bool true
defaults write com.googlecode.iterm2 SUEnableAutomaticChecks -bool true
defaults write com.googlecode.iterm2 SUHasLaunchedBefore -bool true
defaults write com.googlecode.iterm2 SUSendProfileInfo -bool false
defaults write com.googlecode.iterm2 HideFromDockAndAppSwitcher -bool true
defaults write com.googlecode.iterm2 HideTabNumber -bool true
defaults write com.googlecode.iterm2 StretchTabsToFillBar -bool false
defaults write com.googlecode.iterm2 TabsHaveCloseButton -bool false
