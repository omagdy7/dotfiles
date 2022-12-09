#!/bin/sh


CHOICES="poweroff\nreboot"

CHOICE=$(echo -e $CHOICES | dmenu -l 3)

systemctl $CHOICE




