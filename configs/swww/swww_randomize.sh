#!/bin/bash

# This script will randomly go through the files of a directory, setting it
# up as the wallpaper at regular intervals
#
# NOTE: this script is in bash (not posix shell), because the RANDOM variable
# we use is not defined in posix

if [[ $# -lt 1 ]] || [[ ! -d $1   ]]; then
	echo "Usage:
	$0 (path/to/img/directory)"
	exit 1
fi

# Edit below to control the images transition
export SWWW_TRANSITION=any
export SWWW_TRANSITION_FPS=60

# This controls (in seconds) when to switch to the next image
# export SWWW_INTERVAL=600
INTERVAL=86400

while true; do
	find "$1" -type f \
		| while read -r img; do
			echo "$((RANDOM % 1000)):$img"
		done \
		| sort -n | cut -d':' -f2- \
		| while read -r img; do
			swww img "$img"
			sleep $INTERVAL
		done
done
