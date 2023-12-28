vim.g.mapleader = " "

-- Explorer
vim.keymap.set("n", "<leader>ex", vim.cmd.Ex)

-- PackerSync
vim.keymap.set("n", "<leader>ps", vim.cmd.PackerSync)

-- Mappings / vertical_motions
vim.keymap.set("n", "<C-d>", "<C-d>zz") -- half-page-down with cursor-center
vim.keymap.set("n", "<C-u>", "<C-u>zz") -- half-page-up with cursor-center

vim.keymap.set("n", "<C-f>", "<C-f>zz") -- full-page-down with cursor-center
vim.keymap.set("n", "<C-b>", "<C-b>zz") -- full-page-up with cursor-center

-- line Numbers 
vim.o.number = true
vim.o.relativenumber = true




