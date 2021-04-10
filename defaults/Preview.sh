#!/bin/sh

# Don't start on the last viewed page when opening documents
defaults write com.apple.Preview kPVPDFRememberPageOption -bool false
# Opening for the first time: Show as [Single Page]
defaults write com.apple.Preferences kPVPDFDefaultPageViewModeOption -bool false
defaults write com.apple.Preview kPVPDFDefaultPageViewModeOption -bool true
# Surpress the PDF cropping alert
defaults write com.apple.Preview PVSupressPDFCroppingAlert -bool true

# shortcuts
defaults write com.apple.Preview NSUserKeyEquivalents -dict-add "Hide Sidebar" @1
defaults write com.apple.Preview NSUserKeyEquivalents -dict-add Thumbnails @2
defaults write com.apple.Preview NSUserKeyEquivalents -dict-add "Table of Contents" @3
defaults write com.apple.Preview NSUserKeyEquivalents -dict-add "Highlights and Notes" @4
defaults write com.apple.Preview NSUserKeyEquivalents -dict-add "Contact Sheet" @6
defaults write com.apple.Preview NSUserKeyEquivalents -dict-add Bookmarks @5
defaults write com.apple.Preview NSUserKeyEquivalents -dict-add "Continuous Scroll" ^1
defaults write com.apple.Preview NSUserKeyEquivalents -dict-add "Single Page" ^2
defaults write com.apple.Preview NSUserKeyEquivalents -dict-add Slideshow @~y
defaults write com.apple.Preview NSUserKeyEquivalents -dict-add "Two Pages" ^3
defaults write com.apple.Preview NSUserKeyEquivalents -dict-add "Go to Page..." '@$G'
defaults write com.apple.Preview NSUserKeyEquivalents -dict-add "Zoom to Fit" @0
defaults write com.apple.Preview NSUserKeyEquivalents -dict-add "Actual Size" @9
