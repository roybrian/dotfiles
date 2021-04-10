#!/bin/zsh

export LANG=en_US.UTF-8

# PATH
export PATH=/usr/local/sbin:$PATH #brew
if type brew &>/dev/null; then
	FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH
fi

# case insensitive path-completion
zstyle ':completion:*' \
	matcher-list \
	'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' \
	'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' \
	'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' \
	'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'

# partial completion suggestions
zstyle ':completion:*' list-suffixes
zstyle ':completion:*' expand prefix suffix
zstyle ':completion:*' select-prompt ''
zstyle ':completion:*' list-prompt ''

# load bashcompinit for some old bash completions
autoload bashcompinit && bashcompinit
# https://stackoverflow.com/questions/444951/zsh-stop-backward-kill-word-on-directory-delimiter
WORDCHARS="*?[]~=&;!#$%^(){}<>"

# SHELL OPTS
setopt AUTO_CD
setopt NO_CASE_GLOB

### HISTORY
HISTFILE=~/.zsh_history
setopt EXTENDED_HISTORY
SAVEHIST=5000
HISTSIZE=2000
# share history across multiple zsh sessions
setopt SHARE_HISTORY
# append to history
setopt APPEND_HISTORY
# adds commands as they are typed, not at shell exit
setopt INC_APPEND_HISTORY
# expire duplicates first
setopt HIST_EXPIRE_DUPS_FIRST
# do not store duplications
setopt HIST_IGNORE_DUPS
# ignore duplicates when searching
setopt HIST_FIND_NO_DUPS
# removes blank lines from history
setopt HIST_REDUCE_BLANKS

# bindings
bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward

### PROMPT
autoload -Uz promptinit compinit vcs_info
compinit
promptinit
setopt prompt_subst
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
gitprompt=\$vcs_info_msg_0_

zstyle ':completion:*' menu select
zstyle ':vcs_info:git:*' formats '%F{240}(%r/%b)%f' # brgreen / # brcyan
zstyle ':vcs_info:*' enable git

pwd_with_blue_underline="%U%F{blue}%~%f%u"
exit_status_bold_and_red_if_0="%B%(?.>.%F{red}x)%f%b"
PROMPT="
$pwd_with_blue_underline $gitprompt
$exit_status_bold_and_red_if_0 "

### PLUGINS
# zsh autosuggest
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

### FZF
export FZF_DEFAULT_OPTS='--bind tab:down --cycle'
export FZF_DEFAULT_COMMAND='fd --type f'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

### AUTOJUMP
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# ALIASES
alias -g bci='brew install --cask'
alias -g bcr='brew reinstall --cask'
alias -g bcu='brew uninstall --cask'
alias -g bi='brew install'
alias -g bs='brew search'
alias -g bu='brew uninstall'
alias -g defd='defaults delete'
alias -g defre='defaults read'
alias -g deft='defaults read-type'
alias -g ls='ls -G -F -A'
alias -g grepi="grep -i"
alias -g gu='cd ..'

# functions
j() {
	cd "$(/usr/local/bin/autojump "$1")" || cd
}

defra() {
	cd ~/Desktop || return
	defaults read >a
	printf "%s\n" "Press any key to continue"
	read -r
	defaults read >b
	icdiff -N -H a b
	cd || return
}

cdf() {
	current_path=$(
		osascript <<-EOF
			tell app "Finder"
				try
					POSIX path of (insertion location as alias)
				on error
					POSIX path of (path to desktop folder as alias)
				end try
			end tell
		EOF
	)
	cd "${current_path}"
}

r() {
	source ~/.zshrc
}

rm() {
	trash "${@}"
}

tldr() {
	output="$(/usr/local/bin/tldr "${@}")"
	if echo "${output}" | grep --silent "older"; then
		echo "Updating tldr..."
		/usr/local/bin/tldr --update
		/usr/local/bin/tldr "${@}"
		return
	fi
	echo "${output}"
}

keydump() {
	local app="${1}"
	if [[ -z "${app}" ]]; then
		echo "USAGE: keydump <bundle identifier>"
		return
	fi
	hotkeys="$(defaults read "${app}" NSUserKeyEquivalents | sed '1d' | sed '$ d')"
	arr=()
	while IFS=$'\n' read -r hotkey; do
		formatted="$(printf "%s\n" "${hotkey}" | sed -E 's/[[:space:]]{2,}/ /' | sed -E 's/^[[:space:]]+//' | sed "s|\"|'|g" | sed 's/ = / -string /g' | sed -E 's/;$//')"
		arr+=("defaults write ${app} NSUserKeyEquivalents ${formatted}")
	done <<<"${hotkeys}"
	printf "%s\n" "${arr[@]}" | pbcopy
}

