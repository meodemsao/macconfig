-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

local opt = vim.opt

-- General
opt.autowrite = true -- Enable auto write
opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.mouse = "a" -- Enable mouse mode

-- UI
opt.cursorline = true -- Enable highlighting of the current line
opt.number = true -- Print line number
opt.relativenumber = true -- Relative line numbers
opt.scrolloff = 8 -- Lines of context
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = "yes" -- Always show the signcolumn
opt.termguicolors = true -- True color support
opt.wrap = false -- Disable line wrap

-- Indentation
opt.expandtab = true -- Use spaces instead of tabs
opt.shiftwidth = 2 -- Size of an indent
opt.tabstop = 2 -- Number of spaces tabs count for
opt.smartindent = true -- Insert indents automatically

-- Search
opt.ignorecase = true -- Ignore case
opt.smartcase = true -- Don't ignore case with capitals

-- Undo
opt.undofile = true
opt.undolevels = 10000

-- Split
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new windows right of current

-- Misc
opt.updatetime = 200 -- Save swap file faster
opt.timeoutlen = 300 -- Lower for faster which-key popup

-- Font (for GUI like Neovide)
opt.guifont = "JetBrainsMono Nerd Font:h14"
