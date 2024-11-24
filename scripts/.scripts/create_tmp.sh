#!/bin/sh

choice="py"
# Detect whether we're in a Wayland or X11 session
if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
  # Wayland session - use wofi
  launcher="wofi --dmenu -i -l 10"
  choice=$(echo -e "cpp\nc\npy\nrs\njs\nts\ngo\ntxt\nmd\nhtml\ncss" | wofi --dmenu -p "Select extension: " -l 10)
elif [ "$XDG_SESSION_TYPE" = "x11" ]; then
  # X11 session - use dmenu
  # Choose an extenstion for the temp file
  choice=$(echo -e "cpp\nc\npy\nrs\njs\nts\ngo\ntxt\nmd\nhtml\ncss" | dmenu -p "Select extension: " -l 10)
else
  echo "Error: Could not detect display server (Wayland or X11)."
  exit 1
fi

# choose random word from a dictionary
random_word=$(cat /usr/share/dict/cracklib-small | shuf -n 1)

# create temp file and open it in nvim
alacritty -e nvim /tmp/$random_word.$choice
