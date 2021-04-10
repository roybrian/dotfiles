#!/bin/sh

defaults write com.apple.TextEdit NSUserKeyEquivalents -dict-add Bigger -string '@$='
defaults write com.apple.TextEdit NSUserKeyEquivalents -dict-add Smaller -string '@$-'
defaults write com.apple.TextEdit NSUserKeyEquivalents -dict-add "Zoom In" -string '@='
defaults write com.apple.TextEdit NSUserKeyEquivalents -dict-add "Zoom Out" -string '@-'
