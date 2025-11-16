-- custom local vars
local on_attach = require("nvchad.configs.lspconfig").on_attach
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require("lspconfig")

-- non custom
require("nvchad.configs.lspconfig").defaults()

local servers = {
  "html",
  "cssls",
  'bash-language-server',
  'shellcheck',
  'lua-language-server',
  'stylua',
  'vim-language-server',
  'json-to-struct',
  'ansible-language-server',
  'ansible-lint',
  'terraformls',
  'jq'
}

vim.lsp.enable(servers)
-- end of non custom

-- Configure ansiblels manually
lspconfig.ansiblels.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "yaml.ansible" },
  settings = {
    ansible = {
      python = {
        interpreterPath = "python3",
      },
      validation = {
        enabled = true,
      },
      completion = {
        provideRedirectModules = true,
        provideModuleOptionAliases = true,
      },
      diagnostics = {
        enabled = true,
      },
    },
  },
}

-- Make docker-compose templates use the docker-compose YAML filetype
vim.filetype.add({
  pattern = {
    -- matches any path ending with docker-compose.homelab.yml.j2
    [".*/docker%-compose%.homelab%.yml%.j2"] = "yaml.docker-compose",

    -- optional: match any docker-compose*.yml.j2
    [".*/docker%-compose.*%.yml%.j2"] = "yaml.docker-compose",
    [".*/docker%-compose.*%.yaml%.j2"] = "yaml.docker-compose",
  },
})
