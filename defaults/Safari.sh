#!/bin/sh

# General
# Safari opens with: [All windows from last session]
defaults write com.apple.Safari AlwaysRestoreSessionAtLaunch -bool true
# Remove download list items: [Upon successful download]
defaults write com.apple.Safari DownloadsClearingPolicy -int 2
# [ ] Open safe files after downloading
defaults write com.apple.Safari AutoOpenSafeDownloads -bool false
# [✓] Show website icons in tabs
defaults write com.apple.Safari ShowIconsInTabs -bool true
# Dont autofill username and passwords
defaults write com.apple.Safari AutoFillPasswords -bool false
# Dont autofill credit card data
defaults write com.apple.Safari AutoFillCreditCardData -bool false

# Search
# [ ] Smart Search Field: Show Favorites
defaults write com.apple.Safari ShowFavoritesUnderSmartSearchField -bool false
# Smart Search Field: [✓] Show full website address
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true
# Save reading list item for offline reading automatically
defaults write com.apple.Safari ReadingListSaveArticlesOfflineAutomatically -bool true

# Websites
# don't allow for website to ask for permission to send notifications
defaults write com.apple.Safari CanPromptForPushNotifications -bool false

# Advanced
# [✓] Show Develop menu in menu bar
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari.SandboxBroker ShowDevelopMenu -bool true

# menu bar settings
# don't show favorites bar
defaults write com.apple.Safari ShowFavoritesBar-v2 -bool false
# [✓] Show Tab Bar
defaults write com.apple.Safari AlwaysShowTabBar -bool true
# [✓] Show Status Bar
defaults write com.apple.Safari ShowOverlayStatusBar -bool true
# [✓] Check Grammar With Spelling
defaults write com.apple.Safari WebGrammarCheckingEnabled -bool true
# [✓] Smart Quotes
defaults write com.apple.Safari WebAutomaticQuoteSubstitutionEnabled -bool true
# [✓] Smart Dashes
defaults write com.apple.Safari WebAutomaticDashSubstitutionEnabled -bool true
# [✓] Smart Links
defaults write com.apple.Safari WebAutomaticLinkDetectionEnabled -bool true
# allow javascript from appleevents
defaults write com.apple.Safari AllowJavaScriptFromAppleEvents -bool true

# Make Safari’s search banners default to Contains instead of Starts With *
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false
# Add a context menu item for showing the Web Inspector in web views *
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true
# hide the siri suggestions tooltip?
defaults write com.apple.Safari ForYouExperienceWelcomeViewNumberOfTimesShown -int 5

# shortcuts
defaults write com.apple.Safari NSUserKeyEquivalents -dict-add "Hide Sidebar" @~s
defaults write com.apple.Safari NSUserKeyEquivalents -dict-add "Show Sidebar" @~s
