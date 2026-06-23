return { -- Autoformat
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>fF",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      mode = "",
      desc = "[F]ormat buffer",
    },
    -- {
    --   "<leader>fF",
    --   -- [[:'<,'>lua require("conform").format()<CR>]],
    --   function()
    --     require("conform").format({ async = true, lsp_format = "fallback" })
    --   end,
    --   mode = "v",
    --   desc = "[F]ormat buffer select",
    -- },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Disable "format_on_save lsp_fallback" for languages that don't
      -- have a well standardized coding style. You can add additional
      -- languages here or re-enable it for the disabled ones.
      local disable_filetypes = { c = true, cpp = true }
      if disable_filetypes[vim.bo[bufnr].filetype] then
        return nil
      else
        return {
          timeout_ms = 500,
          lsp_format = "fallback",
        }
      end
    end,
    formatters_by_ft = {
      lua = { "stylua" },
      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
      python = { "ruff_format" },

      --
      -- You can use 'stop_after_first' to run the first available formatter from the list
      javascript = { "prettierd", "prettier", stop_after_first = true },
      typescript = { "prettierd", "prettier", stop_after_first = true },
      javascriptreact = { "prettierd", "prettier", stop_after_first = true },
      typescriptreact = { "prettierd", "prettier", stop_after_first = true },
      astro = { "prettierd", "prettier", stop_after_first = true },
      json = { "prettierd", "prettier", stop_after_first = true },
      sql = { "sql_formatter" },
      rust = { "rustfmt" },
      -- Use the "*" filetype to run formatters on all filetypes.
      -- ["*"] = { "codespell", "trim_whitespace" },
      ["*"] = { "trim_whitespace" },
      -- Use the "_" filetype to run formatters on filetypes that don't
      -- have other formatters configured.
    },
    formatters = {},
  },
}
