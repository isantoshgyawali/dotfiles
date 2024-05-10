return {
  "navarasu/onedark.nvim",
  priority = 999,
  lazy = false,
  config = function()
    require('onedark').setup {
      style = 'darker',
      transparent = true,
      -- Other Configurations
      code_style = {
        comments = 'italic',
        keywords = 'none',
        functions = 'none',
        strings = 'none',
        variables = 'none',
      },
    }
  end
}
