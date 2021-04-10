#!/bin/bash

DATA='
{
  "com.coteditor.CotEditor": ["public.data", "public.text", "public.shell-script", ".nfo"],
  "com.colliderli.iina": [".avi"],
  "net.sourceforge.sqlitebrowser": [".db", ".dsidx"],
  "com.apple.Preview": [".eps", ".pdf"],
  "com.figma.Desktop": [".fig"],
  "com.apple.QuickTimePlayerX": [".m4v", ".mp3"],
  "com.apple.TextEdit": [".nfo", ".txt"],
  "com.wolfrosch.Gapplin": [".svg"]
}'

parsed=$(
	python3 - "$DATA" <<-EOF
		import sys; import json
		parsed = json.loads(sys.argv[1])
		for key in parsed:
		    for uti in parsed[key]:
		        print(key, uti)
	EOF
)

existing_apps=()
nonexisting_apps=()

while IFS=$'\n' read -r line; do
	bundle_id="$(echo "$line" | cut -d' ' -f1)"
	grep -q "$bundle_id" <<<"${nonexisting_apps[@]}" && continue
	if ! grep -q "$bundle_id" <<<"${existing_apps[@]}"; then
		exists=$(
			osascript - "$bundle_id" <<-EOF
				on run argv
					try
						tell app id (item 1 of argv) to version
					end try
				end run
			EOF
		)
		if test -z "$exists"; then
			echo "found unexpected bundle identifier: $bundle_id"
			nonexisting_apps+=("$bundle_id")
		else
			existing_apps+=("$bundle_id")
			uti="$(echo "$line" | cut -d' ' -f2)"
			duti -s "$bundle_id" "$uti" all 2>/dev/null
		fi
	fi
done <<<"$parsed"

# "com.microsoft.VSCode": [
#     ".bash_profile",
#     ".bash",
#     ".bashrc",
#     ".conf",
#     ".css",
#     ".eslintrc",
#     ".fish",
#     ".gitconfig",
#     ".gitignore",
#     ".go",
#     ".html",
#     ".hushlogin",
#     ".js",
#     ".json",
#     ".lua",
#     ".npmrc",
#     ".php",
#     ".pl",
#     ".plist",
#     ".podspec",
#     ".private",
#     ".py",
#     ".rb",
#     ".scss",
#     ".sh",
#     ".toml",
#     ".ts",
#     ".yml",
#     ".zsh",
#     ".zshrc",
#     "Podfile"
#   ],
