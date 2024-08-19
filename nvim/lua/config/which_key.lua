-- document existing key chains
require('which-key').add {
  { '<leader>b', group = '[B]uffer' },
  { '<leader>c', group = '[C]md' },
  { '<leader>d', group = '[D]ebug/DB' },
  { '<leader>g', group = '[G]it' },
  { '<leader>l', group = '[L]LSP' },
  { '<leader>lw', group = 'LSP [W]orkspace' },
  { '<leader>r', group = '[R]ename' },
  { '<leader>t', group = '[T]est' },
  { '<leader>f', group = '[F]File search' },
  { '<leader>q', group = '[Q]uit' },
  { '<leader>w', group = '[W]orkspace' },
  { '<leader>s', group = '[S]pectre' },
  { '<leader><F5>', group = '[F5]undotree' },
}
