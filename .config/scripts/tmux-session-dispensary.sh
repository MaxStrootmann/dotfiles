#!/bin/bash

DIRS=(
  "$HOME/Downloads"
  "$HOME/Documents"
  "$HOME/Work"
  "$HOME/Work"/*bare
  "$HOME/.config"
  "$HOME"
)

if [[ $# -eq 1 ]]; then
  selected=$1
else
  selected=$(
    fd . "${DIRS[@]}" \
      --type=dir --type=symlink \
      --max-depth=1 \
      --full-path \
      --exclude='.git' \
      --exclude='objects' \
      --exclude='refs' \
      --exclude='hooks' \
      --exclude='info' \
      --exclude='logs' \
      --exclude='worktrees' \
      --base-directory="$HOME" |
    sed "s|^$HOME/||" |
    sk --margin 10% --color='bw'
  )

  [[ $selected ]] && selected="$HOME/$selected"
fi

[[ ! $selected ]] && exit 0

selected_name=$(basename "$selected" | tr . _)

if ! tmux has-session -t "$selected_name"; then
    tmux new-session -ds "$selected_name" -c "$selected"
    tmux select-window -t "$selected_name:1"
fi

if [[ -z $TMUX ]]; then
    tmux attach-session -t "$selected_name"
else
    tmux switch-client -t "$selected_name"
fi

