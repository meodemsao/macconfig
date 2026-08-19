-- Telescope configuration for searching hidden and git-ignored files
return {
  "nvim-telescope/telescope.nvim",
  keys = {
    -- Override default find_files to include hidden files
    {
      "<leader>ff",
      function()
        require("telescope.builtin").find_files({
          hidden = true,
          no_ignore = false, -- Still respect .gitignore
          follow = true,
        })
      end,
      desc = "Find Files (hidden)",
    },
    -- Search ALL files including .env (git-ignored)
    {
      "<leader>fA",
      function()
        require("telescope.builtin").find_files({
          hidden = true,
          no_ignore = true,
          no_ignore_parent = true,
          follow = true,
        })
      end,
      desc = "Find All Files (hidden + git-ignored)",
    },
    -- Override live_grep to include hidden files
    {
      "<leader>fg",
      function()
        require("telescope.builtin").live_grep({
          additional_args = function()
            return { "--hidden", "--no-ignore", "--glob=!.git/", "--glob=!node_modules/" }
          end,
        })
      end,
      desc = "Grep (hidden + git-ignored)",
    },
  },
  opts = {
    defaults = {
      -- Minimal ignore patterns - only exclude .git and node_modules
      file_ignore_patterns = {
        "^%.git/",
        "node_modules/",
      },
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
        "--no-ignore",
        "--glob=!.git/",
        "--glob=!node_modules/",
      },
    },
    pickers = {
      find_files = {
        -- Force fd to search hidden and ignored files
        find_command = { "fd", "--type", "f", "--hidden", "--no-ignore", "--exclude", ".git", "--exclude", "node_modules" },
        hidden = true,
        no_ignore = true,
        follow = true,
      },
    },
  },
}
