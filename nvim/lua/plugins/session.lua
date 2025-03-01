return {
  {
    'mbbill/undotree',
    keys = {
      { '<leader><F5>', vim.cmd.UndotreeToggle, desc = 'undotree' },
    },
  },
  {
    'okuuva/auto-save.nvim',
    opts = {
      enabled = true, -- start auto-save when the plugin is loaded (i.e. when your package manager loads it)
      -- function that takes the buffer handle and determines whether to save the current buffer or not
      -- return true: if buffer is ok to be saved
      -- return false: if it's not ok to be saved
      -- if set to `nil` then no specific condition is applied
      condition = function(buf)
        local fn = vim.fn
        local utils = require 'auto-save.utils.data'

        -- don't save for `sql` file types
        if utils.not_in(fn.getbufvar(buf, '&filetype'), { 'sql', 'mysql', 'dbui', 'dbout', 'plsql' }) then
          return true
        end
        return false
      end,
      debounce_delay = 2000, -- delay after which a pending save is executed
      -- log debug messages to 'auto-save.log' file in neovim cache directory, set to `true` to enable
      debug = false,
    },
    config = function(_, opts)
      require('auto-save').setup(opts)
      vim.api.nvim_set_keymap('n', '<leader>fa', ':ASToggle<CR>', {})
      vim.api.nvim_create_autocmd('User', {
        pattern = 'AutoSaveWritePost',
        group = group,
        callback = function(opts)
          if opts.data.saved_buffer ~= nil then
            local filename = vim.api.nvim_buf_get_name(opts.data.saved_buffer)
            print('AutoSave: saved ' .. filename .. ' at ' .. vim.fn.strftime '%H:%M:%S')
          end
        end,
      })
    end,
  },
  {
    'folke/persistence.nvim',
    event = 'BufReadPre', -- this will only start session saving when an actual file was opened
    opts = {
      -- default
      dir = vim.fn.expand(vim.fn.stdpath 'state' .. '/sessions/'), -- directory where session files are saved
      options = { 'buffers', 'curdir', 'tabpages', 'winsize' }, -- sessionoptions used for saving
      pre_save = nil, -- a function to call before saving the session
      save_empty = false, -- don't save if there are no open file buffers
    },
    keys = {
      {
        '<leader>qs',
        function()
          require('persistence').load()
        end,
        desc = 'Restore Session',
      },
      {
        '<leader>ql',
        function()
          require('persistence').load { last = true }
        end,
        desc = 'Restore Last Session',
      },
    },
    init = function()
      require('persistence').load()
    end,
  },
}
