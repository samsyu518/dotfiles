return {

  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function(_, opts)
      require("bufferline").setup(opts)
    end,
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        always_show_bufferline = true,
        diagnostics_indicator = function(count, level)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end,
      },
    },
  },
  {
    "stevearc/oil.nvim",
    event = "VeryLazy",
    config = function(_, opts)
      require("config.oil")
    end,
  },
  -- {
  --   'nvim-neo-tree/neo-tree.nvim',
  --   event = 'VeryLazy',
  --   branch = 'v3.x',
  --   dependencies = {
  --     'nvim-lua/plenary.nvim',
  --     'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
  --     'MunifTanjim/nui.nvim',
  --     -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  --   },
  --   keys = {
  --     {
  --       '<leader>ft',
  --       function()
  --         require('neo-tree.command').execute { toggle = true, dir = vim.loop.cwd() }
  --       end,
  --       desc = 'Explorer NeoTree (cwd)',
  --     },
  --     {
  --       '<leader>ge',
  --       function()
  --         require('neo-tree.command').execute { source = 'git_status', toggle = true }
  --       end,
  --       desc = 'Git explorer',
  --     },
  --     {
  --       '<leader>be',
  --       function()
  --         require('neo-tree.command').execute { source = 'buffers', toggle = true }
  --       end,
  --       desc = 'Buffer explorer',
  --     },
  --   },
  --   deactivate = function()
  --     vim.cmd [[Neotree close]]
  --   end,
  --   opts = {
  --     sources = { 'filesystem', 'buffers', 'git_status', 'document_symbols' },
  --     open_files_do_not_replace_types = { 'terminal', 'Trouble', 'trouble', 'qf', 'Outline' },
  --     filesystem = {
  --       bind_to_cwd = false,
  --       follow_current_file = { enabled = true },
  --       use_libuv_file_watcher = true,
  --     },
  --     window = {
  --       mappings = {
  --         ['<space>'] = 'none',
  --       },
  --     },
  --     default_component_configs = {
  --       indent = {
  --         with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
  --         expander_collapsed = '',
  --         expander_expanded = '',
  --         expander_highlight = 'NeoTreeExpander',
  --       },
  --     },
  --   },
  --   config = function(_, opts)
  --     require('neo-tree').setup(opts)
  --   end,
  -- },
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    init = function()
      vim.g.lualine_laststatus = vim.o.laststatus
      if vim.fn.argc(-1) > 0 then
        -- set an empty statusline till lualine loads
        vim.o.statusline = " "
      else
        -- hide the statusline on the starter page
        vim.o.laststatus = 0
      end
    end,
    opts = function()
      return {
        options = {
          icons_enabled = true,
          theme = "auto",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = {
            statusline = {},
            winbar = {},
          },
          ignore_focus = {},
          always_divide_middle = true,
          globalstatus = false,
          refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
          },
        },
        sections = {
          lualine_a = { "mode" },
          lualine_b = { "branch", "diff", "diagnostics" },
          lualine_c = { { "filename", path = 1 } },
          lualine_x = {
            {
              "datetime",
              style = "%Y-%m-%d %I:%M:%S %p",
            },
            "encoding",
            "fileformat",
            "filetype",
          },
          lualine_y = { "filesize", "progress" },
          lualine_z = { "location" },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { "filename" },
          lualine_x = { "location" },
          lualine_y = {},
          lualine_z = {},
        },
        tabline = {},
        winbar = {},
        inactive_winbar = {},
        extensions = {},
      }
    end,
  },
}
