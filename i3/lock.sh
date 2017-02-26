#!/bin/bash

here=$(dirname $0)

if [ ! -e $here/lock.png ]; then
    size=$(xdpyinfo | grep dimensions | sed -r 's/^[^0-9]*([0-9]+x[0-9]+).*$/\1/')
    convert $here/lock.jpg -resize $size $here/lock.png
fi

revert() {
    xset dpms 0 0 0
}

trap revert SIGINT SIGHUP SIGTERM

xset +dpms dpms 5 5 5
i3lock -n -c a939ff -i $here/lock.png &
pid=$!
sleep 1
xset dpms force off
wait $pid

revert
