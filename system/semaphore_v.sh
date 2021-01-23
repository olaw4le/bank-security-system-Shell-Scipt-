#!/bin/bash
if [ -z "$1" ]; then
	echo "The folder Currently in use"
	exit 1
else
	rm -rf "$1-lock"
	exit 0
fi
