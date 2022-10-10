#!/bin/sh

choice="$(\ls ~/Pictures/wallpapers | fzf)"
nitrogen --set-scaled $choice


