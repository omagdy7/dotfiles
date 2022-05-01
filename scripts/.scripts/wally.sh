#!/bin/sh

# WALL_ARR=()
WALLPAPERDIR="$HOME/Pictures/wallpapers"
RANDWALL=$(ls ${WALLPAPERDIR} | shuf -n1)
# WALL_ARR+=$RANDWALL
wal -i "$WALLPAPERDIR/$RANDWALL"
nitrogen --set-scaled $WALLPAPERDIR/$RANDWALL

