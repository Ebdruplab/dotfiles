vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "
vim.g.background = "light"

-- options
-- fix clipboard support
vim.opt.clipboard = "unnamedplus"

if vim.fn.has('wsl') == 1 then
    vim.api.nvim_create_autocmd('TextYankPost', {
        group = vim.api.nvim_create_augroup('Yank', {
            clear = true
        }),
        callback = function()
            vim.fn.system('/mnt/c/WINDOWS/system32/clip.exe', vim.fn.getreg('"'))
        end
    })
end

-- option for swapfile
vim.opt.swapfile = false

-- Navigate vim panes better
vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

vim.keymap.set("n", "<leader>h", ":nohlsearch<CR>")
vim.wo.number = true
vim.wo.relativenumber = true

-- filetypes
vim.cmd('autocmd BufRead *.yaml,*.yml if expand("%:p") =~ "ansible" | setfiletype yaml.ansible | endif')
