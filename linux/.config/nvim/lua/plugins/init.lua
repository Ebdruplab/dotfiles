return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("nvchad.configs.lspconfig").defaults()
      require "configs.lspconfig"
    end,
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  {
  	"nvim-treesitter/nvim-treesitter",
  	opts = {
  		ensure_installed = {
   			"vim", "lua", "vimdoc",
        "html", "css"
  	},
   	},
  },
-- custom
  {
  "mg979/vim-visual-multi",
  branch = "master",
  init = function()
    vim.g.VM_default_mappings = 0 -- disable defaults
  end,
  config = function()
    vim.g.VM_maps = {
      -- Word selection
      ["Find Under"]          = "<C-d>",       -- Ctrl+D
      ["Find Subword Under"] = "<C-d>",        -- Ctrl+D

      -- Add cursors vertically
      ["Add Cursor Down"]    = {"<C-M-j>", "<C-M-Down>"}, -- Ctrl+Alt+J or ↓
      ["Add Cursor Up"]      = {"<C-M-k>", "<C-M-Up>"},   -- Ctrl+Alt+K or ↑

      -- Visual selection to multiple cursors
      ["Visual Cursors"]     = "<C-M-å>",      -- Ctrl+Alt+N

      -- Select all like current
      ["Select All"]         = "<C-M-a>",      -- Ctrl+Alt+A
    }
  end
}


}
