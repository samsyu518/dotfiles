return {
  "stevearc/overseer.nvim",
  opts = {
    task_list = {
      direction = "bottom",
      min_height = 15,
      max_height = 15,
      bindings = {
        ["<CR>"] = "RunAction",
        ["<C-r>"] = "Restart",
        ["q"] = "Close",
      },
    },
    -- send cargo output to quickfix for diagnostic integration
    template_hook = function(opts, task_defn, util)
      if opts.module and opts.module:match("^cargo") then
        util.add_component(task_defn, { "on_output_quickfix", open_on_exit = "failure" })
      end
    end,
  },
  keys = {
    { "<leader>ro", "<cmd>OverseerRun<cr>", desc = "Overseer run task" },
    { "<leader>rt", "<cmd>OverseerToggle<cr>", desc = "Overseer toggle panel" },
    { "<leader>rR", "<cmd>OverseerRestartLast<cr>", desc = "Overseer restart last" },
    { "<leader>rl", "<cmd>OverseerLoadBundle<cr>", desc = "Overseer load bundle" },
  },
}
