-- Treesitter on Neovim 0.12 / nvim-treesitter `main` branch.
--
-- The `main` branch is a full rewrite: the plugin now only installs parsers and
-- queries. Highlighting/indentation are provided by Neovim itself and enabled
-- per-buffer (see `:help treesitter`). The old `nvim-treesitter.configs` setup
-- table (highlight/indent/incremental_selection/textobjects) no longer exists.

local ensure_installed = {
  "bash",
  "c",
  "diff",
  "elixir",
  "go",
  "heex",
  "html",
  "lua",
  "luadoc",
  "markdown",
  "markdown_inline",
  "python",
  "query",
  "racket",
  "regex",
  "rust",
  "scheme",
  "sql",
  "vim",
  "vimdoc",
}

return {
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    -- Follow `main` HEAD on Neovim 0.12+; pin a known-good commit on older Neovim.
    version = false,
    commit = vim.fn.has("nvim-0.12") == 0 and "7caec274fd19c12b55902a5b795100d21531391f" or nil,
    lazy = false,
    build = ":TSUpdate",
    config = function()
      -- Install parsers/queries into stdpath('data')/site (async, no-op if present).
      require("nvim-treesitter").install(ensure_installed)

      local function have_query(lang, query)
        return vim.treesitter.query.get(lang, query) ~= nil
      end

      -- Enable features per-buffer, only when the relevant query exists, and
      -- without clobbering a filetype-specific indentexpr/foldmethod (set_default).
      vim.api.nvim_create_autocmd("FileType", {
        group = vim.api.nvim_create_augroup("user_treesitter", { clear = true }),
        desc = "Enable treesitter highlighting, indentation and folding",
        callback = function(ev)
          local lang = vim.treesitter.language.get_lang(ev.match)
          if not lang then
            return
          end

          -- highlighting
          if have_query(lang, "highlights") then
            pcall(vim.treesitter.start, ev.buf)
          end

          -- indentation (don't override a filetype-specific indentexpr)
          if have_query(lang, "indents") and vim.bo[ev.buf].indentexpr == "" then
            vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          end

          -- folding (window-local; only if the user hasn't customized it)
          if have_query(lang, "folds") then
            local win = vim.api.nvim_get_current_win()
            if vim.wo[win].foldmethod == "manual" then
              vim.wo[win].foldmethod = "expr"
              vim.wo[win].foldexpr = "v:lua.vim.treesitter.foldexpr()"
            end
          end
        end,
      })
    end,
  },

  -- Syntax-aware text objects: select / move / swap.
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      select = {
        lookahead = true, -- jump forward to textobj, like targets.vim
        selection_modes = {
          ["@function.outer"] = "V", -- select functions linewise
          ["@class.outer"] = "V", -- select classes linewise
        },
      },
      move = { set_jumps = true },
    },
    -- stylua: ignore
    keys = {
      -- select
      { "aa", function() require("nvim-treesitter-textobjects.select").select_textobject("@parameter.outer", "textobjects") end, mode = { "x", "o" }, desc = "a parameter" },
      { "ia", function() require("nvim-treesitter-textobjects.select").select_textobject("@parameter.inner", "textobjects") end, mode = { "x", "o" }, desc = "inner parameter" },
      { "af", function() require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects") end, mode = { "x", "o" }, desc = "a function" },
      { "if", function() require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects") end, mode = { "x", "o" }, desc = "inner function" },
      { "ac", function() require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects") end, mode = { "x", "o" }, desc = "a class" },
      { "ic", function() require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects") end, mode = { "x", "o" }, desc = "inner class" },
      -- move
      { "]m", function() require("nvim-treesitter-textobjects.move").goto_next_start("@function.outer", "textobjects") end, mode = { "n", "x", "o" }, desc = "Next function start" },
      { "]]", function() require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects") end, mode = { "n", "x", "o" }, desc = "Next class start" },
      { "]M", function() require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects") end, mode = { "n", "x", "o" }, desc = "Next function end" },
      { "][", function() require("nvim-treesitter-textobjects.move").goto_next_end("@class.outer", "textobjects") end, mode = { "n", "x", "o" }, desc = "Next class end" },
      { "[m", function() require("nvim-treesitter-textobjects.move").goto_previous_start("@function.outer", "textobjects") end, mode = { "n", "x", "o" }, desc = "Prev function start" },
      { "[[", function() require("nvim-treesitter-textobjects.move").goto_previous_start("@class.outer", "textobjects") end, mode = { "n", "x", "o" }, desc = "Prev class start" },
      { "[M", function() require("nvim-treesitter-textobjects.move").goto_previous_end("@function.outer", "textobjects") end, mode = { "n", "x", "o" }, desc = "Prev function end" },
      { "[]", function() require("nvim-treesitter-textobjects.move").goto_previous_end("@class.outer", "textobjects") end, mode = { "n", "x", "o" }, desc = "Prev class end" },
      -- swap
      { "<leader>ta", function() require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner") end, desc = "Swap next parameter" },
      { "<leader>tA", function() require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner") end, desc = "Swap previous parameter" },
      -- repeatable moves: ; repeats the last move forward, , backward.
      { ";", function() require("nvim-treesitter-textobjects.repeatable_move").repeat_last_move_next() end, mode = { "n", "x", "o" }, desc = "Repeat last move (forward)" },
      { ",", function() require("nvim-treesitter-textobjects.repeatable_move").repeat_last_move_previous() end, mode = { "n", "x", "o" }, desc = "Repeat last move (backward)" },
      -- keep builtin f/F/t/T repeatable via ; and , too
      { "f", function() return require("nvim-treesitter-textobjects.repeatable_move").builtin_f_expr() end, mode = { "n", "x", "o" }, expr = true, desc = "Find char (repeatable)" },
      { "F", function() return require("nvim-treesitter-textobjects.repeatable_move").builtin_F_expr() end, mode = { "n", "x", "o" }, expr = true, desc = "Find char backward (repeatable)" },
      { "t", function() return require("nvim-treesitter-textobjects.repeatable_move").builtin_t_expr() end, mode = { "n", "x", "o" }, expr = true, desc = "Till char (repeatable)" },
      { "T", function() return require("nvim-treesitter-textobjects.repeatable_move").builtin_T_expr() end, mode = { "n", "x", "o" }, expr = true, desc = "Till char backward (repeatable)" },
    },
  },

  -- Sticky context header for the current scope (works with built-in treesitter).
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    opts = { max_lines = 3 },
  },
}
