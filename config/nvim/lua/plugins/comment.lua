--commenting [comment.nvim]
vim.api.nvim_set_keymap("n", "<C-;", "gcc", {})
vim.api.nvim_set_keymap("i", "<C-;>", "<ESC>gcca", {})
vim.api.nvim_set_keymap("v", "<C-;>", "gc", {})

vim.api.nvim_set_keymap("n", "<C-\\>", "gbc", {}) --for multiline comment-box
vim.api.nvim_set_keymap("v", "<C-\\>", "gb", {}) -- in visual mode 
vim.api.nvim_set_keymap("n", "<leader>\\", "gcA", {}) -- comment to the last of the line

return {
    {
        "numToStr/Comment.nvim",
        event = { "BufEnter" },
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring",
            config = function()
                ---@diagnostic disable-next-line: missing-fields
                require("ts_context_commentstring").setup({
                    enable_autocmd = false,
                })
            end,
        },
        config = function()
            -- Comment configuration object _can_ take a partial and is merged in
            ---@diagnostic disable-next-line: missing-fields
            require("Comment").setup({
                pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
            })

            local ft = require("Comment.ft")
            ft.set("reason", { "//%s", "/*%s*/" })
        end,
    },
}
