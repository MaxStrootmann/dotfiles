#!/usr/bin/env bash
set -euo pipefail

REMOTE_HOST="${REMOTE_HOST:-mann-dev}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT_DIR="$(cd "${SCRIPT_DIR}/../../.." && pwd)"
NVIM_VERSION="${NVIM_VERSION:-v0.11.6}"
NVIM_ARCHIVE="nvim-linux-x86_64.tar.gz"
NVIM_URL="https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/${NVIM_ARCHIVE}"

echo "Uploading shared-browser helper to ${REMOTE_HOST}..."
ssh "${REMOTE_HOST}" 'mkdir -p ~/.local/bin'
scp "${ROOT_DIR}/Work/big-vps/remote/bin/shared-browser" "${REMOTE_HOST}:~/.local/bin/shared-browser"
ssh "${REMOTE_HOST}" 'chmod +x ~/.local/bin/shared-browser'

echo "Installing packages on ${REMOTE_HOST}..."
ssh "${REMOTE_HOST}" '
  set -euo pipefail
  sudo apt-get update
  sudo DEBIAN_FRONTEND=noninteractive apt-get install -y \
    tmux zsh curl git ca-certificates unzip \
    ripgrep fd-find fzf chromium xvfb x11vnc novnc websockify \
    openbox scrot xclip rsync build-essential npm clang-format
'

echo "Installing Bun, Codex, and agent-browser on ${REMOTE_HOST}..."
ssh "${REMOTE_HOST}" '
  set -euo pipefail
  if [ ! -x "$HOME/.bun/bin/bun" ]; then
    curl -fsSL https://bun.sh/install | bash
  fi

  export PATH="$HOME/.bun/bin:$PATH"
  bun install -g @openai/codex agent-browser
'

echo "Installing Neovim ${NVIM_VERSION} on ${REMOTE_HOST}..."
ssh "${REMOTE_HOST}" "
  set -euo pipefail
  mkdir -p \"\$HOME/.local/bin\" \"\$HOME/.local/opt\"
  tmpdir=\$(mktemp -d)
  trap 'rm -rf \"\$tmpdir\"' EXIT
  curl -fsSL \"${NVIM_URL}\" -o \"\$tmpdir/${NVIM_ARCHIVE}\"
  tar -C \"\$tmpdir\" -xzf \"\$tmpdir/${NVIM_ARCHIVE}\"
  rm -rf \"\$HOME/.local/opt/nvim-linux-x86_64\"
  mv \"\$tmpdir/nvim-linux-x86_64\" \"\$HOME/.local/opt/nvim-linux-x86_64\"
  ln -sfn \"\$HOME/.local/opt/nvim-linux-x86_64/bin/nvim\" \"\$HOME/.local/bin/nvim\"
"

echo "Preparing shared directories and shell config on ${REMOTE_HOST}..."
ssh "${REMOTE_HOST}" '
  set -euo pipefail
  mkdir -p "$HOME/shared/inbox" "$HOME/shared/outbox" "$HOME/shared/shots" "$HOME/shared/downloads"
  touch "$HOME/.bashrc" "$HOME/.zshrc"

  for rc in "$HOME/.bashrc" "$HOME/.zshrc"; do
    if grep -q "thin-client shared browser" "$rc"; then
      continue
    fi

    cat >> "$rc" <<'"'"'EOF'"'"'

# thin-client shared browser
export PATH="$HOME/.local/bin:$HOME/.bun/bin:$PATH"
if command -v fdfind >/dev/null 2>&1 && ! command -v fd >/dev/null 2>&1; then
  alias fd="fdfind"
fi
alias sb="shared-browser"
alias sbs="shared-browser shot"
alias sbl="cd ~/shared"
EOF
  done
'

echo "Syncing dotfiles to ${REMOTE_HOST}..."
"${SCRIPT_DIR}/agent-zero-sync-dotfiles.sh"

echo "Wiring dotfiles and VPS-local shell additions on ${REMOTE_HOST}..."
ssh "${REMOTE_HOST}" '
  set -euo pipefail
  mkdir -p "$HOME/.config" "$HOME/.codex/skills" "$HOME/.agents/skills"
  ln -sfn "$HOME/dotfiles/.config/nvim" "$HOME/.config/nvim"
  ln -sfn "$HOME/dotfiles/.config/scripts" "$HOME/.config/scripts"
  ln -sfn "$HOME/dotfiles/.zshrc" "$HOME/.zshrc"
  ln -sfn "$HOME/dotfiles/.config/tmux/tmux.conf" "$HOME/.tmux.conf"
  ln -sfn "$HOME/dotfiles/agent-shared/AGENTS.md" "$HOME/AGENTS.md"
  ln -sfn "$HOME/dotfiles/agent-shared/skills" "$HOME/skills"

  for skill_dir in "$HOME/dotfiles/agent-shared/skills"/*; do
    [ -d "$skill_dir" ] || continue
    skill_name="$(basename "$skill_dir")"
    ln -sfn "$skill_dir" "$HOME/.codex/skills/$skill_name"
    ln -sfn "$skill_dir" "$HOME/.agents/skills/$skill_name"
  done

  cat > "$HOME/.zshrc.local" <<'"'"'EOF'"'"'
# VPS local additions
export PATH="$HOME/.local/bin:$HOME/.bun/bin:$PATH"
if command -v fdfind >/dev/null 2>&1 && ! command -v fd >/dev/null 2>&1; then
  alias fd="fdfind"
fi
alias sb="shared-browser"
alias sbs="shared-browser shot"
alias sbl="cd ~/shared"
EOF
'

echo "Priming Neovim plugins and Mason packages on ${REMOTE_HOST}..."
ssh "${REMOTE_HOST}" '
  set -euo pipefail
  TERM=xterm-256color "$HOME/.local/bin/nvim" --headless "+Lazy! sync" +qa
  timeout 300s sh -c "TERM=xterm-256color \"$HOME/.local/bin/nvim\" --headless \"+MasonToolsInstallSync\" +qa" || true
'

echo
echo "Bootstrap complete."
echo "Next steps:"
echo "  1. ssh ${REMOTE_HOST}"
echo "  2. Optional once: chsh -s \$(command -v zsh)"
echo "  3. shared-browser start"
echo "  4. dev tunnel"
