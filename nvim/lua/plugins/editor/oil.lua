return {
  "stevearc/oil.nvim",
  event = "VeryLazy",
  config = function(_, opts)
    require("config.oil")
  end,
}
