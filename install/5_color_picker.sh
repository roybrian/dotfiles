#!/bin/bash

# color picker
colorpicker="${HOME}/Applications/ColorPicker.app"
test -d "${colorpicker}" || osacompile -e "choose color" -o "${colorpicker}"
