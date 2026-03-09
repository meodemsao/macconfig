local wezterm = require("wezterm")

local config = wezterm.config_builder()

-- =============================================================================
-- Catppuccin Mocha Theme
-- =============================================================================
config.color_scheme = "Catppuccin Mocha"

-- =============================================================================
-- Font - JetBrainsMono Nerd Font (consistent across all tools)
-- =============================================================================
config.font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Regular" })
config.font_size = 14
config.harfbuzz_features = { "calt", "liga" }
config.cell_width = 1.0
config.line_height = 1.1

-- =============================================================================
-- Window
-- =============================================================================
config.window_padding = {
    left = 10,
    right = 10,
    top = 10,
    bottom = 10,
}
config.window_decorations = "RESIZE" -- Hidden titlebar, like Ghostty macos-titlebar-style = hidden
config.window_background_opacity = 0.95
config.macos_window_background_blur = 20

-- =============================================================================
-- Cursor
-- =============================================================================
config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 500
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

-- =============================================================================
-- Mouse
-- =============================================================================
config.hide_mouse_cursor_when_typing = true

-- =============================================================================
-- Clipboard - copy on select (like Ghostty)
-- =============================================================================
config.selection_word_boundary = " \t\n{}[]()\"'`,;:│"

-- =============================================================================
-- Tab Bar
-- =============================================================================
config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = false

-- =============================================================================
-- Scrollback
-- =============================================================================
config.scrollback_lines = 10000

-- =============================================================================
-- Shell
-- =============================================================================
config.default_prog = { "/bin/zsh" }

-- =============================================================================
-- Keybindings (matching Ghostty keybinds)
-- =============================================================================
config.keys = {
    -- Cmd+T = New tab
    {
        key = "t",
        mods = "SUPER",
        action = wezterm.action.SpawnTab("CurrentPaneDomain"),
    },
    -- Cmd+W = Close current pane/tab
    {
        key = "w",
        mods = "SUPER",
        action = wezterm.action.CloseCurrentPane({ confirm = true }),
    },
    -- Cmd+Shift+Left = Previous tab
    {
        key = "LeftArrow",
        mods = "SUPER|SHIFT",
        action = wezterm.action.ActivateTabRelative(-1),
    },
    -- Cmd+Shift+Right = Next tab
    {
        key = "RightArrow",
        mods = "SUPER|SHIFT",
        action = wezterm.action.ActivateTabRelative(1),
    },
    -- Cmd+Enter = Toggle fullscreen
    {
        key = "Enter",
        mods = "SUPER",
        action = wezterm.action.ToggleFullScreen,
    },
}

-- =============================================================================
-- Performance
-- =============================================================================
config.front_end = "WebGpu"
config.webgpu_power_preference = "HighPerformance"

return config
