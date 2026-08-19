# Dotfiles for macOS

Bộ dotfiles để setup môi trường terminal cho macOS với theme **Catppuccin Mocha** thống nhất.

## ✨ Features

- **Terminal Emulator** - Ghostty (default) hoặc WezTerm (tuỳ chọn)
- **Oh My Zsh + Powerlevel10k** - Zsh framework với theme đẹp
- **Oh My Tmux** - Tmux configuration framework
- **opensessions** - Sidebar cho tmux: chuyển session, trạng thái agent, breadcrumb repo
- **LazyVim + Claude Code** - Neovim config với AI coding assistant
- **Raycast** - Launcher mạnh, chạy song song với Spotlight (hotkey riêng)
- **AeroSpace** - Tiling window manager cho macOS (default)
- **yabai + skhd** - Alternative tiling WM (optional)
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

## 🔍 Cấu hình tìm kiếm (Search Configuration)

Dotfiles này đã được cấu hình để tìm kiếm **hidden files** và **git-ignored files**:

### Ripgrep (rg)
- Config: `~/.config/ripgrep/.ripgreprc`
- Tìm kiếm hidden files theo mặc định
- Tìm kiếm git-ignored files theo mặc định
- Loại trừ: `.git/`, `node_modules/`, `.DS_Store`, swap files

### fd
- Config: `~/.config/fd/.fdignore`
- Dùng `--hidden` để tìm hidden files
- Dùng `--no-ignore` để tìm git-ignored files

### FZF
- Đã cấu hình để tìm hidden và git-ignored files
- Loại trừ: `.git/`, `node_modules/`

### Search Aliases
```bash
# Tìm kiếm thông thường (tôn trọng .gitignore)
rg <pattern>      # ripgrep
fd <pattern>      # fd

# Bao gồm hidden files
rgh <pattern>     # ripgrep hidden
fdh <pattern>     # fd hidden

# Bao gồm hidden + git-ignored files
rga <pattern>     # ripgrep all
fda <pattern>     # fd all
```

## 📋 Requirements

