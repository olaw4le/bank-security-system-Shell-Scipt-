#!/bin/bash
if [ -z "$1" ]; then
	echo "Folder Currently in use"
	exit 1

elif [ ! -e "$1" ]; then
	echo "Folder doesnt exist"
	exit 2
else
	while ! ln "$0" "$1-lock" 2>/dev/null; do
	sleep 30
	done
	exit 0
fi
