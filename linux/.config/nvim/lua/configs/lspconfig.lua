-- custom local vars
local on_attach = require("nvchad.configs.lspconfig").on_attach
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")

-- non custom
require("nvchad.configs.lspconfig").defaults()

local servers = { "html", "cssls" }
vim.lsp.enable(servers)
-- end of non custom

-- Configure ansiblels manually
lspconfig.ansiblels.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "yaml.ansible", "yaml" },
  settings = {
    ansible = {
      python = {
        interpreterPath = "python3", -- Or your venv/bin/python path
      },
    },
  },
}

