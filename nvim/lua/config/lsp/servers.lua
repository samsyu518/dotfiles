return {
  bashls = true,
  lua_ls = true,
  rust_analyzer = true,
  svelte = true,
  cssls = true,

  ts_ls = true,

  jsonls = {
    settings = {
      json = {
        schemas = require('schemastore').json.schemas(),
        validate = { enable = true },
      },
    },
  },

  yamlls = {
    settings = {
      yaml = {
        schemaStore = {
          enable = false,
          url = '',
        },
        schemas = require('schemastore').yaml.schemas(),
      },
    },
  },

  -- lexical = {
  --   cmd = { vim.fn.expand '$HOME/.local/share/nvim/mason/bin/lexical' },
  --   root_dir = require('lspconfig.util').root_pattern { 'mix.exs' },
  -- },
  -- nextls = {
  --   cmd = { vim.fn.expand '$HOME/.local/share/nvim/mason/bin/nextls', '--stdio' },
  -- },
  elixirls = {
    cmd = { vim.fn.expand '$HOME/.local/share/nvim/mason/bin/elixir-ls' },
  },

  pyright = {},
}
