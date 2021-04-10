#!/bin/sh

# don't show alternate calenda
defaults write com.apple.iCal CALPrefOverlayCalendarIdentifier -string ""
# show calendar list
defaults write com.apple.iCal CalendarSidebarShown -bool true
# shortcuts
defaults write com.apple.iCal NSUserKeyEquivalents -dict-add "Go to Date..." -string '@$g'
