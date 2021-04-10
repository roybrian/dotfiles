#!/bin/sh

# postpone screen sleep while reading
defaults write com.apple.iBooksX BKPreventScreenDimmingPreferenceKey -bool true
# view as list
defaults write com.apple.iBooksX BKBookshelfListModeKey -bool true
# dont auto hyphenate
defaults write com.apple.iBooksX BKAutoHyphenatePreferenceKey -bool false
# let lines break naturally
defaults write com.apple.iBooksX BKJustificationPreferenceKey -bool false
# app shortcuts
defaults write com.apple.iBooksX NSUserKeyEquivalents -dict-add "Book Store Home" '@$h'
defaults write com.apple.iBooksX NSUserKeyEquivalents -dict-add "Show Table of Contents" '@~s'
defaults write com.apple.iBooksX NSUserKeyEquivalents -dict-add Library '@$l'
