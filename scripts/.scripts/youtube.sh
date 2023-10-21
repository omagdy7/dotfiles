#!/bin/sh

youtube_link=$(: | dmenu -p "Youtube link: ")
quality=$(echo -e "1080p\n720p\n480p\n360p" | dmenu -i -l 4)

mpv --profile="$quality" "$youtube_link" 2>/dev/null
