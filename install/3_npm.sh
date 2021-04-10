#!/bin/bash

npm_apps=(
	htmlhint
	speed-test
)

for p in "${npm_apps[@]}"; do
	npm list -g "$p" 1>/dev/null 2>&1 || npm i -g "$p"
done
