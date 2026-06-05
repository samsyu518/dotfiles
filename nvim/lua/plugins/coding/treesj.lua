-- Split or join code blocks (single-line <-> multi-line) using treesitter.
-- e.g. turn a one-line Lua table into a multi-line one and back.
return {
  "Wansmer/treesj",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = { use_default_keymaps = false }, -- defaults grab <leader>s which is taken
  keys = {
    {
      "<leader>m",
      function()
        require("treesj").toggle()
      end,
      desc = "Split/Join block (treesj)",
    },
  },
}
