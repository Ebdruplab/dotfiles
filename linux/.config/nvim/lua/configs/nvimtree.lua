local M = {}

M.setup = function()
  -- Load NVChad's default nvim-tree config function
  local default_setup = require("nvchad.configs.nvimtree")

  -- Grab required plugins/configs NVChad uses
  local opts = {
    hijack_cursor = true,
    update_focused_file = {
      enable = true,
      update_root = true,
    },
    view = {
      width = 34,
      side = "left",
      preserve_window_proportions = true,
    },
    renderer = {
      highlight_git = true,
      icons = {
        show = {
          folder_arrow = false,
        },
        glyphs = {
          default = "",
          symlink = "",
          folder = {
            default = "",
            empty = "",
            empty_open = "",
            open = "",
            symlink = "",
            symlink_open = "",
          },
          git = {
            unstaged = "✗",
            staged = "✓",
            unmerged = "",
            renamed = "➜",
            untracked = "★",
            deleted = "",
            ignored = "◌",
          },
        },
      },
    },
    filters = {
      custom = { "^.git$" },
    },
    git = {
      enable = true,
      ignore = true,
    },
    -- Added my custom that when selecting a file
    -- We close the tree
    actions = {
      open_file = {
        quit_on_open = true,
      },
    },
  }

  require("nvim-tree").setup(opts)
end

return M
