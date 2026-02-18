#!/usr/bin/env bash

set -euo pipefail

DOTFILES=("bob" "create-next-app-nodejs" "kanata" "nextjs-nodejs" "nvim" "payload-nodejs" "scripts" "tmux" "trigger")
HOME_CONFIG=("alacritty" "chromium" "environment.d" "fcitx5" "google-chrome" "ibus" "lazygit" "mise" "obsidian" "payload-nodejs" "starship.toml" "trigger" "uwsm" "xournalpp" "autostart" "create-next-app-nodejs" "evince" "fontconfig" "gtk-3.0" "imv" "mako" "nautilus" "omarchy" "pulse" "swayosd" "Typora" "walker" "yay" "bob" "dconf" "fastfetch" "ghostty" "hypr" "kanata" "menus" "nextjs-nodejs" "omarchy.ttf" "qalculate" "systemd" "user-dirs.dirs" "waybar" "btop" "elephant" "fcitx" "git" "hyprland-preview-share-picker" "kitty" "mimeapps.list" "nvim" "opencode" "scripts" "tmux" "user-dirs.locale" "xdg-terminals.list")

CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"
TARGET_DIR="$HOME/dotfiles/.config"

mkdir -p "$TARGET_DIR"

for cfg in "${HOME_CONFIG[@]}"; do
  # test if $cfg is in DOTFILES
  if [[ " ${DOTFILES[*]} " == *" $cfg "* ]]; then
    # already managed, skip
    continue
  fi

  if [[ -e "$CONFIG_DIR/$cfg" ]]; then
    echo "Moving $CONFIG_DIR/$cfg -> $TARGET_DIR/$cfg"
    mv "$CONFIG_DIR/$cfg" "$TARGET_DIR/$cfg"
  fi
done

