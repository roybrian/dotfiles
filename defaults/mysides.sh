#!/bin/sh

# Add $HOME to "Favorites"
/usr/local/bin/mysides add "${USER}" "file://${HOME}" 1>/dev/null 2>&1
/usr/local/bin/mysides remove "Creative Cloud Files" 1>/dev/null 2>&1
/usr/local/bin/mysides remove "Amazon Drive" 1>/dev/null 2>&1
