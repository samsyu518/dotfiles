return {
  -- Fuzzy Finder (files, lsp, etc)
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    event = "VeryLazy",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      -- [[ Configure Telescope ]]
      -- See `:help telescope` and `:help telescope.setup()`
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              -- ['<C-u>'] = false,
              -- ['<C-d>'] = false,
            },
          },
          file_ignore_patterns = {},
        },
        pickers = {
          find_files = {},
          live_grep = {},
        },
      })

      -- Enable telescope fzf native, if installed
      pcall(require("telescope").load_extension, "fzf")

      -- See `:help telescope.builtin`
      vim.keymap.set(
        "n",
        "<leader>?",
        require("telescope.builtin").oldfiles,
        { desc = "[?] Find recently opened files" }
      )
      vim.keymap.set(
        "n",
        "<leader><space>",
        require("telescope.builtin").buffers,
        { desc = "[ ] Find existing buffers" }
      )
      vim.keymap.set("n", "<leader>/", function()
        -- You can pass additional configuration to telescope to change theme, layout, etc.
        require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
          winblend = 10,
          previewer = false,
        }))
      end, { desc = "[/] Fuzzily search in current buffer" })

      vim.keymap.set("n", "<leader>fg", require("telescope.builtin").git_files, { desc = "Search [G]it [F]iles" })
      vim.keymap.set("n", "<leader>ff", function()
        require("telescope.builtin").find_files({})
      end, { desc = "[S]earch [F]iles" })
      vim.keymap.set("n", "<leader>fh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
      vim.keymap.set("n", "<leader>fw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })
      vim.keymap.set("n", "<leader>f/", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
      vim.keymap.set("n", "<leader>fd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
      vim.keymap.set("n", "<leader>fr", require("telescope.builtin").resume, { desc = "[S]earch [R]esume" })
    end,
  },
}
