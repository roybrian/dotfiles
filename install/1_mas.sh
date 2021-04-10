#!/bin/bash

yn() {
	if test -z "${1}"; then
		echo "Error: no prompt text provided"
		exit 1
	fi

	while true; do
		echo "${1} "
		read -r reply
		test "$reply" = "Y" && return 0
		test "$reply" = "N" && return 1
		echo "Invalid option. Try again."
	done
}

mas_apps=(
	# Vimari
	1480933944
	# WhatsApp
	1147396723
	# Wipr
	1320666476
	# Dato
	# 147058410
	# Dark Reader for Safari
	1438243180
	# Select Like A Boss For Safari
	1437310115
	# TranslateMe
	1448316680
	# Xcode
	497799835
	# Savant TrueControl
	455233190
	# CommentHere
	1406737173
	# Keynote
	409183694
	# Pages
	409201541
	# Numbers
	409203825
	# Developer
	640199958
	# Hush
	154474390
	# Shareful
	1522267256
	# inddPreview
	1153435308
	# ColorSlurp
	# 1287239339
)

# mas
if ! mas account 1>/dev/null 2>&1; then
	if yn "Pause until Mac App Store sign-in is performed? Y = wait, N = continue"; then
		read -r -p "Pausing, press any key to continue." -n 1 && echo ""
	fi
fi

current="$(mas list)"
for pkg in "${mas_apps[@]}"; do
	echo "$current" | grep -q "$pkg" || mas install "$pkg" 2>/dev/null
done
