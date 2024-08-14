vim.keymap.set("n", "<leader>z", ":ZenMode<CR>", {noremap=true} )
return {
    "folke/zen-mode.nvim",
    opts = {
        {
            window = {
                width = 0.80, -- width of the Zen window
                height = 0.9, -- height of the Zen window
            },
        }
    }
}
