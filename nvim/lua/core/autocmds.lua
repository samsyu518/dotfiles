-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

local augroup = vim.api.nvim_create_augroup
-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "highlight when yanking (copying) text",
  group = augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  desc = "Set CWD to the directory of the file passed to nvim",
  group = augroup("set-cwd-to-open-file-path", { clear = true }),

  callback = function()
    if #vim.fn.argv() == 1 then
      local arg = vim.fn.expand(vim.fn.argv(0))
      local path = vim.fn.isdirectory(arg) == 1 and arg or vim.fn.fnamemodify(arg, ":h")
      if path ~= "" then
        vim.api.nvim_set_current_dir(path)
      end
    end
  end,
})
