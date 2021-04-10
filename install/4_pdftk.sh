#!/bin/bash

# pdftk
test -d "/opt/pdflabs/pdftk/" && exit

# https://gist.github.com/jvenator/9672772a631c117da151
# https://stackoverflow.com/questions/32505951/pdftk-server-on-os-x-10-11/33248310#33248310
url="https://www.pdflabs.com/tools/pdftk-the-pdf-toolkit/pdftk_server-2.02-mac_osx-10.11-setup.pkg"
tmpdir="$(mktemp -d)"
cd "${tmpdir}" || exit
echo "Downloading pdftk..."
downloaded="$(curl --progress-bar --location --remote-name --write-out '%{filename_effective}' "${url}")"
sudo installer -pkg "${downloaded}" -target /
