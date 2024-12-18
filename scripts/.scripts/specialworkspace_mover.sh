#!/bin/bash

# Fetch all clients' information using hyprctl
clients_output=$(hyprctl clients)

# Extract window classes for workspace -99
special_windows=$(echo "$clients_output" | awk '
  BEGIN { RS="Window "; FS="\n" }
  /workspace: -99/ {
    for (i=1; i<=NF; i++) {
      if ($i ~ /class:/) {
        class = $i
        sub("class: ", "", class)
        print class
      }
    }
  }
')

# Check if there are any windows in the special workspace
if [[ -z "$special_windows" ]]; then
  echo "No windows found in the special workspace."
  exit 0
fi

# Display the window classes in wofi and get the selected window class
selected_class=$(echo "$special_windows" | wofi --dmenu -p "Select a window to move:" | awk '{$1=$1};1')

# Exit if no selection was made
if [[ -z "$selected_class" ]]; then
  echo "No selection made."
  exit 0
fi

window_title=$(hyprctl clients | grep -i -E "Window .* $selected_class" | sed "s/Window.*-> \(.*\):/\1/I")

echo "Special windows: $special_windows"
echo "Selected class: $selected_class"
echo "Window title: $window_title"

current_workspace=$(hyprctl activeworkspace | head -n1 | cut -d' ' -f3)

echo "Curspace: $current_workspace"
# hyprctl dispatch movetoworkspacesilent 1,title:"Thinking in Systems - volty - Obsidian v1.7.7"

# Move the selected window to the current workspace
if [[ -n "$window_title" ]]; then
  hyprctl dispatch movetoworkspacesilent "$current_workspace",title:"$window_title"
  echo "Moved $selected_class to the current workspace."
else
  echo "Failed to find window ID for $selected_class."
fi
