-- lua/core/keymaps.lua

-- Basic keymaps not depending on plugins
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>q", ":qa<CR>", { desc = "Quit all" })

-- You can add more basic keymaps here if needed

