-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  checker = {
    -- automatically check for plugin updates
    enabled = false,
    concurrency = nil, ---@type number? set to 1 to check for updates very slowly
    notify = true, -- get a notification when new updates are found
    frequency = 3600, -- check for updates every hour
    check_pinned = false, -- check for pinned packages that can't be updated
  },
  spec = {
    -- NOTE: First, some plugins that don't require any configuration

    -- Git related plugins
    'tpope/vim-fugitive',
    'tpope/vim-rhubarb',

    -- Detect tabstop and shiftwidth automatically
    'tpope/vim-sleuth',

    -- Useful plugin to show you pending keybinds.
    { 'folke/which-key.nvim', opts = {}, event = 'VeryLazy' },
    {
      -- Adds git related signs to the gutter, as well as utilities for managing changes
      'lewis6991/gitsigns.nvim',
      event = 'VeryLazy',
      opts = {
        -- See `:help gitsigns.txt`
        signs = {
          add = { text = '+' },
          change = { text = '~' },
          delete = { text = '_' },
          topdelete = { text = '‾' },
          changedelete = { text = '~' },
        },
        current_line_blame = true,
        on_attach = function(bufnr)
          vim.keymap.set('n', '<leader>gp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })

          -- don't override the built-in and fugitive keymaps
          local gs = package.loaded.gitsigns
          vim.keymap.set({ 'n', 'v' }, ']c', function()
            if vim.wo.diff then
              return ']c'
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return '<Ignore>'
          end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })
          vim.keymap.set({ 'n', 'v' }, '[c', function()
            if vim.wo.diff then
              return '[c'
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return '<Ignore>'
          end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' })
        end,
      },
    },

    -- {
    --   -- Theme inspired by Atom
    --   'navarasu/onedark.nvim',
    --   priority = 1000,
    --   config = function()
    --     vim.cmd.colorscheme 'onedark'
    --   end,
    -- },

    { 'catppuccin/nvim', name = 'catppuccin', priority = 1000 },

    {
      -- Add indentation guides even on blank lines
      'lukas-reineke/indent-blankline.nvim',
      event = 'VeryLazy',
      -- Enable `lukas-reineke/indent-blankline.nvim`
      -- See `:help ibl`
      main = 'ibl',
      opts = {},
      config = function()
        local highlight = {
          'RainbowRed',
          'RainbowYellow',
          'RainbowBlue',
          'RainbowOrange',
          'RainbowGreen',
          'RainbowViolet',
          'RainbowCyan',
        }

        local hooks = require 'ibl.hooks'
        -- create the highlight groups in the highlight setup hook, so they are reset
        -- every time the colorscheme changes
        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
          vim.api.nvim_set_hl(0, 'RainbowRed', { fg = '#E06C75' })
          vim.api.nvim_set_hl(0, 'RainbowYellow', { fg = '#E5C07B' })
          vim.api.nvim_set_hl(0, 'RainbowBlue', { fg = '#61AFEF' })
          vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = '#D19A66' })
          vim.api.nvim_set_hl(0, 'RainbowGreen', { fg = '#98C379' })
          vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = '#C678DD' })
          vim.api.nvim_set_hl(0, 'RainbowCyan', { fg = '#56B6C2' })
        end)

        require('ibl').setup { indent = { highlight = highlight } }
      end,
    },

    -- -- "gc" to comment visual regions/lines
    { 'numToStr/Comment.nvim', opts = {} },

    {
      'echasnovski/mini.nvim',
      version = false,
      event = 'VeryLazy',
      config = function()
        -- require('mini.comment').setup {}
        require('mini.surround').setup {}
        require('mini.pairs').setup {}
        require('mini.ai').setup()
      end,
    },

    'christoomey/vim-tmux-navigator',
    {
      'kevinhwang91/nvim-ufo',
      event = 'VeryLazy',
      dependencies = { 'kevinhwang91/promise-async' },
      config = function()
        vim.o.foldcolumn = '1' -- '0' is not bad
        vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
        vim.o.foldlevelstart = 99
        vim.o.foldenable = true

        -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
        vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
        vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
        require('ufo').setup {
          provider_selector = function(bufnr, filetype, buftype)
            return { 'treesitter', 'indent' }
          end,
        }
      end,
    },
    {
      'nvim-pack/nvim-spectre',
      event = 'VeryLazy',
      commit = '07201e6bd3b43a193d891cec844dfd1f23e775d1',
      config = function()
        vim.keymap.set('n', '<leader>ss', '<cmd>lua require("spectre").toggle()<CR>', {
          desc = 'Toggle Spectre',
        })
        vim.keymap.set('n', '<leader>sw', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
          desc = 'Search current word',
        })
        vim.keymap.set('v', '<leader>sw', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
          desc = 'Search current word',
        })
        vim.keymap.set('n', '<leader>sp', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
          desc = 'Search on current file',
        })
      end,
    },
    { 'RRethy/vim-illuminate', event = 'VeryLazy' },

    {
      'lewis6991/hover.nvim',
      config = function()
        require('hover').setup {
          init = function()
            -- Require providers
            require 'hover.providers.lsp'
            require 'hover.providers.gh'
            -- require('hover.providers.gh_user')
            -- require('hover.providers.jira')
            -- require('hover.providers.man')
            require 'hover.providers.dictionary'
          end,
          preview_opts = {
            border = 'single',
          },
          -- Whether the contents of a currently open hover window should be moved
          -- to a :h preview-window when pressing the hover keymap.
          preview_window = false,
          title = true,
          mouse_providers = {
            'LSP',
          },
          mouse_delay = 1000,
        }

        -- Setup keymaps
        vim.keymap.set('n', 'K', require('hover').hover, { desc = 'hover.nvim' })
        vim.keymap.set('n', 'gK', require('hover').hover_select, { desc = 'hover.nvim (select)' })

        -- Mouse support
        -- vim.keymap.set('n', '<MouseMove>', require('hover').hover_mouse, { desc = 'hover.nvim (mouse)' })
        -- vim.o.mousemoveevent = true
      end,
    },
    {
      'ojroques/nvim-osc52',
      config = function()
        require('osc52').setup {
          max_length = 0, -- Maximum length of selection (0 for no limit)
          silent = false, -- Disable message on successful copy
          trim = false, -- Trim surrounding whitespaces before copy
          tmux_passthrough = true, -- Use tmux passthrough (requires tmux: set -g allow-passthrough on)
        }
      end,
    },
    {
      'michaelb/sniprun',
      branch = 'master',
      build = 'sh install.sh',
      -- do 'sh install.sh 1' if you want to force compile locally
      -- (instead of fetching a binary from the github release). Requires Rust >= 1.65

      config = function()
        require('sniprun').setup {
          selected_interpreters = {}, --# use those instead of the default for the current filetype
          repl_enable = {}, --# enable REPL-like behavior for the given interpreters
          repl_disable = {}, --# disable REPL-like behavior for the given interpreters

          interpreter_options = { --# interpreter-specific options, see doc / :SnipInfo <name>

            --# use the interpreter name as key
            GFM_original = {
              use_on_filetypes = { 'markdown.pandoc' }, --# the 'use_on_filetypes' configuration key is
              --# available for every interpreter
            },
            Python3_original = {
              error_truncate = 'auto', --# Truncate runtime errors 'long', 'short' or 'auto'
              --# the hint is available for every interpreter
              --# but may not be always respected
            },
          },

          --# you can combo different display modes as desired and with the 'Ok' or 'Err' suffix
          --# to filter only sucessful runs (or errored-out runs respectively)
          display = {
            'Classic', --# display results in the command-line  area
            'VirtualTextOk', --# display ok results as virtual text (multiline is shortened)

            -- "VirtualText",             --# display results as virtual text
            -- "TempFloatingWindow",      --# display results in a floating window
            -- "LongTempFloatingWindow",  --# same as above, but only long results. To use with VirtualText[Ok/Err]
            -- "Terminal",                --# display results in a vertical split
            -- "TerminalWithCode",        --# display results and code history in a vertical split
            -- "NvimNotify",              --# display with the nvim-notify plugin
            -- "Api"                      --# return output to a programming interface
          },

          live_display = { 'VirtualTextOk' }, --# display mode used in live_mode

          display_options = {
            terminal_scrollback = vim.o.scrollback, --# change terminal display scrollback lines
            terminal_line_number = false, --# whether show line number in terminal window
            terminal_signcolumn = false, --# whether show signcolumn in terminal window
            terminal_persistence = true, --# always keep the terminal open (true) or close it at every occasion (false)
            terminal_position = 'vertical', --# or "horizontal", to open as horizontal split instead of vertical split
            terminal_width = 45, --# change the terminal display option width (if vertical)
            terminal_height = 20, --# change the terminal display option height (if horizontal)
            notification_timeout = 5, --# timeout for nvim_notify output
          },

          --# You can use the same keys to customize whether a sniprun producing
          --# no output should display nothing or '(no output)'
          show_no_output = {
            'Classic',
            'TempFloatingWindow', --# implies LongTempFloatingWindow, which has no effect on its own
          },
          --# customize highlight groups (setting this overrides colorscheme)
          snipruncolors = {
            SniprunVirtualTextOk = { bg = '#66eeff', fg = '#000000', ctermbg = 'Cyan', cterfg = 'Black' },
            SniprunFloatingWinOk = { fg = '#66eeff', ctermfg = 'Cyan' },
            SniprunVirtualTextErr = { bg = '#881515', fg = '#000000', ctermbg = 'DarkRed', cterfg = 'Black' },
            SniprunFloatingWinErr = { fg = '#881515', ctermfg = 'DarkRed' },
          },
          live_mode_toggle = 'off', --# live mode toggle, see Usage - Running for more info
          --# miscellaneous compatibility/adjustement settings
          inline_messages = false, --# boolean toggle for a one-line way to display messages
          --# to workaround sniprun not being able to display anything
          borders = 'single', --# display borders around floating windows
          --# possible values are 'none', 'single', 'double', or 'shadow'
        }
      end,
    },

    -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
    --       These are some example plugins that I've included in the kickstart repository.
    --       Uncomment any of the lines below to enable them.
    -- require 'kickstart.plugins.autoformat',
    -- require 'kickstart.plugins.debug',
    -- NOTE: The import below can automatically add your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
    --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
    --    up-to-date with whatever is in the kickstart repo.
    --    Uncomment the following line and add your plugins to `lua/custom/plugins/*.lua` to get going.
    --
    --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
    { import = 'plugins' },
  },
}, {})

vim.cmd.colorscheme 'catppuccin'
-- vim.cmd.colorscheme "onedark"
