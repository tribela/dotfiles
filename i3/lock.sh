#!/bin/bash

here=$(dirname $0)

if [ ! -e $here/lock.png ]; then
    size=$(xdpyinfo | grep dimensions | sed -r 's/^[^0-9]*([0-9]+x[0-9]+).*$/\1/')
    convert $here/lock.jpg -resize $size $here/lock.png
fi

i3lock -c a939ff -i $here/lock.png
xset dpms force off
