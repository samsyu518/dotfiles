-- [[ Basic Keymaps ]]
--*map-table*
--          Mode  | Norm | Ins | Cmd | Vis | Sel | Opr | Term | Lang | ~
-- Command        +------+-----+-----+-----+-----+-----+------+------+ ~
-- [nore]map      | yes  |  -  |  -  | yes | yes | yes |  -   |  -   |
-- n[nore]map     | yes  |  -  |  -  |  -  |  -  |  -  |  -   |  -   |
-- [nore]map!     |  -   | yes | yes |  -  |  -  |  -  |  -   |  -   |
-- i[nore]map     |  -   | yes |  -  |  -  |  -  |  -  |  -   |  -   |
-- c[nore]map     |  -   |  -  | yes |  -  |  -  |  -  |  -   |  -   |
-- v[nore]map     |  -   |  -  |  -  | yes | yes |  -  |  -   |  -   |
-- x[nore]map     |  -   |  -  |  -  | yes |  -  |  -  |  -   |  -   |
-- s[nore]map     |  -   |  -  |  -  |  -  | yes |  -  |  -   |  -   |
-- o[nore]map     |  -   |  -  |  -  |  -  |  -  | yes |  -   |  -   |
-- t[nore]map     |  -   |  -  |  -  |  -  |  -  |  -  | yes  |  -   |
-- l[nore]map     |  -   | yes | yes |  -  |  -  |  -  |  -   | yes  |
--
local set = vim.keymap.set
-- Basic movement keybinds, these make navigating splits easy for me
set('n', '<M-j>', '<c-w><c-j>')
set('n', '<M-k>', '<c-w><c-k>')
set('n', '<M-l>', '<c-w><c-l>')
set('n', '<M-h>', '<c-w><c-h>')
-- quick move
set('v', 'J', ":m '>+1<CR>gv=gv")
set('v', 'K', ":m '<-2<CR>gv=gv")

set('n', 'J', 'mzJ`z')

-- make center
set('n', '<C-d>', '<C-d>zz')
set('n', '<C-u>', '<C-u>zz')
set('n', 'n', 'nzzzv')
set('n', 'N', 'Nzzzv')

-- greatest remap event_args
--[[ " Greatest remap EVER!!
 Let me explain, this remap while in visiual mode
 will delete what is currently highlighted and replace it
 with what is in the register BUT it will YANK (delete) it
 to a VOID register. Meaning I still have what I originally had
 when I pasted. I don't loose the previous thing I YANKED! ]]
set('x', 'p', [["_dP]])
-- yank to black hole
set({ 'n', 'v' }, 'c', [["_c]])
set({ 'n', 'v' }, 'd', [["_d]])
-- normal yank
set({ 'n', 'v' }, 'C', 'c')
set({ 'n', 'v' }, 'D', 'd')

-- quick file replace
set('n', '<leader>fs', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- set('v', '<leader>fs', [["zy:%s/\<<C-r>z\>/<C-r>z/gc<left><left><left>]])
--[[ 
for test replace vf\;<Space>fs
c:\program files\vim 
c:\program files\neovim 

escape(@z, ' \/') escapes the contents of register z .
<C-r>= is used to evaluate the expression inside escape(@z, ' \/').
<CR> is used to close the expression evaluation ]]
set('v', '<leader>fs', [["zy:%s/<C-r>=escape(@z, ' \/')<CR>/<C-r>=escape(@z, ' \/')<CR>/gc<left><left><left>]])

-- quick make file execute
set('n', '<leader>fx', '<cmd>!chmod +x %<CR>', { silent = true })
-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Remap down up for select complete
set('c', '<down>', function()
  if vim.fn.pumvisible() == 1 then
    return '<c-n>'
  end
  return '<down>'
end, { expr = true })

set('c', '<up>', function()
  if vim.fn.pumvisible() == 1 then
    return '<c-p>'
  end
  return '<up>'
end, { expr = true })

-- cmd list
set('n', '<leader>cS', '<cmd>.lua <cr>', { desc = 'run the current line lua' })
set('n', '<leader>cs', '<cmd>w<cr><cmd>source %<cr>', { desc = 'source current file' })
set('n', '<leader>cM', '<cmd>Mason<cr>', { desc = 'Mason' })
set('n', '<leader>cL', '<cmd>Lazy<cr>', { desc = 'Lazy' })
set('n', '<leader>cli', '<cmd>LspInfo<cr>', { desc = 'LspInfo' })
set('n', '<leader>cll', '<cmd>LspLog<cr>', { desc = 'LspLog' })
set('n', '<leader>ci', '<cmd>InspectTree<cr>', { desc = 'InspectTree' })
set('n', '<leader>cc', '<cmd>checkhealth<cr>', { desc = 'checkhealth' })
set('n', '<leader>cn', '<cmd>vnew<cr>', { desc = 'vnew' })
set('n', '<leader>cN', '<cmd>new<cr>', { desc = 'new' })
set('n', '<leader>cf', ':set filetype=', { desc = 'quick set filetype' })

-- Quit all
set('n', '<leader>qq', '<cmd>qa<cr>', { desc = 'Quit all' })

-- Diagnostic keymaps
set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
set('n', '<M-[>', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
set('n', '<M-]>', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
set('n', 'gl', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
set('n', 'gL', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- These mappings control the size of splits (height/width)
set('n', '<M-,>', '<c-w>5<')
set('n', '<M-.>', '<c-w>5>')
set('n', '<M-=>', '<C-W>2+')
set('n', '<M-->', '<C-W>2-')

-- buffer action
set('n', 'gn', vim.cmd.bn, { desc = 'buffer next' })
set('n', 'gp', vim.cmd.bp, { desc = 'buffer previous' })
set('n', '<M-n>', vim.cmd.bn, { desc = 'buffer next' })
set('n', '<M-p>', vim.cmd.bp, { desc = 'buffer previous' })
set('n', '<leader>bd', vim.cmd.bd, { desc = 'buffer delete' })
set('n', '<M-w>', vim.cmd.bd, { desc = 'buffer delete' })
set('n', '<leader>bn', vim.cmd.enew, { desc = 'buffer new' })
set('n', '<leader>bka', '<cmd>%bd|e<cr>', { desc = 'buffer kill all' })
