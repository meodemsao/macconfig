#!/bin/bash

# ==============================================================================
# Clean Script - Remove old configurations
# ==============================================================================

DOTFILE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

# Colors (inherited from parent script or define here)
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}!${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

# Backup and remove file/directory
backup_and_remove() {
    local target="$1"
    local name=$(basename "$target")
    
    if [ -e "$target" ] || [ -L "$target" ]; then
        # Create backup directory if first backup
        if [ ! -d "$BACKUP_DIR" ]; then
            mkdir -p "$BACKUP_DIR"
            print_warning "Backup directory: $BACKUP_DIR"
        fi
        
        # Backup if it's a real file/directory (not a symlink)
        if [ -e "$target" ] && [ ! -L "$target" ]; then
            cp -r "$target" "$BACKUP_DIR/$name"
            print_warning "Backed up: $target"
        fi
        
        # Remove the file/symlink/directory
        rm -rf "$target"
        print_success "Removed: $target"
    fi
}

echo -e "\n${BLUE}🧹 Cleaning old configurations...${NC}\n"

# ==============================================================================
# Zsh related files
# ==============================================================================

# Main zsh config
backup_and_remove "$HOME/.zshrc"
backup_and_remove "$HOME/.zshrc.backup"
backup_and_remove "$HOME/.zshrc.pre-oh-my-zsh"

# Powerlevel10k config
backup_and_remove "$HOME/.p10k.zsh"

# Zsh config directory
backup_and_remove "$HOME/.config/zsh"

# Zsh history and cache
backup_and_remove "$HOME/.zsh_history"
backup_and_remove "$HOME/.zsh_sessions"
backup_and_remove "$HOME/.zcompdump"

# Remove all zcompdump files
for f in "$HOME"/.zcompdump*; do
    if [ -e "$f" ]; then
        rm -f "$f"
        print_success "Removed: $f"
    fi
done

# Powerlevel10k cache
backup_and_remove "$HOME/.cache/p10k-instant-prompt-$(whoami).zsh"
backup_and_remove "$HOME/.cache/p10k-$(whoami)"

# ==============================================================================
# Oh My Zsh
# ==============================================================================

backup_and_remove "$HOME/.oh-my-zsh"

# ==============================================================================
# Terminal configs
# ==============================================================================

# Ghostty
backup_and_remove "$HOME/.config/ghostty"

# ==============================================================================
# Editor configs
# ==============================================================================

# Neovim
backup_and_remove "$HOME/.config/nvim"
backup_and_remove "$HOME/.local/share/nvim"
backup_and_remove "$HOME/.local/state/nvim"
backup_and_remove "$HOME/.cache/nvim"

# ==============================================================================
# Tmux (Oh My Tmux)
# ==============================================================================

backup_and_remove "$HOME/.tmux.conf"
backup_and_remove "$HOME/.tmux.conf.local"
backup_and_remove "$HOME/.tmux"

# ==============================================================================
# Starship
# ==============================================================================

backup_and_remove "$HOME/.config/starship.toml"

# ==============================================================================
# Other dotfiles that might conflict
# ==============================================================================

# Old alias files that might exist
backup_and_remove "$HOME/.aliases"
backup_and_remove "$HOME/.bash_aliases"
backup_and_remove "$HOME/.zsh_aliases"

echo -e "\n${GREEN}✓ Cleanup complete!${NC}"

if [ -d "$BACKUP_DIR" ]; then
    echo -e "${YELLOW}Your old configs are backed up at: $BACKUP_DIR${NC}\n"
fi
