#!/bin/bash

CHOICE=$(echo -e "Area\nWindow" | dmenu -i -l 2)

if [ "$CHOICE"="Area" ]; then
  gnome-screenshot -a -c
else
  gnome-screenshot -w -c
fi




