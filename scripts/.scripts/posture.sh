#!/bin/sh

MINS=30
TIME=$(echo "60*$MINS" | bc)

while true; do
	sleep "$TIME" && notify-send -t 5000 "Postrue" "This is a friendly reminder to change your posture"
done
