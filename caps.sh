#!/bin/bash
PATH='org.gnome.desktop.input-sources'
OPTION="'ctrl:nocaps'"
status=$(/usr/bin/gsettings get $PATH xkb-options)
if [[ "$status" == *"$OPTION"* ]]; then
    echo "Already configured"
    exit
fi

new_value="${status%]},'ctrl:nocaps']"
echo "$new_value"
/usr/bin/gsettings set $PATH xkb-options "$new_value"
