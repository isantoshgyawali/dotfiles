-- directory Navigation
vim.keymap.set("n", "<C-h>", ":NvimTreeFocus<CR>", { noremap = true })
vim.keymap.set("n", "<C-l>", ":NvimTreeToggle<CR>", { noremap = true })

return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("nvim-tree").setup({
            actions = {
                open_file = {
                    quit_on_open = true,
                },
            },

            diagnostics = {
                enable = true,
                show_on_dirs = true,
                show_on_open_dirs = true,

                icons = {
                    error = "",
                    warning = "",
                    info = "",
                    hint = "",
                },
            },

            renderer = {
                icons = {
                    show = {
                        diagnostics = true,
                    },
                },
            },
        })
    end,
}
