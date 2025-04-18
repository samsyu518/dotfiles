return {
  {
    "hrsh7th/nvim-cmp",
    lazy = false,
    priority = 100,
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
      "saadparwaiz1/cmp_luasnip",

      -- Adds LSP completion capabilities
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      -- Adds a number of user-friendly snippets
      "rafamadriz/friendly-snippets",
      -- for lsp menu icon
      "onsails/lspkind.nvim",
    },
    config = function()
      require("config.completion")
    end,
  },
}
