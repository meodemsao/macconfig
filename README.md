# Dotfiles for macOS

Bộ dotfiles để setup môi trường terminal cho macOS với theme **Catppuccin Mocha** thống nhất.

## ✨ Features

- **Ghostty Terminal** - Modern, fast terminal emulator
- **Oh My Zsh + Powerlevel10k** - Zsh framework với theme đẹp
- **Oh My Tmux** - Tmux configuration framework
- **LazyVim + Claude Code** - Neovim config với AI coding assistant
- **Modern CLI Tools** - bat, eza, ripgrep, fd, fzf, và nhiều hơn nữa

## 🛠️ CLI Tools

| Tool | Thay thế | Mô tả |
|------|----------|-------|
| `bat` | `cat` | Syntax highlighting cho cat |
| `eza` | `ls` | Better ls với icons |
| `ripgrep` | `grep` | Super fast grep |
| `fd` | `find` | Better find |
| `zoxide` | `cd` | Smarter cd |
| `fzf` | - | Fuzzy finder |
| `jq` | - | JSON processor |
| `lazygit` | - | Git TUI |
| `delta` | - | Beautiful git diff |

## 📋 Requirements

- macOS
- [Ghostty](https://ghostty.org/) terminal
- Git
- [Claude Code CLI](https://docs.anthropic.com/en/docs/claude-code) (optional, for AI coding)

## 🚀 Installation

```bash
git clone https://github.com/YOUR_USERNAME/dotfile.git ~/Desktop/Projects/dotfile
cd ~/Desktop/Projects/dotfile
./install.sh
```

Script sẽ tự động:
1. Cài đặt Homebrew & các CLI tools
2. Setup Oh My Zsh với Powerlevel10k
3. Cài đặt Oh My Tmux
4. Tạo symlinks cho tất cả configs
5. Cài đặt Catppuccin themes

## 📁 Structure

```
dotfile/
├── install.sh              # Main install script
├── scripts/
│   ├── clean.sh           # Clean old configs
│   ├── brew.sh            # Homebrew & packages
│   ├── ohmyzsh.sh         # Oh My Zsh + Powerlevel10k
│   └── symlink.sh         # Create symlinks
├── ghostty/
│   └── config             # Ghostty config (Catppuccin)
├── zsh/
│   ├── .zshrc             # Zsh config
│   ├── .p10k.zsh          # Powerlevel10k config
│   └── aliases.zsh        # Custom aliases
├── nvim/
│   ├── init.lua           # LazyVim bootstrap
│   └── lua/
│       ├── config/        # Keymaps, options
│       └── plugins/       # Plugin configs
│           ├── colorscheme.lua
│           └── claudecode.lua  # Claude Code AI
└── tmux/
    └── .tmux.conf.local   # Oh My Tmux config (Catppuccin)
```

## 🎨 Theme

Sử dụng **Catppuccin Mocha** xuyên suốt:
- Ghostty
- Neovim (LazyVim)
- Oh My Tmux
- bat
- fzf

## 🤖 Claude Code Integration

Plugin Claude Code đã được cấu hình sẵn trong Neovim với các keybindings:

### Core Commands
- `<leader>ac` - Toggle Claude terminal
- `<leader>af` - Focus Claude terminal
- `<leader>ar` - Resume Claude session
- `<leader>aC` - Continue conversation
- `<leader>am` - Select Claude model

### Context Management
- `<leader>ab` - Add current buffer to context
- `<leader>as` - Send visual selection to Claude
- `<leader>as` - Add file from file tree (NvimTree/Neo-tree/Oil)

### Diff Management
- `<leader>aa` - Accept Claude's suggested changes
- `<leader>ad` - Deny Claude's suggested changes

### Usage
```vim
" 1. Open Claude in Neovim
:ClaudeCode

" 2. Send context (visual mode)
" Select text, then: <leader>as

" 3. Claude can now:
" - See your current file
" - Open files
" - Show diffs
" - Make changes
```

## 🔧 Post-Installation

### 1. Configure Powerlevel10k
```bash
p10k configure
```

### 2. Start Tmux and install plugins
```bash
tmux
# Nhấn Ctrl+a rồi Shift+i
```

### 3. Open Neovim để cài plugins
```bash
nvim
# LazyVim sẽ tự động cài plugins
```

## 📝 Custom Aliases

Xem file `zsh/aliases.zsh` để biết tất cả aliases. Một số aliases hữu ích:

```bash
ll          # eza -la với icons
la          # eza -a với icons
lt          # tree view (2 levels)
cat         # bat với syntax highlighting
v/vim/vi    # nvim
gs          # git status
ga          # git add
gc          # git commit
lg          # lazygit
```

## 🔄 Update

```bash
cd ~/Desktop/Projects/dotfile
git pull
./install.sh  # Re-run để update configs
```

## 📝 License

MIT
