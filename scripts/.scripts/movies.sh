#!/bin/sh

path="/mnt/Storage/Movies/Movies"

# Create a list of full paths
tmp=$(mktemp)
trap 'rm -f "$tmp"' EXIT

fd -e mp4 -e mkv . "$path" | sort >"$tmp"

# Show only filenames in Vicinae
choice=$(
  sed 's#.*/##' "$tmp" |
    vicinae dmenu --placeholder "Movie name"
)

# Exit silently if nothing selected
[ -z "$choice" ] && exit 0

# Find the corresponding full path
full_path=$(grep -F "/$choice" "$tmp" | head -1)

# Open with mpv in fullscreen mode
mpv --fs "$full_path"
