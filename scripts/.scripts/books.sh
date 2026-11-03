#!/bin/sh
##################################################################
#  ___                         __  __                 _          #
# / _ \ _ __ ___   __ _ _ __  |  \/  | __ _  __ _  __| |_   _    #
#| | | | '_ ` _ \ / _` | '__| | |\/| |/ _` |/ _` |/ _` | | | |   #
#| |_| | | | | | | (_| | |    | |  | | (_| | (_| | (_| | |_| |   #
# \___/|_| |_| |_|\__,_|_|    |_|  |_/ \__,_|\__, |\__,_|\__  |   #
#                                           |___/       |___/    #
#                                                                #
##################################################################

path="/mnt/dev/Books/"

# Pipe filenames to Vicinae and capture choice
choice=$(
  fd -e pdf . "$path" -x basename |
    sort |
    vicinae dmenu \
      --placeholder "Book name" \
      --height 500 \
      --width 700
)

# Exit silently if nothing selected
[ -z "$choice" ] && exit 0

# Find the full path of the selected file
full_path=$(fd -e pdf . "$path" | grep "/$choice$" | head -1)

# Open in zathura fullscreen
# zathura --mode fullscreen "$full_path"
QT_QPA_PLATFORM=xcb sioyek "$full_path"
