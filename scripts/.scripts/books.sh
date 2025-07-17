#!/bin/sh
##################################################################
#  ___                         __  __                 _          #
# / _ \ _ __ ___   __ _ _ __  |  \/  | __ _  __ _  __| |_   _    #
#| | | | '_ ` _ \ / _` | '__| | |\/| |/ _` |/ _` |/ _` | | | |   #
#| |_| | | | | | | (_| | |    | |  | | (_| | (_| | (_| | |_| |   #
# \___/|_| |_| |_|\__,_|_|    |_|  |_|\__,_|\__, |\__,_|\__  |   #
#                                           |___/       |___/    #
#                                                                #
##################################################################

path="/mnt/Storage/omar/Books/"

if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
  launcher="rofi -dmenu -i -l 10"
elif [ "$XDG_SESSION_TYPE" = "x11" ]; then
  launcher="dmenu -i -l 10"
else
  echo "Error: Could not detect display server (Wayland or X11)."
  exit 1
fi

# Direct approach - no temp file, just pipe everything
choice=$(fd -e pdf . "$path" -x basename | sort | $launcher)

if [ -z "$choice" ]; then
  exit 0
fi

# Find the file again (less efficient but simpler)
full_path=$(fd -e pdf . "$path" | grep "/$choice$" | head -1)

zathura --mode fullscreen "$full_path"
