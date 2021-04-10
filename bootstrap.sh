#!/bin/sh

yn() {
	if test -z "${1}"; then
		echo "Error: no prompt text provided"
		exit 1
	fi

	while true; do
		echo "${1} "
		read -r reply
		test "$reply" = "Y" && exit 0
		test "$reply" = "N" && exit 1
		echo "Invalid option. Try again."
	done
}

choose_drive() {
	_target_drive=$(
		osascript - "$1" <<-EOF
			on run argv
				set targetDrive to choose folder with prompt (item 1 of argv) default location (alias "Macintosh HD:Volumes:")
				return POSIX path of targetDrive
			end run
		EOF
	)
	echo "${_target_drive}"
}

before_reinstall() {
	macos_version="Big Sur"
	macos_download_id=

	test -z macos_download_id && echo "No macOS Download ID!" && exit 1

	# https://support.apple.com/en-il/HT202796
	# https://support.apple.com/en-us/HT201372
	echo "Ignition: Phase 1"
	echo 'Prepare a flash drive with at least 12GB of space, formatted as "Mac OS Extended".'
	echo "Press any key to continue. " && read -r && echo ""
	if ! printf "%s\n" "/Applications/"* | grep -iq "install macos"; then
		echo "Open the Mac App Store to download macOS $macos_version, and wait for it to finish?"
		if yn 'This will create the necessary "Install macOS" bundle. Y = Yes, N = skip.'; then
			open "macappstores://itunes.apple.com/app/$macos_download_id"
			echo "Press any key to continue. " && read -r && echo ""
		fi
	fi

	if yn "Create installation media? Y = Yes, N = Skip"; then
		sleep 0.5 # allow for time to breath before applescript dialog
		_target_drive="$(choose_drive "Select the target disk/volume for the installation media")"
		path="$(printf "%s\n" "/Applications/"* | grep -i "Install macOS")"
		if [ -n "$path" ]; then
			sudo "$path/Contents/Resources/createinstallmedia" --volume "$_target_drive"
		fi
	fi

	if yn "Cache Homebrew (+ cask) packages? Y = Yes, N = Skip"; then
		brew fetch $(brew list --formula | tr '\n' ' ')
		brew fetch --cask $(brew list --cask | tr '\n' ' ')
	fi

	if yn "Copy Homebrew caches to the external drive?"; then
		brew_caches_dir="$(choose_drive "Select the copy destination for the Homebrew caches")"
		# copy brew cache directories
		rsync --archive --human-readable --progress "$HOME/Library/Caches/Homebrew/" "$brew_caches_dir"
	fi

	echo "Done. Press and hold the OPTION key immediately after boot and choose the newly created volume as the startup disk."
	echo 'Once finished, open terminal and run:'
	echo "git clone https://github.com/roeybiran/dotfiles && sh ./dotfiles/dotfiles.sh ignition"
}

after_reinstall() {
	if yn "Copy Homebrew caches to ~/Library/Caches/Homebrew?"; then
		brew_cache_src="$(choose_drive "Select the folder containing the copied Homebrew cache")"
		brew_cache_dst="$HOME/Library/Caches/Homebrew"
		mkdir -p "$brew_cache_dst"
		rsync --archive --human-readable --progress --quiet "$brew_cache_src/" "$brew_cache_dst"
	fi
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	brew install --cask dropbox
	open -a Dropbox
}

if [ "$1" = "before" ]; then
	before_reinstall
else
	after_reinstall
fi
