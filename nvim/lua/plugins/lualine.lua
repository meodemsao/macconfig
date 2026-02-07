-- Lualine configuration
-- Move statusline to top to avoid overlap with tmux status bar

return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- Keep the default sections but move to winbar (top of each window)
      -- This avoids overlap with tmux status bar at the bottom

      -- Copy current sections to winbar
      opts.winbar = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 1 } }, -- Show relative path
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      }

      opts.inactive_winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { "filename", path = 1 } },
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "location" },
      }

      -- Disable the bottom statusline completely
      opts.options = opts.options or {}
      opts.options.globalstatus = false

      opts.sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      }

      opts.inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      }

      return opts
    end,
  },
  
  -- Disable the bottom command line area padding if you want
  -- {
  --   "folke/noice.nvim",
  --   opts = {
  --     cmdline = {
  --       view = "cmdline", -- use classic cmdline at bottom
  --     },
  --   },
  -- },
}
