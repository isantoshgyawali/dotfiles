return {
   "nvim-treesitter/nvim-treesitter",

   lazy = false,

   build = ":TSUpdate",

   config = function()
      local treesitter = require("nvim-treesitter")

      -- A list of parser names, or "all"
      treesitter.install({
         "vimdoc", "javascript", "typescript", "c", "lua", "go",
         "jsdoc", "bash",
         "markdown", "markdown_inline",
      })

      -- Install parsers synchronously (only applied to `ensure_installed`)
      -- sync_install = false,

      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don"t have `tree-sitter` CLI installed locally
      -- auto_install = true,

      vim.api.nvim_create_autocmd("FileType", {
         pattern = {
            "vim",
            "vimdoc",
            "javascript",
            "typescript",
            "c",
            "lua",
            "go",
            "jsdoc",
            "bash",
            "markdown",
         },

         callback = function()
            -- `false` will disable the whole extension
            vim.treesitter.start()

            -- Treesitter indentation
            vim.bo.indentexpr =
               "v:lua.require'nvim-treesitter'.indentexpr()"
         end,
      })
   end
}
