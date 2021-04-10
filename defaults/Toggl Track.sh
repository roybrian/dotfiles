#!/bin/sh

toggl_db="${HOME}/Library/Application Support/Toggl/production/toggldesktop.db"

if [ -f "${toggl_db}" ]; then
	# [✓] Idle detection: [60] minutes
	# [✓] Show timer on menu bar
	# [✓] Remind to track time: [60] minutes
	sqlite3 -batch "${toggl_db}" <<-EOF
		UPDATE settings
				SET use_idle_detection = 1,
				menubar_timer = 1,
				reminder = 1,
				idle_minutes = 60,
				reminder_minutes = 60
	EOF
fi

defaults write com.toggl.toggldesktop.TogglDesktop SUAutomaticallyUpdate -bool true
defaults write com.toggl.toggldesktop.TogglDesktop SUHasLaunchedBefore -bool true
