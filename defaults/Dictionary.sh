#!/bin/sh

# New Oxford American Dictionary (American English)
# Oxford American Writer's Thesaurus (American English)
# Dictionaries.io Hebrew-English
# Hebrew
# Wikipedia
defaults write 'com.apple.DictionaryServices' DCSActiveDictionaries -array \
	"com.apple.dictionary.NOAD" \
	"com.apple.dictionary.OAWT" \
	"${HOME}/Library/Containers/com.apple.Dictionary/Data/Library/Dictionaries/io.dictionaries.he.dictionary" \
	"com.apple.dictionary.he.oup" \
	"/System/Library/Frameworks/CoreServices.framework/Frameworks/DictionaryServices.framework/Resources/Wikipedia.wikipediadictionary"

# shortcuts
defaults write com.apple.Dictionary NSUserKeyEquivalents -dict-add "Select Next Dictionary" '@~\U2192'
defaults write com.apple.Dictionary NSUserKeyEquivalents -dict-add "Select Previous Dictionary" '@~\U2190'
