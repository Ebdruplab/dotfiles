require "nvchad.options"

-- add yours here!
-- filetypes
vim.cmd 'autocmd BufRead *.yaml,*.yml if expand("%:p") =~ "ansible" | setfiletype yaml.ansible | endif'

-- copy on wsl
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

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    local ok, hl = pcall(require, "vim.highlight")
    if ok and hl.on_yank then
      hl.on_yank({ higroup = "IncSearch", timeout = 150 })
    end
  end,
})

-- enable line number + relative numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
