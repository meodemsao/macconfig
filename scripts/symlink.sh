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

# Terminal config (based on $TERMINAL selection)
if [ "$TERMINAL" = "wezterm" ]; then
    create_symlink "$DOTFILE_DIR/wezterm" "$HOME/.config/wezterm"
else
    create_symlink "$DOTFILE_DIR/ghostty" "$HOME/.config/ghostty"
fi

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

# Yazi file manager
create_symlink "$DOTFILE_DIR/yazi" "$HOME/.config/yazi"

# AeroSpace tiling window manager
create_symlink "$DOTFILE_DIR/aerospace" "$HOME/.config/aerospace"

# yabai + skhd (optional, only if INSTALL_YABAI_SKHD=true)
if [ "$INSTALL_YABAI_SKHD" = "true" ]; then
    create_symlink "$DOTFILE_DIR/yabai" "$HOME/.config/yabai"
    create_symlink "$DOTFILE_DIR/skhd" "$HOME/.config/skhd"
fi

print_success "All symlinks created"
