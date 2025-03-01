require('neodev').setup {
  -- library = {
  --   plugins = { "nvim-dap-ui" },
  --   types = true,
  -- },
}

-- local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()
local lsp_capabilities = vim.tbl_deep_extend('force', vim.lsp.protocol.make_client_capabilities(), require('cmp_nvim_lsp').default_capabilities())

require('mason').setup()

local servers = require 'config.lsp.servers'

local servers_to_install = vim.tbl_filter(function(key)
  local t = servers[key]
  if type(t) == 'table' then
    return not t.manual_install
  else
    return t
  end
end, vim.tbl_keys(servers))

local ensure_installed = {
  'stylua',
  'tailwindcss-language-server',
}
vim.list_extend(ensure_installed, servers_to_install)

-- local default_setup = function(server)
--   require('lspconfig')[server].setup {
--     capabilities = lsp_capabilities,
--   }
-- end
-- require('mason-lspconfig').setup {
--   handlers = {
--     default_setup,
--   },
-- }
require('mason-tool-installer').setup { ensure_installed = ensure_installed }

local lspconfig = require 'lspconfig'

for name, config in pairs(servers) do
  if config == true then
    config = {}
  end
  config = vim.tbl_deep_extend('force', {}, {
    capabilities = lsp_capabilities,
  }, config)

  lspconfig[name].setup(config)
end

local disable_semantic_tokens = {
  lua = true,
}

vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local client = assert(vim.lsp.get_client_by_id(event.data.client_id), 'must have valid client')

    -- these will be buffer-local keybindings
    -- because they only work if you have an active language server

    local set = function(mode, keys, func, desc)
      if desc then
        desc = 'LSP: ' .. desc
      end

      vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = desc })
    end
    local nmap = function(keys, func, desc)
      set('n', keys, func, desc)
    end

    nmap('<leader>c<F2>', vim.lsp.buf.rename, '[R]e name')
    set({ 'n', 'x' }, '<leader>c<F3>', function()
      vim.lsp.buf.format { async = true }
    end, 'Format buffer')
    nmap('<leader>c<F4>', vim.lsp.buf.code_action, 'code [A]ction')

    nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
    nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
    nmap('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
    nmap('go', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
    nmap('gs', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('gw', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

    -- See `:help K` for why this keymap
    -- had use another hover plugins
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('gwa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('gwr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('gwl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    local filetype = vim.bo[event.buf].filetype

    if disable_semantic_tokens[filetype] then
      client.server_capabilities.semantictokensprovider = nil
    end
  end,
})

-- Autoformatting Setup
require('conform').setup {
  formatters_by_ft = {
    lua = { 'stylua' },
    ex = { 'mix' },
    exs = { 'mix' },
  },
}

vim.api.nvim_create_autocmd('BufWritePre', {
  callback = function(args)
    require('conform').format {
      bufnr = args.buf,
      lsp_fallback = true,
      quiet = true,
    }
  end,
})
