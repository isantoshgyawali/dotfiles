return {
    {
        "hrsh7th/nvim-cmp",
        event = { "BufReadPost", "BufNewFile" },
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            {
                "L3MON4D3/LuaSnip",
                version = "v2.2",
                build = "make install_jsregexp",
            },
            "saadparwaiz1/cmp_luasnip",
            "onsails/lspkind.nvim",
            "windwp/nvim-ts-autotag",
            "windwp/nvim-autopairs",
        },
        config = function()
            require("nvim-autopairs").setup()
        end,
    },
}
