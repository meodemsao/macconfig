#!/bin/bash

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Dotfile directory
DOTFILE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

print_header() {
    echo -e "\n${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}  $1${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}\n"
}

print_success() {
    echo -e "${GREEN}✓${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}!${NC} $1"
}

print_error() {
    echo -e "${RED}✗${NC} $1"
}

# Export functions for subscripts
export -f print_success
export -f print_warning
export -f print_error
export RED GREEN YELLOW BLUE CYAN NC

# Check macOS
if [[ "$OSTYPE" != "darwin"* ]]; then
    print_error "This script only works on macOS"
    exit 1
fi

print_header "🚀 Dotfiles Installation"

echo "This will install and configure:"
echo "  • Homebrew & CLI tools"
echo "  • Oh My Zsh with Powerlevel10k"
echo "  • Zsh plugins & aliases"
echo "  • Terminal emulator (Ghostty or WezTerm)"
echo "  • LazyVim (Catppuccin)"
echo "  • Tmux (Catppuccin)"
echo "  • Raycast (Spotlight replacement)"
echo "  • AeroSpace (Tiling Window Manager)"
echo ""
echo -e "  ${CYAN}Optional:${NC}"
echo "  • yabai + skhd (run with INSTALL_YABAI_SKHD=true ./install.sh)"
echo ""
echo -e "${YELLOW}⚠️  Warning: This will REMOVE and REPLACE existing configs!${NC}"
echo ""

read -r -p "Continue? (y/n) " REPLY
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    print_warning "Installation cancelled"
    exit 0
fi

# ==============================================================================
# Terminal Selection
# ==============================================================================
echo ""
echo -e "${BLUE}Select terminal emulator:${NC}"
echo "  1) Ghostty (default)"
echo "  2) WezTerm"
echo ""
read -r -p "Choice [1]: " TERMINAL_CHOICE
TERMINAL_CHOICE=${TERMINAL_CHOICE:-1}

case $TERMINAL_CHOICE in
    2) TERMINAL="wezterm" ;;
    *) TERMINAL="ghostty" ;;
esac

export TERMINAL
print_success "Selected terminal: $TERMINAL"

# ==============================================================================
# Step 1: Clean old configurations
# ==============================================================================
print_header "🧹 Cleaning Old Configurations"

echo "Do you want to remove existing configs first?"
echo "  (This ensures a clean installation without conflicts)"
echo ""
read -r -p "Clean old configs? (y/n) " REPLY

if [[ $REPLY =~ ^[Yy]$ ]]; then
    source "$DOTFILE_DIR/scripts/clean.sh"
else
    print_warning "Skipping cleanup (existing configs may cause conflicts)"
fi

# ==============================================================================
# Step 2: Install Xcode Command Line Tools
# ==============================================================================
print_header "📦 Xcode Command Line Tools"
if xcode-select -p &>/dev/null; then
    print_success "Already installed"
else
    print_warning "Installing Xcode Command Line Tools..."
    xcode-select --install
    read -p "Press Enter after installation completes..."
fi

# ==============================================================================
# Step 3: Install Homebrew & CLI Tools
# ==============================================================================
print_header "🍺 Homebrew & CLI Tools"
source "$DOTFILE_DIR/scripts/brew.sh"

# ==============================================================================
# Step 3.5: Configure Raycast (replace Spotlight)
# ==============================================================================
print_header "🔍 Raycast (Spotlight Replacement)"
source "$DOTFILE_DIR/scripts/raycast.sh"

# ==============================================================================
# Step 4: Install Oh My Zsh & Plugins
# ==============================================================================
print_header "🐚 Oh My Zsh & Powerlevel10k"
source "$DOTFILE_DIR/scripts/ohmyzsh.sh"

# ==============================================================================
# Step 5: Create Symlinks
# ==============================================================================
print_header "🔗 Creating Symlinks"
source "$DOTFILE_DIR/scripts/symlink.sh"

# ==============================================================================
# Step 6: Install Oh My Tmux
# ==============================================================================
print_header "📦 Oh My Tmux"

if [ ! -d "$HOME/.tmux" ]; then
    print_warning "Installing Oh My Tmux..."
    cd ~
    git clone --single-branch https://github.com/gpakosz/.tmux.git
    ln -s -f .tmux/.tmux.conf
    print_success "Oh My Tmux installed"
else
    print_success "Oh My Tmux already installed"
fi

# Ensure .tmux.conf.local symlink exists
if [ ! -L "$HOME/.tmux.conf.local" ]; then
    ln -sf "$DOTFILE_DIR/tmux/.tmux.conf.local" "$HOME/.tmux.conf.local"
    print_success "Linked .tmux.conf.local"
fi

# ==============================================================================
# Step 7: Install bat themes for Catppuccin
# ==============================================================================
print_header "🎨 Installing Catppuccin theme for bat"

BAT_THEMES_DIR="$(bat --config-dir)/themes"
if [ ! -d "$BAT_THEMES_DIR" ]; then
    mkdir -p "$BAT_THEMES_DIR"
fi

if [ ! -f "$BAT_THEMES_DIR/Catppuccin Mocha.tmTheme" ]; then
    curl -sL "https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Mocha.tmTheme" \
        -o "$BAT_THEMES_DIR/Catppuccin Mocha.tmTheme"
    bat cache --build
    print_success "Catppuccin theme for bat installed"
else
    print_success "Catppuccin theme for bat already exists"
fi

# ==============================================================================
# Final: Reload shell
# ==============================================================================
print_header "✅ Installation Complete!"

echo -e "${GREEN}Your dotfiles have been installed successfully!${NC}"
echo ""
echo "Next steps:"
echo "  1. ${CYAN}Close this terminal and open a new one${NC}"
echo "     (or run: exec zsh)"
echo ""
echo "  2. If prompted, configure Powerlevel10k with:"
echo "     ${CYAN}p10k configure${NC}"
echo ""
echo "  3. Open tmux and press ${CYAN}prefix + I${NC} to install plugins"
echo ""
echo "  4. Install a Nerd Font if you haven't:"
echo "     ${CYAN}brew install --cask font-jetbrains-mono-nerd-font${NC}"
echo ""
echo -e "${GREEN}Enjoy your new setup! 🎉${NC}"
echo ""

# Ask to reload shell now
read -p "Reload shell now? (y/n) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    print_success "Reloading shell..."
    exec zsh
fi
