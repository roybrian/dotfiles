#!/bin/sh

# shortcuts
defaults write com.apple.iWork.Numbers NSUserKeyEquivalents -dict-add "Align Center" -string '@$\'
defaults write com.apple.iWork.Numbers NSUserKeyEquivalents -dict-add "Align Left" -string '@$['
defaults write com.apple.iWork.Numbers NSUserKeyEquivalents -dict-add "Align Right" -string '@$]'
