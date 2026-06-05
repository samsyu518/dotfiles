return {
  "jiaoshijie/undotree",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {},
  keys = {
    {
      "<leader><F5>",
      function()
        require("undotree").toggle()
      end,
      desc = "Undotree",
    },
  },
}
