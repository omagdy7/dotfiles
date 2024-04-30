#!/bin/sh

# Choose an extenstion for the temp file
choice=$(echo -e "cpp\nc\npy\nrs\njs\nts\ngo\ntxt\nmd\nhtml\ncss" | dmenu -p "Select extension: " -l 10)

# choose random word from a dictionary
random_word=$(cat /usr/share/dict/cracklib-small | shuf -n 1)

# create temp file and open it in nvim
alacritty -e nvim /tmp/$random_word.$choice
