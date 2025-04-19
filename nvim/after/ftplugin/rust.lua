require("overseer").register_template({
  name = "rustc current file",
  params = {},
  builder = function()
    local file = vim.fn.expand("%:p")
    return {
      cmd = { "rustc" },
      args = { file },
      components = { { "on_output_quickfix", open = true }, "default" },
    }
  end,
  condition = {
    filetype = { "rust" },
  },
})
