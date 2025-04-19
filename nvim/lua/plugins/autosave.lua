return {
  "okuuva/auto-save.nvim",
  opts = {
    enabled = true, -- start auto-save when the plugin is loaded (i.e. when your package manager loads it)
    -- function that takes the buffer handle and determines whether to save the current buffer or not
    -- return true: if buffer is ok to be saved
    -- return false: if it's not ok to be saved
    -- if set to `nil` then no specific condition is applied
    condition = function(buf)
      local filetype = vim.fn.getbufvar(buf, "&filetype")
      -- don't save for `sql` file types
      if vim.list_contains({ "sql", "mysql", "dbui", "dbout", "plsql", "OverseerForm" }, filetype) then
        return false
        -- don't save for special-buffers
      elseif vim.fn.getbufvar(buf, "&buftype") ~= "" then
        return false
      end
      return true
    end,
    debounce_delay = 2000, -- delay after which a pending save is executed
    -- log debug messages to 'auto-save.log' file in neovim cache directory, set to `true` to enable
    debug = false,
  },
}
