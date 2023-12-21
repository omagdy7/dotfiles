#!/bin/sh

cmd=$(: | dmenu -p "command")
# quality=$(echo -e "1080p\n720p\n480p\n360p" | dmenu -i -l 4)

sh -c "$cmd"
