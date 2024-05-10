--directory Navigation
vim.keymap.set("n", "<C-h>", ":NvimTreeFocus<CR>", {noremap = true})
vim.keymap.set("n", "<C-l>", ":NvimTreeToggle<CR>",{noremap = true})

return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("nvim-tree").setup {}
    end,
}
