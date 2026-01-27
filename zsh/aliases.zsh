# ==============================================================================
# Custom Aliases
# ==============================================================================

# ------------------------------------------------------------------------------
# Modern CLI Replacements
# ------------------------------------------------------------------------------

# bat - better cat
alias cat="bat"

# eza - better ls
alias ls="eza --icons --group-directories-first"
alias ll="eza -la --icons --group-directories-first"
alias la="eza -a --icons --group-directories-first"
alias lt="eza --tree --icons --level=2"
alias l="eza -l --icons --group-directories-first"

# ripgrep - better grep
alias grep="rg"

# fd - better find
alias find="fd"

# zoxide - better cd (already aliased via eval)
alias cd="z"

# ------------------------------------------------------------------------------
# Git Shortcuts
# ------------------------------------------------------------------------------

alias g="git"
alias gs="git status"
alias ga="git add"
alias gaa="git add --all"
alias gc="git commit"
alias gcm="git commit -m"
alias gp="git push"
alias gpl="git pull"
alias gco="git checkout"
alias gb="git branch"
alias gd="git diff"
alias gl="git log --oneline -n 20"
alias glog="git log --graph --oneline --decorate"
alias lg="lazygit"

# ------------------------------------------------------------------------------
# Neovim / Vim
# ------------------------------------------------------------------------------

alias vim="nvim"
alias v="nvim"
alias vi="nvim"

# ------------------------------------------------------------------------------
# Tmux
# ------------------------------------------------------------------------------

alias t="tmux"
alias ta="tmux attach"
alias tl="tmux list-sessions"
alias tn="tmux new-session -s"

# ------------------------------------------------------------------------------
# Directory Navigation
# ------------------------------------------------------------------------------

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias ~="cd ~"
alias -- -="cd -"

# ------------------------------------------------------------------------------
# Utility
# ------------------------------------------------------------------------------

# Clear screen
alias c="clear"
alias cls="clear"

# Reload zshrc
alias reload="source ~/.zshrc"

# Show PATH entries
alias path='echo -e ${PATH//:/\\n}'

# Quick edit config files
alias zshrc="nvim ~/.zshrc"
alias vimrc="nvim ~/.config/nvim"
alias tmuxconf="nvim ~/.tmux.conf"

# Disk usage
alias du="du -h"
alias df="df -h"

# Network
alias ip="curl -s https://ipinfo.io/ip"
alias localip="ipconfig getifaddr en0"

# Confirm before overwrite
alias cp="cp -i"
alias mv="mv -i"
alias rm="rm -i"

# Make directory and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# ------------------------------------------------------------------------------
# macOS Specific
# ------------------------------------------------------------------------------

# Open in Finder
alias o="open ."
alias finder="open ."

# Show/hide hidden files in Finder
alias showfiles="defaults write com.apple.finder AppleShowAllFiles YES; killall Finder"
alias hidefiles="defaults write com.apple.finder AppleShowAllFiles NO; killall Finder"

# Flush DNS cache
alias flushdns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"

# Empty trash
alias emptytrash="sudo rm -rf ~/.Trash/*"
