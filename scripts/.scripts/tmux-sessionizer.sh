#!/bin/sh
if [[ $# -eq 1 ]]; then
  selected=$1
else
  selected=$(fd '^.git$' -a --hidden --no-ignore --type d ./programming --exec dirname | grep -v "thirdparties" | fzf)
fi

if [[ -z $selected ]]; then
  exit 1
fi

selected_name=$(basename "$selected" | tr . _)
tmux_running=$(pgrep tmux)

create_session() {
  tmux new-session -d -s $selected_name -n nvim
  tmux send-keys -t "$selected_name:1" "cd $selected && clear && nvim ." Enter
  # Create second window (shell)
  tmux new-window -t $selected_name -n shell
  tmux send-keys -t "$selected_name:2" "cd $selected && clear" Enter
  # Create third window (git)
  tmux new-window -t $selected_name -n git
  tmux send-keys -t "$selected_name:3" "cd $selected && clear && lazygit" Enter
}

# If not in tmux, create and attach
if [[ -z $TMUX ]]; then
  create_session
  tmux attach-session -t $selected_name
else
  # If in tmux, create if needed and switch
  if ! tmux has-session -t=$selected_name 2>/dev/null; then
    create_session
  fi
  tmux switch-client -t $selected_name
fi
