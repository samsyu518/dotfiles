return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
  ft = { "markdown" }, -- 開 markdown 檔時載入並自動渲染
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    -- 內建 in-process LSP 補全:輸入 checkbox(- [ )與 callout(> [! )時提供補全
    completions = { blink = { enabled = true } },
  },
  -- stylua: ignore
  keys = {
    { "<leader>um", function() require("render-markdown").toggle() end, desc = "Toggle Markdown Render" },
  },
}
