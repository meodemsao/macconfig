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

print_success "All Homebrew packages installed"
