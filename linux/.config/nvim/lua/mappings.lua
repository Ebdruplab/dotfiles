require "nvchad.mappings"

-- add yours here

-- Remove keymaps
-- Remove default nvchad
vim.keymap.del("n", "<leader>e")
local map = vim.keymap.set
-- custom nvim open
map("n", "\\", "<cmd>NvimTreeFocus<CR>", { desc = "Toggle NvimTree" })

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
