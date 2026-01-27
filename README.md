# Dotfiles for macOS

Bộ dotfiles để setup môi trường terminal cho macOS với theme **Catppuccin Mocha** thống nhất.

## ✨ Features

- **Ghostty Terminal** - Modern, fast terminal emulator
- **Oh My Zsh** - Zsh framework với plugins hữu ích
- **Starship Prompt** - Cross-shell prompt đẹp và nhanh
- **LazyVim** - Neovim config sẵn sàng sử dụng
- **Tmux** - Terminal multiplexer

## 🛠️ CLI Tools

| Tool | Thay thế |
|------|----------|
| `bat` | `cat` |
| `eza` | `ls` |
| `ripgrep` | `grep` |
| `fd` | `find` |
| `zoxide` | `cd` |
| `fzf` | fuzzy finder |
| `jq` | JSON processor |
| `lazygit` | git TUI |
| `delta` | git diff |

## 📋 Requirements

- macOS
- [Ghostty](https://ghostty.org/) terminal
- Git

## 🚀 Installation

```bash
git clone https://github.com/YOUR_USERNAME/dotfile.git ~/dotfile
cd ~/dotfile
./install.sh
```

## 📁 Structure

```
dotfile/
├── install.sh          # Main install script
├── scripts/
│   ├── brew.sh         # Homebrew & packages
│   ├── ohmyzsh.sh      # Oh My Zsh setup
│   └── symlink.sh      # Create symlinks
├── ghostty/config      # Ghostty config
├── zsh/
│   ├── .zshrc          # Zsh config
│   └── aliases.zsh     # Custom aliases
├── nvim/               # LazyVim config
└── tmux/tmux.conf      # Tmux config
```

## 🎨 Theme

Sử dụng **Catppuccin Mocha** xuyên suốt:
- Ghostty
- Neovim (LazyVim)
- Tmux
- bat

## 📝 License

MIT
