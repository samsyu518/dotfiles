-- document existing key chains
require('which-key').register {
  ['<leader>b'] = { name = '[B]uffer', _ = 'which_key_ignore' },
  ['<leader>c'] = { name = '[C]md', _ = 'which_key_ignore' },
  ['<leader>d'] = { name = '[D]ebug', _ = 'which_key_ignore' },
  ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
  -- ['<leader>h'] = { name = 'More git', _ = 'which_key_ignore' },
  ['<leader>l'] = { name = '[L]LSP', _ = 'which_key_ignore' },
  ['<leader>lw'] = { name = 'LSP [W]orkspace', _ = 'which_key_ignore' },
  -- ['<leader>o'] = { name = 'Open', _ = 'which_key_ignore' },
  ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
  ['<leader>t'] = { name = '[T]est', _ = 'which_key_ignore' },
  ['<leader>f'] = { name = '[F]File search', _ = 'which_key_ignore' },
  ['<leader>q'] = { name = '[Q]uit', _ = 'which_key_ignore' },
  ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
  ['<leader>s'] = { name = '[S]pectre', _ = 'which_key_ignore' },
  ['<leader><F5>'] = { name = '[F5]undotree', _ = 'which_key_ignore' },
}
