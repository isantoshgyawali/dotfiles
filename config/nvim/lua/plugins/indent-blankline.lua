return {
   "lukas-reineke/indent-blankline.nvim",
   main = "ibl",
   events = "LazyFile",
   config = function ()
      require("ibl").setup()
   end,
   opts = {
      indent = {
         char = "│",
         tab_char = "│",
         highlight = { "Function", "Label" }
      }
   }
}
