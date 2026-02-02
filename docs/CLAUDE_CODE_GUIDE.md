# 🤖 Claude Code Integration Guide

Hướng dẫn sử dụng Claude Code trong Neovim với LazyVim.

## 📦 Installation

Plugin đã được cài đặt sẵn trong `nvim/lua/plugins/claudecode.lua`.

### Kiểm tra Claude CLI

```bash
# Kiểm tra version
claude --version

# Kiểm tra health
claude doctor
```

Nếu chưa có Claude CLI, cài đặt:
```bash
# Recommended: Native binary
curl -fsSL claude.ai/install.sh | bash

# Hoặc via npm
npm install -g @anthropic-ai/claude-code
```

## 🚀 Quick Start

### 1. Khởi động Claude trong Neovim

```vim
:ClaudeCode
```

Hoặc nhấn: `<leader>ac`

### 2. Gửi context cho Claude

**Gửi toàn bộ file hiện tại:**
```vim
<leader>ab
```

**Gửi text đã chọn (visual mode):**
1. Select text trong visual mode (`v`, `V`, or `Ctrl+v`)
2. Nhấn `<leader>as`

**Gửi file từ file explorer:**
- Trong NvimTree/Neo-tree/Oil: Di chuyển đến file, nhấn `<leader>as`

### 3. Làm việc với Claude

Claude có thể:
- ✅ Xem file hiện tại real-time
- ✅ Mở và chỉnh sửa files
- ✅ Hiển thị diffs cho proposed changes
- ✅ Truy cập diagnostics và workspace info
- ✅ Chạy terminal commands
- ✅ Search trong codebase

## ⌨️ Keybindings

### Core Commands

| Key | Command | Mô tả |
|-----|---------|-------|
| `<leader>ac` | `:ClaudeCode` | Toggle Claude terminal |
| `<leader>af` | `:ClaudeCodeFocus` | Focus/toggle Claude terminal |
| `<leader>ar` | `:ClaudeCode --resume` | Resume session cuối |
| `<leader>aC` | `:ClaudeCode --continue` | Continue conversation |
| `<leader>am` | `:ClaudeCodeSelectModel` | Chọn Claude model |

### Context Management

| Key | Mode | Command | Mô tả |
|-----|------|---------|-------|
| `<leader>ab` | Normal | `:ClaudeCodeAdd %` | Add buffer hiện tại |
| `<leader>as` | Visual | `:ClaudeCodeSend` | Send selection |
| `<leader>as` | File Tree | `:ClaudeCodeTreeAdd` | Add file từ tree |

### Diff Management

| Key | Command | Mô tả |
|-----|---------|-------|
| `<leader>aa` | `:ClaudeCodeDiffAccept` | Accept changes |
| `<leader>ad` | `:ClaudeCodeDiffDeny` | Reject changes |
| `:w` | - | Save = Accept diff |
| `:q` | - | Quit = Reject diff |

## 💡 Use Cases

### 1. Code Review & Refactoring

```vim
" 1. Mở file cần review
:e src/main.rs

" 2. Add file vào Claude context
<leader>ab

" 3. Mở Claude và hỏi
<leader>ac
> Review this code and suggest improvements
```

### 2. Debug Code

```vim
" 1. Select đoạn code lỗi (visual mode)
v (select text)

" 2. Send to Claude
<leader>as

" 3. Trong Claude terminal
> Why is this code throwing an error?
```

### 3. Generate Code

```vim
" 1. Mở Claude
<leader>ac

" 2. Describe what you need
> Create a function to parse JSON and handle errors in Rust

" 3. Claude sẽ tạo code và show diff
" 4. Review diff và accept/reject
<leader>aa  " Accept
<leader>ad  " Reject
```

### 4. Explain Complex Code

```vim
" 1. Select đoạn code phức tạp
" 2. Send to Claude: <leader>as
" 3. Ask:
> Explain this code step by step
```

### 5. Add Tests

```vim
" 1. Add function cần test
<leader>ab

" 2. Trong Claude:
> Write comprehensive tests for this function
```

## 🎯 Working with Diffs

Khi Claude đề xuất changes, Neovim sẽ hiển thị diff view:

### Review Diff
- Di chuyển giữa các changes: `]c` / `[c`
- Xem both sides: Split view tự động

### Accept Changes
- **Option 1**: Save file `:w`
- **Option 2**: Keybinding `<leader>aa`

### Reject Changes
- **Option 1**: Quit without save `:q`
- **Option 2**: Keybinding `<leader>ad`

### Edit Before Accepting
Bạn có thể edit suggestions của Claude trước khi accept:
1. Edit trong diff view
2. Save `:w` để accept with edits

## 🔧 Advanced Configuration

### Custom Terminal Command

Nếu Claude CLI không ở default location:

```lua
-- nvim/lua/plugins/claudecode.lua
return {
  {
    "coder/claudecode.nvim",
    opts = {
      terminal_cmd = "~/.claude/local/claude", -- Custom path
    },
    -- ... rest of config
  },
}
```

### Check Installation Type

```bash
# Kiểm tra where claude is installed
which claude

# Global: /usr/local/bin/claude hoặc /opt/homebrew/bin/claude
# Local: alias to ~/.claude/local/claude
```

## 📝 Tips & Tricks

### 1. Resume Last Session
```vim
<leader>ar  " Resume với toàn bộ context từ session trước
```

### 2. Switch Models
```vim
<leader>am  " Chọn giữa claude-3.5-sonnet, claude-3-opus, etc.
```

### 3. Quickly Add Current File
```vim
<leader>ab  " Add file hiện tại vào context
```

### 4. Send Multiple Files
- Use file tree (NvimTree/Neo-tree)
- Navigate to files và nhấn `<leader>as` trên từng file

### 5. Clear Context
- Close và restart Claude: `<leader>ac` (2 lần)

## 🐛 Troubleshooting

### Claude không connect
```bash
# Check Claude health
claude doctor

# Restart Neovim
# Check logs
:messages
```

### Diff không hiển thị
- Đảm bảo file đã được lưu trước khi Claude make changes
- Check `:ClaudeCodeDiffAccept` command có hoạt động không

### Terminal không mở
- Check Snacks.nvim đã được cài: `:Lazy`
- Restart Neovim

## 📚 Resources

- [Claude Code Documentation](https://docs.anthropic.com/en/docs/claude-code)
- [claudecode.nvim GitHub](https://github.com/coder/claudecode.nvim)
- [Protocol Documentation](https://github.com/coder/claudecode.nvim/blob/main/PROTOCOL.md)

## 🎓 Example Workflow

```vim
" 1. Start working on a feature
:e src/feature.rs

" 2. Add current file to Claude
<leader>ab

" 3. Open Claude
<leader>ac

" 4. Describe feature
> Implement user authentication with JWT tokens

" 5. Claude generates code and shows diff
" 6. Review diff, edit if needed

" 7. Accept changes
<leader>aa

" 8. Continue conversation
<leader>aC

" 9. Ask for tests
> Now write tests for this implementation

" 10. Repeat process
```

Happy coding with Claude! 🚀
