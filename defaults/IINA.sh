#!/bin/sh

# [✓] Quit after all...
defaults write com.colliderli.iina quitWhenNoOpenedWindow -bool true
# [ ] Resume last playback...
defaults write com.colliderli.iina resumeLastPosition -bool false
# [✓] Check for updates [Daily]
defaults write com.colliderli.iina SUEnableAutomaticChecks -bool true
# [✓] Receive beta updates
defaults write com.colliderli.iina receiveBetaUpdate -bool true
# [ ] Play next item automatically
defaults write com.colliderli.iina playlistAutoPlayNext -bool false
# enable automatic updates
defaults write com.colliderli.iina SUAutomaticallyUpdate -bool true
