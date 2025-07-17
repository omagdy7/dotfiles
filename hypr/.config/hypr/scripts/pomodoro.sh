#!/bin/bash

# Pomodoro Timer Script for Waybar
# Save this as ~/.config/waybar/scripts/pomodoro.sh

TIMER_FILE="/tmp/pomodoro_timer"
PID_FILE="/tmp/pomodoro_pid"

# Function to start timer
start_timer() {
  local duration=$1
  local end_time=$(($(date +%s) + duration * 60))

  # Save timer info
  echo "$end_time" >"$TIMER_FILE"

  # Start background timer process
  (
    while true; do
      current_time=$(date +%s)
      if [ $current_time -ge $end_time ]; then
        # Timer finished
        notify-send "🍅 Pomodoro" "Timer finished! Take a break." --urgency=critical
        rm -f "$TIMER_FILE" "$PID_FILE"
        break
      fi
      sleep 1
    done
  ) &

  # Save PID
  echo $! >"$PID_FILE"
}

# Function to stop timer
stop_timer() {
  if [ -f "$PID_FILE" ]; then
    kill $(cat "$PID_FILE") 2>/dev/null
    rm -f "$PID_FILE"
  fi
  rm -f "$TIMER_FILE"
  notify-send "🍅 Pomodoro" "Timer stopped."
}

# Function to get current status
get_status() {
  if [ -f "$TIMER_FILE" ]; then
    local end_time=$(cat "$TIMER_FILE")
    local current_time=$(date +%s)
    local remaining=$((end_time - current_time))

    if [ $remaining -le 0 ]; then
      rm -f "$TIMER_FILE" "$PID_FILE"
      echo "🍅 00:00"
    else
      local minutes=$((remaining / 60))
      local seconds=$((remaining % 60))
      printf "🍅 %02d:%02d" $minutes $seconds
    fi
  else
    echo "🍅 Ready"
  fi
}

# Function to show menu and start timer
show_menu() {
  # Check if rofi is available, fallback to zenity or basic selection
  if command -v rofi >/dev/null 2>&1; then
    choice=$(echo -e "15 minutes\n25 minutes\n35 minutes\n45 minutes\nStop Timer" | rofi -dmenu -p "Pomodoro Timer:")
  elif command -v zenity >/dev/null 2>&1; then
    choice=$(zenity --list --title="Pomodoro Timer" --column="Duration" \
      "15 minutes" "25 minutes" "35 minutes" "45 minutes" "Stop Timer" 2>/dev/null)
  else
    # Fallback to terminal menu
    echo "Select Pomodoro duration:"
    echo "1) 15 minutes"
    echo "2) 25 minutes"
    echo "3) 35 minutes"
    echo "4) 45 minutes"
    echo "5) Stop Timer"
    read -p "Choice (1-5): " num_choice
    case $num_choice in
    1) choice="15 minutes" ;;
    2) choice="25 minutes" ;;
    3) choice="35 minutes" ;;
    4) choice="45 minutes" ;;
    5) choice="Stop Timer" ;;
    *) exit 1 ;;
    esac
  fi

  case "$choice" in
  "15 minutes")
    stop_timer
    start_timer 15
    notify-send "🍅 Pomodoro" "15-minute timer started!"
    ;;
  "25 minutes")
    stop_timer
    start_timer 25
    notify-send "🍅 Pomodoro" "25-minute timer started!"
    ;;
  "35 minutes")
    stop_timer
    start_timer 35
    notify-send "🍅 Pomodoro" "35-minute timer started!"
    ;;
  "45 minutes")
    stop_timer
    start_timer 45
    notify-send "🍅 Pomodoro" "45-minute timer started!"
    ;;
  "Stop Timer")
    stop_timer
    ;;
  esac
}

# Main logic
case "$1" in
"status")
  get_status
  ;;
"menu")
  show_menu
  ;;
"stop")
  stop_timer
  ;;
*)
  echo "Usage: $0 {status|menu|stop}"
  echo "  status - Get current timer status"
  echo "  menu   - Show timer selection menu"
  echo "  stop   - Stop current timer"
  exit 1
  ;;
esac
