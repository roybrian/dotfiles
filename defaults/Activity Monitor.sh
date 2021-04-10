#!/bin/sh

# shortcuts
defaults write com.apple.ActivityMonitor NSUserKeyEquivalents -dict-add "Filter Processes" @f

plist="$HOME/Library/Preferences/com.apple.ActivityMonitor.plist"

test ! -f "$plist" && return

plutil -convert xml1 "$plist"

python - "$plist" <<-EOF
	import plistlib
	import sys
	plistPath = sys.argv[1]
	obj = {
		"0": [
				"Command",
				"CPUUsage",
				"anonymousMemory",
				"CPUTime",
				"Threads",
				"IdleWakeUps",
				"GPUUsage",
				"GPUTime",
				"PID",
				"UID"
		],
		"1": [
				"Command",
				"anonymousMemory",
				"Threads",
				"Ports",
				"PID",
				"UID"
		],
		"2": [
				"Command",
				"PowerScore",
				"12HRPower",
				"AppSleep",
				"graphicCard",
				"powerAssertion",
				"UID"
		],
		"3": [
				"Command",
				"bytesWritten",
				"bytesRead",
				"PID",
				"UID"
		],
		"4": [
				"Command",
				"txBytes",
				"rxBytes",
				"txPackets",
				"rxPackets",
				"PID",
				"UID"
		],
		"5": [
				"Name",
				"LastHour",
				"LastDay",
				"LastWeek",
				"LastMonth"
		],
		"6": [
				"Command",
				"GPUUsage",
				"GPUTime",
				"PID",
				"UID"
		]
	}
	plist = plistlib.readPlist(plistPath)
	plist["UserColumnsPerTab v6.0"] = obj
	plistlib.writePlist(plist, plistPath)
EOF
