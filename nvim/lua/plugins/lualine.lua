-- Lualine configuration
-- Keep statusline at bottom (tmux status bar is now at top)

return {
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        -- Use global statusline at bottom
        globalstatus = true,
      },
      -- Default sections at bottom statusline
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } }, -- Show relative path
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { "filename", path = 1 } },
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "location" },
      },
      -- Disable winbar (no top bar in neovim)
      winbar = {},
      inactive_winbar = {},
    },
  },
}
