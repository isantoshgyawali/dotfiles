return {
  "ThePrimeagen/harpoon",
  config = function ()
    require("harpoon").setup()
    vim.keymap.set("n", "<leader>a", require("harpoon.mark").add_file)
    vim.keymap.set("n", "<leader>e", require("harpoon.ui").toggle_quick_menu)

    vim.keymap.set("n", "<leader>1", function() require("harpoon.ui").nav_file(1) end)
    vim.keymap.set("n", "<leader>2", function() require("harpoon.ui").nav_file(2) end)
    vim.keymap.set("n", "<leader>3", function() require("harpoon.ui").nav_file(3) end)
    vim.keymap.set("n", "<leader>4", function() require("harpoon.ui").nav_file(4) end)
  end,
}
