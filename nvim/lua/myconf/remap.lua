-- [[ Basic Keymaps ]]

-- quick move
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

vim.keymap.set('n', 'J', 'mzJ`z')

-- make center
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')

-- greatest remap event_args
--[[ " Greatest remap EVER!!
 Let me explain, this remap while in visiual mode
 will delete what is currently highlighted and replace it
 with what is in the register BUT it will YANK (delete) it
 to a VOID register. Meaning I still have what I originally had
 when I pasted. I don't loose the previous thing I YANKED! ]]
vim.keymap.set('x', 'p', [["_dP]])
vim.keymap.set({ 'n', 'v' }, 'c', [["_c]])

-- quick file replace
vim.keymap.set('n', '<leader>fs', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- quick make file execute
vim.keymap.set('n', '<leader>fx', '<cmd>!chmod +x %<CR>', { silent = true })
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Remap down up for select complete
vim.keymap.set('c', '<down>', function()
  if vim.fn.pumvisible() == 1 then
    return '<c-n>'
  end
  return '<down>'
end, { expr = true })

vim.keymap.set('c', '<up>', function()
  if vim.fn.pumvisible() == 1 then
    return '<c-p>'
  end
  return '<up>'
end, { expr = true })

-- Quit all
vim.keymap.set('n', '<leader>qq', '<cmd>qa<cr>', { desc = 'Quit all' })
-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>le', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>lq', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

vim.keymap.set('n', '<leader>bn', vim.cmd.bn, { desc = 'buffer next' })
vim.keymap.set('n', 'gn', vim.cmd.bn, { desc = 'buffer next' })
vim.keymap.set('n', 'gp', vim.cmd.bp, { desc = 'buffer previous' })
vim.keymap.set('n', '<leader>bd', vim.cmd.bd, { desc = 'buffer delete' })
vim.keymap.set('n', '<leader>bn', vim.cmd.enew, { desc = 'buffer new' })
vim.keymap.set('n', '<leader>bka', '<cmd>%bd|e<cr>', { desc = 'buffer kill all' })

-- document existing key chains
require('which-key').register {
  ['<leader>b'] = { name = '[B]uffer', _ = 'which_key_ignore' },
  ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
  ['<leader>d'] = { name = '[D]ebug', _ = 'which_key_ignore' },
  ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
  -- ['<leader>h'] = { name = 'More git', _ = 'which_key_ignore' },
  ['<leader>l'] = { name = '[L]LSP', _ = 'which_key_ignore' },
  ['<leader>lw'] = { name = 'LSP [W]orkspace', _ = 'which_key_ignore' },
  -- ['<leader>o'] = { name = 'Open', _ = 'which_key_ignore' },
  ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
  ['<leader>l'] = { name = '[L]SP', _ = 'which_key_ignore' },
  ['<leader>s'] = { name = '[S]pectre', _ = 'which_key_ignore' },
  ['<leader>t'] = { name = '[T]est', _ = 'which_key_ignore' },
  ['<leader>f'] = { name = '[F]File search', _ = 'which_key_ignore' },
  ['<leader>q'] = { name = '[Q]uit', _ = 'which_key_ignore' },
  ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
  ['<leader>s'] = { name = '[S]pectre', _ = 'which_key_ignore' },
  ['<leader><F5>'] = { name = '[F5]undotree', _ = 'which_key_ignore' },
}
