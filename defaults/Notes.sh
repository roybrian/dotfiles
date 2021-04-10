#!/bin/sh

# check grammar with spelling
defaults write com.apple.Notes ShouldCheckGrammarWithSpelling -bool true
# shortcuts
defaults write com.apple.Notes NSUserKeyEquivalents -dict-add Bigger '@$.'
defaults write com.apple.Notes NSUserKeyEquivalents -dict-add Smaller '@$,'
defaults write com.apple.Notes NSUserKeyEquivalents -dict-add "Zoom In" @=
defaults write com.apple.Notes NSUserKeyEquivalents -dict-add "Zoom Out" @-
defaults write com.apple.Notes NSUserKeyEquivalents -dict-add Strikethrough @^s
