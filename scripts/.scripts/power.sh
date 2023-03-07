#!/bin/sh


CHOICES="poweroff\nreboot\nlogout"

CHOICE=$(echo -e $CHOICES | dmenu -l 3)

if [[ "$CHOICE" == "logout" ]]; then
  awesome-client "awesome.quit()"
else
  systemctl $CHOICE
fi




