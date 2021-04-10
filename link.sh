#!/bin/bash

links_dir="${1:?ERR! No links_dir argument supplied}"
symlink_prefix="_LINK_"
cd "$links_dir" || exit

while IFS=$'\n' read -r line; do
	dst_dir="$(dirname "${line//$links_dir/$HOME}")"
	dst_name="$(basename "${line//$symlink_prefix/}")"
	mkdir -p "$dst_dir" 2>/dev/null
	cd "$dst_dir" || exit
	test -e "$dst_name" && rm "$dst_name"
	ln -sf "$line" "$dst_name"
done < <(find "$(pwd)" -name "$symlink_prefix*")
