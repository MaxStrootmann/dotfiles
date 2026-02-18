# History persistence
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Set the directory we want to store Zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

PS1="%m:%{$fg[magenta]%}%~%{$fg[red]%} %{$reset_color%}$%b "

# plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Case-insensitive completions
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit
zinit cdreplay -q

# Emacs keybindings
bindkey -e

# Keybindings
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^f' forward-word


# Aliases
alias ls='ls -lah --color'
alias tm="~/.config/scripts/tmux-session-dispensary.sh"
alias wt="~/.config/scripts/worktrees.sh"

# Shell integrations
eval "$(fzf --zsh)"

# pnpm
export PNPM_HOME="/home/max/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end


export PATH="/home/max/.local/bin:$PATH"
export PATH="/home/max/.config/scripts:$PATH"
export PATH="/home/max/.local/share/bob/nvim-bin:$PATH"
export EDITOR="/usr/bin/nvim"


# opencode
export PATH=/home/max/.opencode/bin:$PATH
export PATH="/home/max/.cache/.bun/bin:$PATH"

export EDITOR="nvim"
export VISUAL="nvim"

