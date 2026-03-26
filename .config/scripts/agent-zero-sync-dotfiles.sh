#!/usr/bin/env bash
set -euo pipefail

REMOTE_HOST="${REMOTE_HOST:-max@agent-zero}"
ROOT_DIR="${ROOT_DIR:-$HOME}"
LOCAL_DOTFILES_DIR="${LOCAL_DOTFILES_DIR:-${ROOT_DIR}/dotfiles}"
REMOTE_DOTFILES_DIR="${REMOTE_DOTFILES_DIR:-~/dotfiles}"

if [ ! -d "${LOCAL_DOTFILES_DIR}" ]; then
  echo "dotfiles directory not found: ${LOCAL_DOTFILES_DIR}" >&2
  exit 1
fi

TMP_DIR="$(mktemp -d)"
cleanup() {
  rm -rf "${TMP_DIR}"
}
trap cleanup EXIT

mkdir -p "${TMP_DIR}/.config"
mkdir -p "${TMP_DIR}/.config/scripts"
mkdir -p "${TMP_DIR}/.agents"

cp "${LOCAL_DOTFILES_DIR}/.zshrc" "${TMP_DIR}/.zshrc"
rsync -a "${LOCAL_DOTFILES_DIR}/.config/nvim/" "${TMP_DIR}/.config/nvim/"
rsync -a "${LOCAL_DOTFILES_DIR}/.config/tmux/" "${TMP_DIR}/.config/tmux/"
rsync -a "${LOCAL_DOTFILES_DIR}/agent-shared/" "${TMP_DIR}/agent-shared/"

ln -sfn "agent-shared/AGENTS.md" "${TMP_DIR}/AGENTS.md"
ln -sfn "../agent-shared/skills" "${TMP_DIR}/.agents/skills"

SCRIPT_NAMES=(
  agent-zero-bootstrap.sh
  agent-zero-browser-tunnel.sh
  agent-zero-get.sh
  agent-zero-put.sh
  agent-zero-sync-dotfiles.sh
  dev
  tmux-session-dispensary.sh
  tmux-sessionizer.sh
  worktrees.sh
)

for script_name in "${SCRIPT_NAMES[@]}"; do
  cp "${LOCAL_DOTFILES_DIR}/.config/scripts/${script_name}" "${TMP_DIR}/.config/scripts/${script_name}"
done

rsync -av --delete "${TMP_DIR}/" "${REMOTE_HOST}:${REMOTE_DOTFILES_DIR}/"
