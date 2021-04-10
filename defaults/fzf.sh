#!/bin/sh

if [ -f ~/.fzf.zsh ] && [ -f ~/.fzf.bash ]; then
	exit
fi

yes | /usr/local/opt/fzf/install
