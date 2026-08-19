##############################################
# Powerlevel10k instant prompt (must stay first)
##############################################
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

##############################################
# OpenSpec completions
##############################################
# OPENSPEC:START
# OpenSpec shell completions configuration
fpath=("$HOME/.oh-my-zsh/custom/completions" $fpath)
# OPENSPEC:END
autoload -Uz compinit
compinit

##############################################
# Zsh + Oh My Zsh + Powerlevel10k
##############################################

# Path to Oh-My-Zsh
export ZSH="$HOME/.oh-my-zsh"

# Theme - Powerlevel10k
ZSH_THEME="powerlevel10k/powerlevel10k"

# Plugins
plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
    fzf
    docker
    kubectl
    npm
    macos
)

# Load Oh My Zsh
if [ -s "$ZSH/oh-my-zsh.sh" ]; then
  source "$ZSH/oh-my-zsh.sh"
fi

##############################################
# Environment
##############################################

export EDITOR="nvim"
export VISUAL="nvim"

export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export HISTSIZE=10000
export SAVEHIST=10000

# FZF - search hidden files and git-ignored files
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --no-ignore --exclude .git --exclude node_modules'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --no-ignore --exclude .git --exclude node_modules'

# Ripgrep config file location
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/.ripgreprc"

# Catppuccin for fzf
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# bat theme
export BAT_THEME="Catppuccin Mocha"

##############################################
# PATH
##############################################

# Homebrew (Apple Silicon)
if [[ $(uname -m) == "arm64" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

export PATH="$HOME/.local/bin:$PATH"

##############################################
# Tools init
##############################################

# Hide control chars like ^C
stty -echoctl

# zoxide (better cd)
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# fzf bindings
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Ghostty integration
if [[ -n "$GHOSTTY_RESOURCES_DIR" ]]; then
  source "$GHOSTTY_RESOURCES_DIR/shell-integration/zsh/ghostty-integration"
fi

# Yazi wrapper (cd on exit)
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  command yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd < "$tmp"
  [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}

##############################################
# Aliases
##############################################

[ -f "$HOME/.config/zsh/aliases.zsh" ] && source "$HOME/.config/zsh/aliases.zsh"

##############################################
# Key bindings
##############################################

bindkey -v
bindkey '^R' history-incremental-search-backward
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

##############################################
# Powerlevel10k config
##############################################

[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

##############################################
# Final options
##############################################

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"

setopt aliases

alias claude-mem='bun "$HOME/.claude/plugins/marketplaces/thedotmack/plugin/scripts/worker-service.cjs"'
