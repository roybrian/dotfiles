#!/bin/sh

defaults write com.sindresorhus.Dato showDateInMenuBar -bool true
defaults write com.sindresorhus.Dato showWeekDayInMenuBar -bool true
defaults write com.sindresorhus.Dato showMonthInMenuBar -bool false
defaults write com.sindresorhus.Dato showTimeInMenuBar -bool false
defaults write com.sindresorhus.Dato indicateEventsInCalendar -string '"maxThree"'
defaults write com.sindresorhus.Dato iconInMenuBar -string '"none"'

# skip onboarding
defaults write com.sindresorhus.Dato SS_App_runOnce__bigSurWarningNoWayToTurnOffSystemClock -bool true
defaults write com.sindresorhus.Dato SS_App_runOnce__bigSurWelcomeMessage -bool true
defaults write com.sindresorhus.Dato SS_App_runOnce__dato-v2-menu-bar-clocks -bool true
defaults write com.sindresorhus.Dato SS_App_runOnce__migrateIconOnlyPreference -bool true
defaults write com.sindresorhus.Dato SS_App_runOnce__migrateTimeWithSecondsInMenu -bool true
defaults write com.sindresorhus.Dato SS_App_runOnce__migrateToTogglableMenuDateComponentsPreference -bool true
defaults write com.sindresorhus.Dato SS_App_runOnce__showTimeZoneAddSheetFirstTime -bool true
