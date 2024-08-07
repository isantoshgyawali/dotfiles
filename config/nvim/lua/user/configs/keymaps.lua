--leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- copy file content
vim.keymap.set("n", "<leader><leader>", ":%y+<CR>")

-- file indentation
vim.keymap.set({"n", "v"}, "<leader>=", "gg=G``" )

--ThePrimeagen/References:
--move selection
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

--up/down with cursor center
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

--search terms in the middle
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

--pasting without loosing from the current register
vim.keymap.set("x", "<leader>p", "\"_dp")

--yanking to sys clipboard
vim.keymap.set({"n", "v"}, "<leader>y", "\"+y", {noremap = true})

--chmod +x execution right from the vim
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>")

-- golang err
vim.keymap.set("n", "<leader>r", "iif err != nil {\n\n}<Esc>2=kji<TAB>")
