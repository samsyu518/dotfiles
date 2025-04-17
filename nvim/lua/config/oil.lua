require("oil").setup({
  columns = {
    "icon",
    -- 'permissions',
    -- 'size',
    -- 'mtime',
  },
  view_options = {
    show_hidden = true,
  },
  keymaps = {
    ["gd"] = {
      desc = "Toggle file detail view",
      callback = function()
        detail = not detail
        if detail then
          require("oil").set_columns({ "icon", "permissions", "size", "mtime" })
        else
          require("oil").set_columns({ "icon" })
        end
      end,
    },
  },
  win_options = {
    winbar = "%!v:lua.vim.loop.cwd()",
  },
})
vim.keymap.set("n", "-", '<CMD>lua require("oil").toggle_float()<CR>', { desc = "Open parent directory" })
vim.keymap.set("n", "_", '<CMD>lua require("oil").toggle_float(vim.loop.cwd())<CR>', { desc = "Open cwd directory" })
vim.keymap.set("n", "<leader>-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
