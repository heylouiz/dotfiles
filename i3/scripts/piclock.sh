#!/usr/bin/env bash

icon="$HOME/Pictures/lockicon.png"
tmpbg='/tmp/screen.png'

(( $# )) && { icon=$1; }

#scrot "$tmpbg"
convert "$1" -resize 1920x1080 "$tmpbg"
convert "$tmpbg" "$icon" -gravity center -composite -matte "$tmpbg"
i3lock -i "$tmpbg"
