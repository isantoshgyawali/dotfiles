return {
    'nvim-telescope/telescope.nvim',
     dependencies = { 'nvim-lua/plenary.nvim' },
     config = function()
	     require('telescope').setup{
	     -- Other Configurations
	     }
	end,

      defaults = {
         file_ignore_patterns = {
            "Android/Sdk/.*",
            "node_modules/*",
            "%.env",
            "yarn.lock",
            "package-lock.json",
            "lazy-lock.json",
            "init.sql",
            "target/.*",
            ".git/*",
        },
      },

     keys = {
	{ '<leader>ff', function() require('telescope.builtin').find_files({hidden=true}) end },
	{ '<leader>fg', function() require('telescope.builtin').live_grep() end },
	{ '<leader>ft', function() require('telescope.builtin').git_files() end },
     }
}
