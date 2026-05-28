return {
  "MagicDuck/grug-far.nvim",
  opts = {
    headerMaxWidth = 80,
  },
  keys = {
    {
      "<leader>sr",
      function()
        require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
      end,
      mode = { "n" },
      desc = "Search and Replace in Project",
    },
    {
      "<leader>sr",
      function()
        require("grug-far").with_visual_selection({ prefills = { paths = vim.fn.expand("%") } })
      end,
      mode = { "v" },
      desc = "Search and Replace (selection)",
    },
  },
}
