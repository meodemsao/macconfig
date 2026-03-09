#!/bin/bash

# Install Homebrew if not exists
if ! command -v brew &>/dev/null; then
    print_warning "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for Apple Silicon
    if [[ $(uname -m) == "arm64" ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
    print_success "Homebrew installed"
else
    print_success "Homebrew already installed"
fi

# Update Homebrew
print_warning "Updating Homebrew..."
brew update

# CLI tools to install
BREW_PACKAGES=(
    neovim
    fzf
    bat
    jq
    tmux
    eza
    ripgrep
    fd
    zoxide
    lazygit
    git-delta
    starship
    node         # Required for some Neovim plugins
    
    # Yazi file manager and optional dependencies
    yazi
    ffmpeg       # Video thumbnails
    sevenzip     # Archive preview/extraction
    poppler      # PDF preview
    resvg        # SVG preview
    imagemagick  # Image transformations
)

# Install packages
for package in "${BREW_PACKAGES[@]}"; do
    if brew list "$package" &>/dev/null; then
        print_success "$package already installed"
    else
        print_warning "Installing $package..."
        brew install "$package"
        print_success "$package installed"
    fi
done

# Install fzf key bindings
if [ -f "$(brew --prefix)/opt/fzf/install" ]; then
    print_warning "Setting up fzf..."
    $(brew --prefix)/opt/fzf/install --key-bindings --completion --no-update-rc --no-bash --no-fish
    print_success "fzf configured"
fi

# Install Nerd Fonts
print_warning "Installing Nerd Fonts..."
brew tap homebrew/cask-fonts 2>/dev/null || true

# JetBrainsMono Nerd Font
if brew list --cask font-jetbrains-mono-nerd-font &>/dev/null; then
    print_success "JetBrainsMono Nerd Font already installed"
else
    brew install --cask font-jetbrains-mono-nerd-font
    print_success "JetBrainsMono Nerd Font installed"
fi

# FiraCode Nerd Font
if brew list --cask font-fira-code-nerd-font &>/dev/null; then
    print_success "FiraCode Nerd Font already installed"
else
    brew install --cask font-fira-code-nerd-font
    print_success "FiraCode Nerd Font installed"
fi

# AeroSpace - Tiling Window Manager
print_warning "Installing AeroSpace..."
if brew list --cask nikitabobko/tap/aerospace &>/dev/null; then
    print_success "AeroSpace already installed"
else
    brew install --cask nikitabobko/tap/aerospace
    print_success "AeroSpace installed"
fi

# Raycast - Spotlight replacement
print_warning "Installing Raycast..."
if brew list --cask raycast &>/dev/null; then
    print_success "Raycast already installed"
else
    brew install --cask raycast
    print_success "Raycast installed"
fi

# Terminal emulator (based on $TERMINAL selection)
if [ "$TERMINAL" = "wezterm" ]; then
    print_warning "Installing WezTerm..."
    if brew list --cask wezterm &>/dev/null; then
        print_success "WezTerm already installed"
    else
        brew install --cask wezterm
        print_success "WezTerm installed"
    fi
else
    print_success "Using Ghostty terminal (install manually from https://ghostty.org/)"
fi

# yabai + skhd - Alternative Tiling Window Manager (optional)
# Set INSTALL_YABAI_SKHD=true to install these alongside AeroSpace
if [ "$INSTALL_YABAI_SKHD" = "true" ]; then
    print_warning "Installing yabai..."
    if brew list yabai &>/dev/null; then
        print_success "yabai already installed"
    else
        brew install koekeishiya/formulae/yabai
        print_success "yabai installed"
    fi

    print_warning "Installing skhd..."
    if brew list skhd &>/dev/null; then
        print_success "skhd already installed"
    else
        brew install koekeishiya/formulae/skhd
        print_success "skhd installed"
    fi
else
    print_success "Skipping yabai + skhd (optional, use INSTALL_YABAI_SKHD=true to enable)"
fi

print_success "All Homebrew packages installed"
