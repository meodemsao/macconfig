#!/bin/bash

DOTFILE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Backup existing config
backup_if_exists() {
    if [ -e "$1" ] && [ ! -L "$1" ]; then
        print_warning "Backing up $1 to $1.backup"
        mv "$1" "$1.backup"
    fi
}

# Create symlink
create_symlink() {
    local source="$1"
    local target="$2"
    
    backup_if_exists "$target"
    
    # Remove existing symlink
    if [ -L "$target" ]; then
        rm "$target"
    fi
    
    # Create parent directory if needed
    mkdir -p "$(dirname "$target")"
    
    ln -sf "$source" "$target"
    print_success "Linked $target -> $source"
}

# Create config directory
mkdir -p "$HOME/.config"

# Ghostty
create_symlink "$DOTFILE_DIR/ghostty" "$HOME/.config/ghostty"

# Neovim (LazyVim)
create_symlink "$DOTFILE_DIR/nvim" "$HOME/.config/nvim"

# Tmux (Oh My Tmux - only link the local config file)
# Note: ~/.tmux.conf should be a symlink to ~/.tmux/.tmux.conf (created by Oh My Tmux installer)
create_symlink "$DOTFILE_DIR/tmux/.tmux.conf.local" "$HOME/.tmux.conf.local"

# Zsh
create_symlink "$DOTFILE_DIR/zsh/.zshrc" "$HOME/.zshrc"

# Powerlevel10k config
create_symlink "$DOTFILE_DIR/zsh/.p10k.zsh" "$HOME/.p10k.zsh"

# Create zsh config directory for aliases
mkdir -p "$HOME/.config/zsh"
create_symlink "$DOTFILE_DIR/zsh/aliases.zsh" "$HOME/.config/zsh/aliases.zsh"

# Starship config (optional, create if not exists)
if [ -f "$DOTFILE_DIR/starship/starship.toml" ]; then
    create_symlink "$DOTFILE_DIR/starship/starship.toml" "$HOME/.config/starship.toml"
fi

print_success "All symlinks created"
