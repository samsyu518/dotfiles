-- [[ Setting options ]]
-- See `:help vim.opt`

vim.opt.guicursor = ''

-- Make line numbers default
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

-- Enable mouse mode
vim.opt.mouse = 'a'

vim.opt.swapfile = false
vim.opt.backup = false
-- Save undo history
vim.opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.wildmode = 'longest:full,full' -- Command-line completion mode
vim.opt.fillchars = {
  foldopen = '',
  foldclose = '',
  -- fold = "⸱",
  fold = ' ',
  foldsep = ' ',
  diff = '╱',
  eob = ' ',
}

-- The data to be written here can be quite long.
-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- vim.g.clipboard = {
--   name = 'OSC 52',
--   copy = {
--     ['+'] = require('vim.ui.clipboard.osc52').copy 'c',
--     ['*'] = require('vim.ui.clipboard.osc52').copy 'c',
--   },
--   paste = {
--     ['+'] = require('vim.ui.clipboard.osc52').paste '+',
--     ['*'] = require('vim.ui.clipboard.osc52').paste '*',
--   },
-- }

-- local function copy(lines, _)
--   require('osc52').copy(table.concat(lines, '\n'))
-- end
--
-- if os.getenv 'SSH_CLIENT' then
--   vim.g.clipboard = {
--     name = 'LemonadeClipboard',
--     copy = { ['*'] = copy, ['+'] = copy },
--     paste = {
--       ['+'] = { 'lemonade', 'paste' },
--       ['*'] = { 'lemonade', 'paste' },
--     },
--     cache_enabled = true,
--   }
-- elseif vim.loop.os_uname().release:match 'WSL' then
--   vim.g.clipboard = {
--     name = 'WslClipboard',
--     copy = { ['*'] = copy, ['+'] = copy },
--     paste = {
--       ['+'] = { 'nvim_paste' },
--       ['*'] = { 'nvim_paste' },
--     },
--     cache_enabled = true,
--   }
-- end
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Set highlight on search
vim.opt.hlsearch = true
vim.opt.incsearch = true
-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

-- Set completeopt to have a better completion experience
-- setup in lsp.lua
-- vim.opt.completeopt = 'menu,menuone,noinsert'

-- NOTE: You should make sure your terminal supports this
vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.colorcolumn = '80'

vim.g.python3_host_prog = '~/.venv/bin/python'
-- vim.opt.foldmethod = 'expr'
-- vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

vim.cmd.colorscheme 'catppuccin'
-- vim.cmd.colorscheme 'onedark'
