#!/bin/sh

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find ~/programming -mindepth 1 -maxdepth 2 -type d | fzf)
fi

if [[ -z $selected ]]; then
    exit 1
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $selected_name
    tmux send-keys -t $selected_name "cd $selected" Enter
    tmux send-keys -t $selected_name "clear" Enter
    exit 0
fi

if ! tmux has-session -t=$selected_name 2> /dev/null; then
    tmux new-session -ds $selected_name
    tmux send-keys -t $selected_name "cd $selected" Enter
    tmux send-keys -t $selected_name "clear" Enter
fi

tmux switch-client -t $selected_name
