--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================


  And then you can explore or search through `:help lua-guide`
  - https://neovim.io/doc/user/lua-guide.html


--]]
-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- fix cwd to open file path
if vim.fn.isdirectory(vim.v.argv[3]) == 1 then
  vim.api.nvim_set_current_dir(vim.v.argv[3])
end

require 'myconf'

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
