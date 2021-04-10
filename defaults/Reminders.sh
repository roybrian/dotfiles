#!/bin/sh

# shortcuts
defaults write com.apple.reminders NSUserKeyEquivalents -dict-add "Hide Sidebar" @~s
defaults write com.apple.reminders NSUserKeyEquivalents -dict-add Flag '@$l'
defaults write com.apple.reminders NSUserKeyEquivalents -dict-add "Clear Flag" '@$l'