top() {
	/usr/bin/top -i 10 -stats command,cpu,mem -s 2
}

kill() {
	pids=$(ps -r -c -A -o 'command=,%cpu=,pid=' | /usr/local/bin/fzf -m --bind 'tab:toggle' | awk '{ print $NF }')
	while IFS=$'\n' read -A pid; do
		/bin/kill -SIGKILL "${pid}"
	done <<<"$pids"
}

searchheaders() {
	rg -i "${1}" "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/System/Library/Frameworks"
}

mkcd() {
	mkdir -p "${1}"
	cd "${1}"
}

maintain() {
	dependencies=(
		/usr/local/bin/trash
	)

	dotfiles_prefs=~/Library/Preferences/com.roeybiran.dotfiles.plist

	weekly_maintenance_dirs=(
		~/Dropbox
	)

	for f in "${dependencies[@]}"; do
		test ! -e "$f" && echo "Missing depedency: $f. Exiting" && return
	done

	if test -z "$1"; then
		echo "USAGE: maintain [run] [--status]"
		return
	fi

	now="$(date +%s)"

	if test "$1" = --status; then
		last_update_date="$(defaults read "$dotfiles_prefs" maintainanceLastRunDate 2>/dev/null)"
		if test -z "$last_update_date"; then
			# first run
			echo "has yet to run."
			return
		fi
		time_elapsed_since_last_update=$(((now - last_update_date) / 86400))
		echo "last run was $time_elapsed_since_last_update days ago."
		return
	fi

	defaults write "$dotfiles_prefs" maintainanceLastRunDate -int "$now"

	echo "Updating package managers..."

	# mas
	echo ">> mas upgrade"
	mas upgrade

	# npm
	echo ">> updating npm"
	npm install npm@latest -g
	echo ">> updating global npm packages"
	npm update -g

	# brew
	# update brew itself and all formulae
	echo ">> brew update"
	brew update
	# update casks and all unpinned formulae
	echo ">> brew upgrade"
	brew upgrade
	echo ">> brew cleanup"
	brew cleanup
	echo ">> brew autoremove"
	brew autoremove
	echo ">> brew doctor"
	brew doctor

	echo "Trashing sync conflicts and broken symlinks..."
	for dir in "${weekly_maintenance_dirs[@]}"; do
		find "$dir" \( -iname '*conflict*-*-*)*' -or -type l ! -exec test -e {} \; \) -exec trash {} \; -exec echo "Trashed: " {} \;
	done

	# launchbar housekeeping
	# remove logging for all actions
	# for f in "$HOME/Library/Application Support/LaunchBar/Actions/"*".lbaction/Contents/Info.plist"; do
	# 	/usr/libexec/PlistBuddy -c "Delete :LBDebugLogEnabled" "$f" 2>/dev/null
	# done

	actions_identifiers=()
	launchbar_dir="$HOME/Library/Application Support/LaunchBar"
	action_support_dir="$launchbar_dir/Action Support"
	lbaction_packages=$(find "$launchbar_dir/Actions" -type d -name "*.lbaction")
	while IFS=$'\n' read -r plist; do
		actions_identifiers+=("$(/usr/libexec/PlistBuddy -c "Print :CFBundleIdentifier" "$plist/Contents/Info.plist" 2>/dev/null)")
	done <<<"$lbaction_packages"
	paths="$(printf "%s\n" "$action_support_dir/"*)"
	while IFS=$'\n' read -r dir; do
		delete=true
		basename="$(basename "$dir")"
		for id in "${actions_identifiers[@]}"; do
			if test "$basename" = "$id"; then
				delete=false
			fi
		done
		if "$delete"; then
			echo "LaunchBar cleanup: $dir"
			trash "$dir"
		fi
	done <<<"$paths"

	# karabiner housekeeping
	trash ~/.config/karabiner/automatic_backups/* 2>/dev/null

	# if softwareupdate --all --install --force 2>&1 | tee /dev/tty | grep -q "No updates are available"; then
	# 	sudo rm -rf /Library/Developer/CommandLineTools
	# 	sudo xcode-select --install
	# fi

}

applist() {
	echo "#####"
	echo "brew:"
	echo "#####"
	brew leaves
	echo ""
	echo "#####"
	echo "cask:"
	echo "#####"
	brew list --cask | tr '\t' '\n'
	echo ""
	echo "#####"
	echo "mas:"
	echo "#####"
	mas list | sed -E 's/^[[:digit:]]+ //g' | sed -E 's/ \(.+$//'
}
