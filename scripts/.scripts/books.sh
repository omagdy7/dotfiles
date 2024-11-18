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

# Set the path to the books directory
path="/mnt/Storage/omar/Books/"

# Detect whether we're in a Wayland or X11 session
if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
  # Wayland session - use wofi
  launcher="wofi --dmenu -i -l 10"
elif [ "$XDG_SESSION_TYPE" = "x11" ]; then
  # X11 session - use dmenu
  launcher="dmenu -i -l 10"
else
  echo "Error: Could not detect display server (Wayland or X11)."
  exit 1
fi

# Initial directory to choose from
choice=$(ls -a "$path" | $launcher)

# Initialize the new choice as the first directory selected
new_choice=$choice

# Loop through directories until a file is selected
while [ -d "$path/$new_choice" ]; do
  # Recurse into the selected directory and show options again
  choice=$(ls -a "$path/$new_choice" | $launcher)
  new_choice+="/$choice" # Append the choice to the path
done

# Open the selected file with zathura in fullscreen mode
zathura --mode fullscreen "$path/$new_choice"
