require "nvchad.mappings"

-- add yours here

-- Remove keymaps
vim.keymap.del("n", "<leader>e")

local map = vim.keymap.set

-- custom nvim open
map("n", "\\", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle NvimTree" })

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Exit terminal mode and go to previous window
map('t', '<M-æ>', [[<C-\><C-n><C-w>p]], { noremap = true, silent = true })

-- In normal mode, jump to the terminal window
map('n', '<M-æ>', '<C-w>p:startinsert<CR>', { noremap = true, silent = true })

-- LazyGit
map('n', '<leader>gg', '<cmd>:LazyGit<CR>', { noremap = true, silent = true })

-- Ansible Vault keybindings

-- Encrypt current file
map("n", "<leader>ve", function()
  local file = vim.fn.expand("%:p")
  if file == "" then
    print("No file to encrypt")
    return
  end

  local cmd = "ansible-vault encrypt " .. file
  print("Encrypting with: " .. cmd)

  vim.fn.jobstart(cmd, {
    on_exit = function(_, code)
      if code == 0 then
        print("Ansible Vault: Encryption successful!")
      else
        print("Ansible Vault: Encryption failed.")
      end
    end,
  })
end, { desc = "Encrypt file with Ansible Vault" })

-- Decrypt current file
map("n", "<leader>vd", function()
  local file = vim.fn.expand("%:p")
  vim.fn.jobstart("ansible-vault decrypt " .. file)
end, { desc = "Decrypt file with Ansible Vault" })

-- Vault edit
map("n", "<leader>vv", function()
  local file = vim.fn.expand("%:p")
  vim.cmd("e! | silent !" .. "ansible-vault edit " .. file)
end, { desc = "Ansible Vault edit" })

