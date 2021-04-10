#!/bin/sh

# sync folder
defaults write com.kapeli.dashdoc syncFolderPath -string "$HOME/Library/Application Support/Dash/sync"
# snippets file
defaults write com.kapeli.dashdoc snippetSQLPath -string "$HOME/Library/Application Support/Dash/sync/snippets.dash"
# syncing options
defaults write com.kapeli.dashdoc shouldSyncBookmarks -bool true
defaults write com.kapeli.dashdoc shouldSyncDocsets -bool true
defaults write com.kapeli.dashdoc shouldSyncGeneral -bool true
defaults write com.kapeli.dashdoc shouldSyncView -bool true
# Surpress the docsets tooltip
defaults write com.kapeli.dashdoc DHNotificationDocsetPressEnterOrClickIconTip -bool true
# Surpress table of contexts tooltip
defaults write com.kapeli.dashdoc DHNotificationTableOfContentsTip -bool true
# Surpress nested contents tooltip
defaults write com.kapeli.dashdoc DHNotificationNestedResultTip -bool true
# surpress find in page tooltip
defaults write com.kapeli.dashdoc DHNotificationFindTip -bool true
# surpress the menu bar icon tooltip
defaults write com.kapeli.dashdoc didShowStatusIconHello -bool true
# surpress unofficial repos warning
defaults write com.kapeli.dashdoc userContributedRepoUnlocked -bool true
defaults write com.kapeli.dashdoc githubRepoUnlocked -bool true
defaults write com.kapeli.dashdoc stackOverflowRepoUnlocked -bool true
# dark style for docs
defaults write com.kapeli.dashdoc actuallyDarkWebView -bool true
# Automatically update
defaults write com.kapeli.dashdoc SUAutomaticallyUpdate -bool true
defaults write com.kapeli.dashdoc SUEnableAutomaticChecks -bool true
defaults write com.kapeli.dashdoc SUHasLaunchedBefore -bool true
# shortcuts
defaults write com.kapeli.dashdoc NSUserKeyEquivalents -dict-add "Show Bookmarks..." @~b
