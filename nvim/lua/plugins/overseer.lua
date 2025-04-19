return {
  "stevearc/overseer.nvim",

  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, "overseer")
    end,
  },
}
