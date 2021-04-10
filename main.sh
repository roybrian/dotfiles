#!/bin/bash

_keepalive() {
	while true; do
		sudo -n true
		sleep 60
		kill -0 "$$" || exit
	done 2>/dev/null &
}

install() {
	for f in "$dir/install/"*; do
		echo ">>> $(basename "$f" | sed -E 's/[[:digit:]]+_//')"
		"$f"
	done
}

link() {
	"$dir/link.sh" "$dir/links"
}

config() {
	"$dir/config.sh" "$@"
}

dotfiles_plist=~/Library/Preferences/com.roeybiran.dotfiles.plist
file="$(zsh -c 'echo ${0:A}' "$0")"
dir="$(dirname "$(zsh -c 'echo ${0:A}' "$0")")"

# symlink this file to $PATH
mkdir -p /usr/local/bin/ 2>/dev/null
cd /usr/local/bin || exit
test -e dotfiles && rm dotfiles
ln -sf "$file" dotfiles
if ! test -e dotfiles; then
	echo "Failed to symlink $0 to /usr/local/bin. Aborting"
	exit
fi

cd - &>/dev/null || exit

for arg in "$@"; do
	case "$arg" in
	link)
		link
		;;
	config)
		_keepalive
		config "$dotfiles_plist" "$dir/defaults"
		;;
	install)
		_keepalive
		install
		;;
	bootstrap)
		"$dir/bootstrap.sh" before
		;;
	esac
done

if [ -z "$1" ]; then
	echo "USAGE: dotfiles <command>"
	echo "Available commands:"
	echo "  link             set up symlinks"
	echo "  install          install packages"
	echo "  config           set up defaults"
	echo "  bootstrap        set up defaults"
	exit
fi
