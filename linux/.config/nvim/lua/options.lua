require "nvchad.options"

-- Add yours here!
-- Filetypes
vim.cmd 'autocmd BufRead *.yaml,*.yml if expand("%:p") =~ "ansible" | setfiletype yaml.ansible | endif'

-- Copy on wsl
if vim.fn.has("wsl") == 1 then
  vim.g.clipboard = {
    name = 'WslClipboard',
    copy = {
      ['+'] = 'clip.exe',
      ['*'] = 'clip.exe',
    },
    paste = {
      ['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      ['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    },
    cache_enabled = 0,
  }
end

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*/playbooks/*.yml", "*/roles/**/*.yml" },
  callback = function()
    vim.bo.filetype = "yaml.ansible"
  end,
})

-- NOTE Highlight on yank - with Search > sets to yellow
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight yanked text",
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "Search",
      timeout = 200,
    })
  end,
})

-- Enable line number + relative numbers
vim.opt.number = true
vim.opt.relativenumber = true

local o = vim.o

-- Indenting
o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4

-- o.cursorlineopt ='both' -- to enable cursorline!
