#!/bin/sh

# When searching all mailboxes, also include results from Junk
defaults write com.apple.mail IndexJunk -bool true
# try sending later automatically if server isn't available
defaults write com.apple.mail SuppressDeliveryFailure -bool true
# dont organize by conversation
defaults write com.apple.mail ThreadingDefault -bool false
# highlight conversations
defaults write com.apple.mail HighlightClosedThreads -bool true
# show contact photo
defaults write com.apple.mail EnableContactPhotos -bool true

# [✓] Check Grammar with Spelling
defaults write com.apple.mail CheckGrammarWithSpelling -bool true
defaults write com.apple.mail WebGrammarCheckingEnabled -bool true
# [✓] Smart Links
defaults write com.apple.mail WebAutomaticLinkDetectionEnabled -bool true

# insert attachments at end of message
defaults write com.apple.mail AttachAtEnd -bool true

# Set favorite mailboxes: Inbox, Sent, Drafts, All Mail, Trash, Flagged, Junk
setmailboxes() {
	printf "%s\n" "
	<dict>
		<key>IsPrefferedSelection</key>
		<string>$1</string>
		<key>MailboxUidIsContainer</key>
		<string>1</string>
		<key>MailboxUidName</key>
		<string>$2</string>
		<key>MailboxUidPersistentIdentifier</key>
		<string>$3</string>
		<key>MailboxUidType</key>
		<string>$4</string>
	</dict>"
}

defaults write com.apple.mail Favorites -array \
	"$(setmailboxes 0 Inbox Inbox 100)" \
	"$(setmailboxes 1 Flagged Flags 108)" \
	"$(setmailboxes 0 Drafts Drafts 103)" \
	"$(setmailboxes 0 Sent "Sent Messages" 102)" \
	"$(setmailboxes 0 Archive Archive 109)" \
	"$(setmailboxes 0 Junk Junk 105)" \
	"$(setmailboxes 0 Trash Trash 101)"

# automatically add invitation to calendar
defaults write com.apple.mail CalendarInviteRuleEnabled -bool true

# make orange the default flag
defaults write com.apple.mail FlagColorToDisplay -int 1

# Disable inline attachments (just show the icons)
# https://github.com/mathiasbynens/dotfiles
defaults write com.apple.mail DisableInlineAttachmentViewing -bool true

defaults write com.apple.mail NSUserKeyEquivalents -dict-add "Save Attachments..." '@$s'
