require "nvchad.mappings"

-- add yours here

-- Remove keymaps
-- Remove default nvchad
vim.keymap.del("n", "<leader>e")
local map = vim.keymap.set
-- custom nvim open
map("n", "\\", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Exit terminal mode and go to previous window
vim.keymap.set('t', '<M-æ>', [[<C-\><C-n><C-w>p]], { noremap = true, silent = true })

-- In normal mode, jump to the terminal window
vim.keymap.set('n', '<M-æ>', '<C-w>p:startinsert<CR>', { noremap = true, silent = true })

-- setup mapping to call :LazyGit
vim.keymap.set('n', '<leader>gg', '<cmd>:LazyGit<CR>', { noremap = true, silent = true })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
