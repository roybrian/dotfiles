#!/bin/sh

defaults write org.darkreader.DarkReaderSafari.DarkReader shortcut_toggleCurrentSite -string Alt+Ctrl+Meta+KeyD
defaults write org.darkreader.DarkReaderSafari.DarkReader enabledByDefault -bool false
defaults write org.darkreader.DarkReaderSafari.DarkReader siteListEnabled -array \
	he.wikipedia.org \
	en.wikipedia.org \
	google.com \
	stackoverflow.com
