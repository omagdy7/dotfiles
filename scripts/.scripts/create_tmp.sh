#!/bin/sh

choice="py"

# Define list of extensions
extensions="cpp\nc\npy\nrs\njs\nts\ngo\ntxt\nmd\nhtml\ncss"

# Detect whether we're in a Wayland or X11 session
if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
  # Wayland session - use rofi with width override
  launcher=(rofi -dmenu -p "Select extension: " -l 10 -theme-str "window { width: 45%; }")
elif [ "$XDG_SESSION_TYPE" = "x11" ]; then
  # X11 session - use dmenu
  launcher=(dmenu -p "Select extension: " -l 10)
else
  echo "Error: Could not detect display server (Wayland or X11)."
  exit 1
fi

# Run the launcher and get the user's choice
choice=$(echo -e "$extensions" | "${launcher[@]}")

# Exit silently if Escape was pressed or menu was closed
[ -z "$choice" ] && exit 0

# choose random word from a dictionary
random_word=$(shuf -n 1 /usr/share/dict/cracklib-small)

# create temp file and open it in nvim
alacritty -e nvim "/tmp/$random_word.$choice"
