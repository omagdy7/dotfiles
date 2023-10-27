#!/bin/sh

youtube_link=$(xclip -o)
# quality=$(echo -e "1080p\n720p\n480p\n360p" | dmenu -i -l 4)

mpv --profile="720p" "$youtube_link" 2>/dev/null
