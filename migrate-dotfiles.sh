#!/usr/bin/env bash

set -euo pipefail

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
DOTFILES_ROOT="$HOME/dotfiles"
DOTFILES_CONFIG_DIR="$DOTFILES_ROOT/.config"
BACKUP_DIR="$HOME/bak.dotfiles"

mkdir -p "$BACKUP_DIR"

# 1) For every file/dir under ~/.config, if a counterpart exists in dotfiles/.config,
#    move the existing one to backup so stow can place symlinks.
find "$CONFIG_DIR" -mindepth 1 -maxdepth 1 -printf '%f\n' | while read -r name; do
  src="$CONFIG_DIR/$name"
  dot="$DOTFILES_CONFIG_DIR/$name"

  # Only touch if the same name exists in dotfiles/.config
  if [[ -e "$dot" ]]; then
    # If it's already a symlink, skip
    if [[ -L "$src" ]]; then
      echo "Skipping $src (already symlink)"
      continue
    fi

    echo "Backing up $src -> $BACKUP_DIR/$name"
    mv "$src" "$BACKUP_DIR/$name"
  fi
done

# 2) Run stow from dotfiles root
cd "$DOTFILES_ROOT"
stow .

