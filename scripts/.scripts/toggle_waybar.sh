#!/bin/bash

if pgrep -x "waybar" >/dev/null; then
  pkill -x "waybar"
else
  waybar &
  /home/omar/.config/hypr/change/waybar-alt-5
fi
