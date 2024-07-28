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
        highlights = {
            CursorLineNr = { fg = '#00daff', bold = true }, -- Use the defined red color
            LineNr = { fg = '#5C6370', bold = true }, -- Use the defined grey color
        }
    }
  end
}
