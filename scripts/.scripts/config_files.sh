#!/usr/bin/sh

file=$(find "$HOME/dotfiles/" -type f | dmenu -l 20 -p "open config file")
kitty -e nvim $file
