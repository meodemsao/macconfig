# OPENSPEC:START
# OpenSpec shell completions configuration
fpath=("/Users/admin/.oh-my-zsh/custom/completions" $fpath)
autoload -Uz compinit
compinit
# OPENSPEC:END

# ==============================================================================
# Zsh Configuration with Powerlevel10k
# ==============================================================================

# Enable Powerlevel10k instant prompt (should stay at the top)
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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
source $ZSH/oh-my-zsh.sh

# ==============================================================================
# Environment Variables
# ==============================================================================

# Editor
export EDITOR="nvim"
export VISUAL="nvim"

# Language
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

# History
export HISTSIZE=10000
export SAVEHIST=10000

# FZF
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'

# Catppuccin theme for FZF
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# bat theme
export BAT_THEME="Catppuccin Mocha"

# ==============================================================================
# Path Additions
# ==============================================================================

# Homebrew (Apple Silicon)
if [[ $(uname -m) == "arm64" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Local bin
export PATH="$HOME/.local/bin:$PATH"

# ==============================================================================
# Tool Initializations
# ==============================================================================

# Zoxide (better cd)
eval "$(zoxide init zsh)"

# fzf key bindings and completion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Ghostty shell integration
if [[ -n "$GHOSTTY_RESOURCES_DIR" ]]; then
    source "$GHOSTTY_RESOURCES_DIR/shell-integration/zsh/ghostty-integration"
fi

# Yazi shell wrapper - allows changing directory when exiting
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    command yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd < "$tmp"
    [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
}

# ==============================================================================
# Custom Aliases
# ==============================================================================

# Load aliases from separate file
[ -f "$HOME/.config/zsh/aliases.zsh" ] && source "$HOME/.config/zsh/aliases.zsh"

# ==============================================================================
# Key Bindings
# ==============================================================================

# Use vim-style line editing
bindkey -v

# Better history search
bindkey '^R' history-incremental-search-backward
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward

# ==============================================================================
# Powerlevel10k Configuration
# ==============================================================================

# Load p10k config
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ==============================================================================
# Re-enable Aliases (p10k disables them)
# ==============================================================================
setopt aliases

# Claude Code CLI - CLIProxyAPI Configuration
export ANTHROPIC_BASE_URL="http://localhost:8317"
export ANTHROPIC_API_KEY="sk-EPJE1moyRxkq1IcATwdrbz0DzSEeU769"

alias claude-mem='bun "/Users/admin/.claude/plugins/marketplaces/thedotmack/plugin/scripts/worker-service.cjs"'
