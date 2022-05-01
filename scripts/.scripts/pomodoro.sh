#!/bin/sh


# To-DO
# (1) Make it store sessions for everyday in a file and group a year in a folder and months in sub folders and the days in the months folder
# (2) Add sound to the notifcations
# (3) Add pause and start cabability
# (4) Make it so that you can specify a task for each sessions
# (5) Come up with better messeages for the notifcations
# (6) Add something like pomo -status which displayes the timer of that session(Would be really useful to add to the bar in WMs)

# stop_watch() {
#   MINUTES=$1
#   SECS=$(($MINUTES*60))
#   S=60
#   while [[ $SECS != 0 ]]
#   do
#     # sleep 1
#     SECS=$((SECS-1))
#     S=$((S-1))
#     if [[ $(($SECS%60)) == 0 ]];
#     then
#       MINUTES=$((MINUTES-1))
#       S=59
#     fi
#     [[ $S -le 9 ]] && echo $MINUTES:0$S || echo $MINUTES:$S 
#   done
# }

stopwatch() {
  seconds=$(($1*60))
  date1=$((`date +%s` + $seconds))
  while [ "$date1" -ge `date +%s` ];
  do 
      echo -ne "$(date -u --date @$(($date1 - `date +%s` )) +%H:%M:%S)\r";
  done
}

toggle_watch=true
DURATION=$1
TIME_IN_SECONDS=$(($DURATION*60))
START=$(date | awk '{print $4}' | sed 's/^0//')
notify-send -i ~/Downloads/tomato_1f345.png -t 3000 "POMODORO" "Timer started at $START"
(sleep $TIME_IN_SECONDS && notify-send -i ~/Downloads/tomato_1f345.png -t 9999999 "POMODORO" "Take a break you desrve it.") & disown
stopwatch $DURATION

