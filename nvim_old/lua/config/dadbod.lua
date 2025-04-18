vim.g.db_ui_use_nerd_fonts = 1
local set = vim.keymap.set

set("n", "<leader>dd", "<cmd>DBUI <cr>", { desc = "run DBUI" })
set("n", "<leader>dt", "<cmd>DBUIToggle <cr>", { desc = "run DBUIToggle" })

vim.cmd("Dotenv " .. vim.fn.expand(os.getenv("NVIM_DOTENV")))
vim.g.db_ui_save_location = vim.fn.expand(os.getenv("NVIM_DBUI"))

vim.g.Db_ui_buffer_name_generator = function(opts)
  if opts.table == nil or opts.table == "" then
    return vim.fn.strftime("%Y-%m-%d-%H-%M-%S") .. ".sql"
  end
  return opts.table .. "-" .. vim.fn.strftime("%Y-%m-%d-%H-%M-%S") .. ".sql"
end

vim.g.db_ui_table_helpers = {
  mysql = {
    Count = 'select count(*) from "{table}"',
    List = 'select * from "{table}" order by id asc',
  },
}
