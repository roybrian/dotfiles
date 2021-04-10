#!/bin/sh

defaults write com.apple.iWork.Keynote NSUserKeyEquivalents -dict-add Bigger '@$.'
defaults write com.apple.iWork.Keynote NSUserKeyEquivalents -dict-add Smaller '@$,'
defaults write com.apple.iWork.Keynote NSUserKeyEquivalents -dict-add "Zoom In" '@='
defaults write com.apple.iWork.Keynote NSUserKeyEquivalents -dict-add "Zoom Out" '@-'
defaults write com.apple.iWork.Keynote NSUserKeyEquivalents -dict-add "New Slide" '@n'
defaults write com.apple.iWork.Keynote NSUserKeyEquivalents -dict-add "Next Slide" -string '@]'
defaults write com.apple.iWork.Keynote NSUserKeyEquivalents -dict-add "Previous Slide" -string '@['
defaults write com.apple.iWork.Keynote NSUserKeyEquivalents -dict-add Group '@g'
defaults write com.apple.iWork.Keynote NSUserKeyEquivalents -dict-add Ungroup '@$g'
