#!/bin/sh

FILETYPE=$1
fd --extension $FILETYPE --exec wc -l | cut -d ' ' -f1 | paste -sd+ | bc
