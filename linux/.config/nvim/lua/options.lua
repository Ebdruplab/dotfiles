require "nvchad.options"

-- Ansible filetype detection
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = {
    "*/playbooks/*.yml",
    "*/playbooks/*.yaml",
    "*/roles/**/tasks/*.yml",
    "*/roles/**/handlers/*.yml",
    "*/roles/**/meta/*.yml",
    "*/roles/**/defaults/*.yml",
    "*/roles/**/vars/*.yml",
  },
  callback = function()
    vim.bo.filetype = "yaml.ansible"
  end,
})

vim.api.nvim_create_autocmd("BufRead", {
  pattern = { "*.yml", "*.yaml" },
  callback = function()
    local path = vim.fn.expand("%:p")
    if path:match("ansible") and vim.bo.filetype ~= "yaml.ansible" then
      vim.bo.filetype = "yaml.ansible"
    end
  end,
})

-- Dockerfile detection
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = {
    "Dockerfile",
    "dockerfile",
    "*.Dockerfile",
    "*.dockerfile",
    "*/docker/*.yml",
    "*/docker-compose.yml",
    "*/docker-compose.yaml",
  },
  callback = function()
    vim.bo.filetype = "dockerfile"
  end,
})

-- Helm chart detection
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = {
    "*/charts/*/templates/*.yaml",
    "*/charts/*/templates/*.yml",
    "*/charts/*/values.yaml",
    "*/charts/*/Chart.yaml",
  },
  callback = function()
    vim.bo.filetype = "yaml"
    vim.b.helm_chart = true
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*/charts/*/templates/*.tpl" },
  callback = function()
    vim.bo.filetype = "helm"
    vim.b.helm_chart = true
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight yanked text",
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
  callback = function()
    vim.highlight.on_yank({
      higroup = "Search",
      timeout = 200,
    })
  end,
})

-- WSL clipboard integration
if vim.fn.has("wsl") == 1 then
  vim.g.clipboard = {
    name = "WslClipboard",
    copy = {
      ["+"] = "clip.exe",
      ["*"] = "clip.exe",
    },
    paste = {
      ["+"] = [[powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))]],
      ["*"] = [[powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))]],
    },
    cache_enabled = 0,
  }
end

-- UI: line numbering
vim.opt.number = true
vim.opt.relativenumber = true

-- Indentation
local o = vim.o
o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4
-- o.cursorlineopt = "both" -- Uncomment if you want full cursorline

