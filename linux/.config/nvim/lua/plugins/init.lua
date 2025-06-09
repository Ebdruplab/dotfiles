return {
  {
    "stevearc/conform.nvim",
    event = 'BufWritePre',
    opts = require "configs.conform",
    lazy = false,
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
   			"vim", "lua", "vimdoc", "xml", "ssh_config", "json",
        "html", "css", "comment", "powershell", "bash",
<<<<<<< HEAD
=======
        "python", "markdown", "toml", "luadoc",
>>>>>>> 8d3c6a5fdd5b0fc8794fdf7fffc75caf5c2be4c4
  	},
   	},
  },

  {
    "goolord/alpha-nvim",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },

    config = function()
        local alpha = require("alpha")
        local dashboard = require("alpha.themes.startify")

        dashboard.section.header.val = {
            [[                                                                       ]],
            [[                                                                       ]],
            [[                                                                       ]],
            [[                                                                       ]],
            [[                                                                     ]],
            [[       ████ ██████           █████      ██                     ]],
            [[      ███████████             █████                             ]],
            [[      █████████ ███████████████████ ███   ███████████   ]],
            [[     █████████  ███    █████████████ █████ ██████████████   ]],
            [[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
            [[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
            [[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
            [[                                                                       ]],
            [[                                                                       ]],
            [[                                                                       ]],
        }
        -- Set the section
        dashboard.section.header.opts.hl = "AlphaHeader"
        
        -- Set the color
        vim.api.nvim_set_hl(0, "AlphaHeader", { fg = "#CBA6F7", bg = "NONE", bold = true })
        alpha.setup(dashboard.opts)
    end,
  },
-- custom
-- nvim v0.8.0
  {
    "kdheepak/lazygit.nvim",
    lazy = false,
    cmd = {
        "LazyGit",
        "LazyGitConfig",
        "LazyGitCurrentFile",
        "LazyGitFilter",
        "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
        "nvim-telescope/telescope.nvim",
        "nvim-lua/plenary.nvim",
    },
    config = function()
        require("telescope").load_extension("lazygit")
        --require "configs.lspconfig"
    end,
  },
  {
    "folke/todo-comments.nvim",
    Lazy = false,
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {}
  },
  {
    "nvim-tree/nvim-tree.lua",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- require("nvchad.configs.nvimtree").defaults()
      require("configs.nvimtree").setup()
    end,
  }


}
