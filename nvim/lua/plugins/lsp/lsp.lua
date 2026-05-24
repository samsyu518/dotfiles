return {
  -- Main LSP Configuration
  "neovim/nvim-lspconfig",
  -- lazy = true,
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for Neovim
    -- Mason must be loaded before its dependents so we need to set it up here.
    -- NOTE: `opts = {}` is the same as calling `require('mason').setup({})`
    { "mason-org/mason.nvim", opts = {} },
    {
      "mason-org/mason-lspconfig.nvim",
      opts = {
        -- mason-lspconfig use to translate between `nvim-lspconfig` server names and `mason.nvim` package names  (e.g. `lua_ls <-> lua-language-server`)
        ensure_installed = {}, -- explicitly set to an empty table (Kickstart populates installs via mason-tool-installer)
        automatic_installation = false,
        automatic_enable = false,
      },
    },
    "WhoIsSethDaniel/mason-tool-installer.nvim",

    -- Useful status updates for LSP.
    { "j-hui/fidget.nvim", opts = {} },

    -- Allows extra capabilities provided by blink.cmp
    "saghen/blink.cmp",
  },
  config = function()
    require("config.lsp")
  end,
}
