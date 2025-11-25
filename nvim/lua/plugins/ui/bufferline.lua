return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function(_, opts)
    require("bufferline").setup(opts)
  end,
  opts = {
    options = {
      diagnostics = "nvim_lsp",
      always_show_bufferline = true,
      diagnostics_indicator = function(count, level)
        local icon = level:match("error") and " " or " "
        return " " .. icon .. count
      end,
    },
  },
}