- macOS
- [Ghostty](https://ghostty.org/) hoặc [WezTerm](https://wezfurlong.org/wezterm/) (cài qua install script)
- Git
- [Claude Code CLI](https://docs.anthropic.com/en/docs/claude-code) (optional, for AI coding)

## 🚀 Installation

```bash
git clone https://github.com/YOUR_USERNAME/dotfile.git ~/Desktop/Projects/dotfile
cd ~/Desktop/Projects/dotfile
./install.sh
```

Để cài thêm yabai + skhd (optional):
```bash
INSTALL_YABAI_SKHD=true ./install.sh
```

Script sẽ tự động:
1. Hỏi chọn terminal emulator (Ghostty/WezTerm)
2. Cài đặt Homebrew & các CLI tools
3. Cài đặt Raycast (không đụng tới Spotlight)
4. Set Nerd Font cho tất cả profiles của Terminal.app
5. Setup Oh My Zsh với Powerlevel10k
6. Cài đặt Oh My Tmux
7. Tạo symlinks cho tất cả configs
8. Cài đặt Catppuccin themes

Tuỳ chọn cho font Terminal.app:
```bash
SKIP_TERMINAL_APP_FONT=true ./install.sh          # bỏ qua, giữ font hiện tại
TERMINAL_APP_FONT="FiraCodeNFM-Reg" ./install.sh  # dùng FiraCode thay JetBrainsMono
```

## 📁 Structure

```
dotfile/
├── install.sh              # Main install script
├── scripts/
│   ├── clean.sh           # Clean old configs
│   ├── brew.sh            # Homebrew & packages
│   ├── ohmyzsh.sh         # Oh My Zsh + Powerlevel10k
│   ├── symlink.sh         # Create symlinks
│   ├── raycast.sh         # Raycast setup (không đụng Spotlight)
│   └── terminal-app.sh    # Nerd Font cho Terminal.app (mọi profile)
├── ghostty/
│   └── config             # Ghostty config (Catppuccin)
├── wezterm/
│   └── wezterm.lua        # WezTerm config (Catppuccin)
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
├── tmux/
│   └── .tmux.conf.local   # Oh My Tmux config (Catppuccin)
├── ripgrep/
│   └── .ripgreprc         # Ripgrep config (search hidden & git-ignored)
├── fd/
│   └── .fdignore          # fd ignore patterns
├── aerospace/
│   └── aerospace.toml     # AeroSpace tiling WM config (default)
├── yabai/                 # (optional) yabai config
└── skhd/
    └── skhdrc             # (optional) skhd keybindings for yabai
```

## 🎨 Theme

Sử dụng **Catppuccin Mocha** xuyên suốt:
- Ghostty / WezTerm
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

### 1. Gán hotkey cho Raycast
```bash
# Spotlight giữ nguyên Cmd+Space
# Mở Raycast → Preferences (Cmd+,) → General → Record Hotkey
# Chọn tổ hợp không trùng Spotlight, ví dụ Option+Space
```

### 2. Configure Powerlevel10k
```bash
p10k configure
```

### 3. Start Tmux and install plugins
```bash
tmux
# Nhấn Ctrl+a rồi Shift+i
```
Cài `tmux-resurrect`, `tmux-continuum` và `opensessions`.
Lần đầu nạp, `opensessions` tự tải binary prebuilt về `~/.tmux/plugins/opensessions/bin/`.

## 🖥️ Tmux Keybindings

Prefix: `Ctrl+b` (hoặc `Ctrl+a`)

| Phím | Chức năng |
|------|-----------|
| `prefix` + `Ctrl+s` | Lưu session (tmux-resurrect) |
| `prefix` + `Ctrl+r` | Khôi phục session (tmux-resurrect) |
| `prefix` + `s` | Trình chọn session có sẵn của tmux |
| `prefix` `o` → `s` | Mở/focus sidebar opensessions |
| `prefix` `o` → `t` | Bật/tắt sidebar |
| `prefix` `o` → `e` | Layout even-horizontal an toàn với sidebar |
| `prefix` `o` → `1`..`9` | Nhảy nhanh tới session thứ N |
| `prefix` + `Alt+1`..`9` | Nhảy nhanh tới session thứ N (không qua bảng `o`) |

Session được continuum tự lưu mỗi 15 phút và tự khôi phục khi mở tmux.

> `prefix` + `o` trước đây là chuyển pane (`select-pane -t :.+`) của Oh My Tmux,
> nay bị opensessions dùng làm bảng phím riêng.

### 4. Open Neovim để cài plugins
```bash
nvim
# LazyVim sẽ tự động cài plugins
```

### 5. AeroSpace sẽ tự khởi động cùng macOS
Cấu hình đã bật `start-at-login = true`.

## 🪟 AeroSpace Keybindings

| Phím tắt | Chức năng |
|----------|----------|
| `alt-shift-f` | **Toggle Fullscreen** |
| `alt-h/j/k/l` | Focus left/down/up/right |
| `alt-shift-h/j/k/l` | Move window left/down/up/right |
| `alt-1..9` | Switch to workspace 1-9 |
| `alt-shift-1..9` | Move window to workspace 1-9 |
| `alt-slash` | Toggle tiles layout |
| `alt-comma` | Toggle accordion layout |
| `alt-minus/equal` | Resize window |
| `alt-tab` | Switch to previous workspace |
| `alt-shift-semicolon` | Enter service mode |

## 📝 Custom Aliases

Xem file `zsh/aliases.zsh` để biết tất cả aliases. Một số aliases hữu ích:

```bash
# File listing
ll          # eza -la với icons
la          # eza -a với icons
lt          # tree view (2 levels)
cat         # bat với syntax highlighting

# Editor
v/vim/vi    # nvim

# Git
gs          # git status
ga          # git add
gc          # git commit
lg          # lazygit

# Search (tìm kiếm)
rg          # ripgrep (tôn trọng .gitignore)
rgh         # ripgrep hidden files
rga         # ripgrep all (bao gồm hidden + git-ignored)
fd          # fd find (tôn trọng .gitignore)
fdh         # fd hidden files
fda         # fd all (bao gồm hidden + git-ignored)
```

## 🔄 Update

```bash
cd ~/Desktop/Projects/dotfile
git pull
./install.sh  # Re-run để update configs
```

## 📝 License

MIT
