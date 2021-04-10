#!/bin/bash

# SAN FRANCISCO FONTS
# not_installed=()
# for font in \
# 	'SF-Pro https://developer.apple.com/design/downloads/SF-Font-Pro.dmg' \
# 	'SF-Compact https://developer.apple.com/design/downloads/SF-Font-Compact.dmg' \
# 	'NewYork https://developer.apple.com/design/downloads/NY-Font.dmg' \
# 	'SF-Mono https://developer.apple.com/design/downloads/SF-Mono.dmg'; do
# 	fontname="$(printf "%s\n" "${font}" | cut -d" " -f1)"
# 	url="$(printf "%s\n" "${font}" | cut -d" " -f2)"
# 	for f in /Library/Fonts/*; do
# 		if [[ "${f}" == *"${fontname}"* ]]; then
# 			continue 2
# 		fi
# 	done
# 	not_installed+=("${url}")
# done
# for url in "${not_installed[@]}"; do
# 	quickinstall "${url}"
# done
