#!/bin/sh -e

selection=$(hacksaw -f "-i %i -g %g")
shotgun $selection - | xclip -t 'image/png' -selection clipboard
random_word=$(cat /usr/share/dict/cracklib-small | shuf -n 1)
shotgun $selection - >/tmp/$random_word.png
