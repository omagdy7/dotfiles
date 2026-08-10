#!/bin/sh

path="/mnt/Storage/Movies/Movies"

# Detect session type and choose launcher
if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
  launcher=(rofi -dmenu -i -l 10 -p "Movie name" -theme-str "window { width: 45%; }")
elif [ "$XDG_SESSION_TYPE" = "x11" ]; then
  launcher=(dmenu -i -l 10)
else
  echo "Error: Could not detect display server (Wayland or X11)."
  exit 1
fi

# Pipe movie filenames to launcher and capture choice
choice=$(fd -e mp4 -e mkv . "$path" -x basename | sort | "${launcher[@]}")

# Exit silently if nothing selected
[ -z "$choice" ] && exit 0

echo $choice

# Find full path of selected file
full_path=$(fd -e mp4 -e mkv . "$path" | grep -F "/$choice")

echo "full_path = $full_path"

# Open with mpv in fullscreen mode
mpv --fs "$full_path"
