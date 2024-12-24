#!/bin/sh

pidof $1 | xargs -I {} ps -p {} -o rss | tail -n +2 | paste -sd'+' | bc | awk '{print $1/1024 "MB"}'
