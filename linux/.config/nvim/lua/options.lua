require "nvchad.options"

-- add yours here!
-- filetypes
vim.cmd 'autocmd BufRead *.yaml,*.yml if expand("%:p") =~ "ansible" | setfiletype yaml.ansible | endif'
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


vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*/playbooks/*.yml", "*/roles/**/*.yml" },
  callback = function()
    vim.bo.filetype = "yaml.ansible"
  end,
})

-- local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
