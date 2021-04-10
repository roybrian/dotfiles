#!/bin/bash

command -v brew 1>/dev/null 2>&1 || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

export HOMEBREW_NO_AUTO_UPDATE=1
export HOMEBREW_UPDATE_REPORT_ONLY_INSTALLED=1

brew=(
	mas
	trash
	duti
	node
	autojump
	fd
	fzf
	blueutil
	ffmpeg
	handbrake
	icdiff
	imagemagick
	ripgrep
	shellcheck
	swiftlint
	swiftformat
	tldr
	# transmission-cli
	unison
	youtube-dl
	zsh-autosuggestions
	zsh-syntax-highlighting
)

brew_cask=(
	dropbox
	1password
	karabiner-elements
	hammerspoon
	launchbar
	contexts
	shifty
	paletro
	iterm2
	visual-studio-code
	qlcolorcode
	qlimagesize
	qlmarkdown
	qlstephen
	qlvideo
	quicklook-json
	font-jetbrains-mono
	appcleaner
	betterzip
	dash
	db-browser-for-sqlite
	dictionaries
	figma
	iina
	istat-menus
	pashua
	pixelsnap
	script-debugger
	sf-symbols
	sketch
	soulver
	toggl-track
	ui-browser
	fantastical
	coteditor
	# cardhop
	# adobe-creative-cloud
	# paw
	# pine
	# kaleidoscope
	# transmit
	# firefox
	# brave-browser
	# fork
	# nova
)

brew install --quiet "${brew[@]}" 2>/dev/null
brew install --quiet --cask "${brew_cask[@]}" 2>/dev/null
