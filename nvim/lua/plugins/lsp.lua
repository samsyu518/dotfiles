return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Additional lua configuration, makes nvim stuff amazing!
      "folke/neodev.nvim",
      -- Automatically install LSPs to stdpath for neovim
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { "j-hui/fidget.nvim", opts = {} },

      -- Autoformatting
      "stevearc/conform.nvim",

      -- Schema information for .json
      "b0o/SchemaStore.nvim",
    },
    config = function()
      require("config.lsp")
    end,
  },
}
