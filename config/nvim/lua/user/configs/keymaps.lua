--leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.keymap.set("n", "<leader>l", ":LspRestart<CR>")

-- copy file content
vim.keymap.set("n", "<leader><leader>", ":%y+<CR>")
vim.keymap.set("n", "<C-a>", "ggVG")

vim.keymap.set("n", "<leader>=", function()
    -- checks if there are  any of lsp's in current buffer ie. {buffnr = 0}
    -- "#" calculates the length of array and if that is more than 0
    -- then has_lsp = true else false
    local has_lsp = #vim.lsp.get_active_clients({ bufnr = 0 }) > 0

    -- If LSP is available, use LSP formatting
    if has_lsp then
        print("Using LSP formatting")
        vim.lsp.buf.format()
    else
        -- If LSP is not available, fall back to indentation
        local line_count = vim.api.nvim_buf_line_count(0)
        vim.cmd("silent normal! gg=G``")
        print("Falling back to indentation - " .. line_count .. " lines indented")
    end
end, { desc = "Format buffer" })

-- buffer movement
vim.keymap.set("n", "<Tab>", ":bnext<CR>", { noremap = true })
vim.keymap.set("n", "<S-Tab>", ":bprev<CR>", { noremap = true })

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
vim.keymap.set({ "n", "v" }, "<leader>y", "\"+y", { noremap = true })

--chmod +x execution right from the vim
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>")

-- golang err
vim.keymap.set("n", "<leader>r", "oif err != nil {\nreturn nil, \n}<Esc>2=kj$i<TAB>")

-- react / react-native
vim.keymap.set("n", "<leader>js", "oconsole.log(JSON.stringify( , null, 2))<Esc>F(la")
vim.keymap.set("n", "<leader>us", "ouseEffect(() => {\n}, [])<Esc>=kj0f]i")
vim.keymap.set("n", "<leader>nv",
    "oconst navigation = useNavigation() \n useEffect(() => {\n navigation.setOptions({\n})\n}, [navigation])<Esc>3=kjo")
