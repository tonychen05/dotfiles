#!/usr/bin/env bash

FOLDER=~/dotfiles/wallpapers
SCRIPT=~/dotfiles/hypr/scripts/pywal16.sh

menu () {
	CHOICE=$(nsxiv -otb $FOLDER/*)

	case $CHOICE in
		*.*) wal -s -t -i "$CHOICE" && $SCRIPT $CHOICE ;;
		*) exit 0;;
	esac
}

case "$#" in 
	0) menu ;;
	*) exit 0 ;;
esac
