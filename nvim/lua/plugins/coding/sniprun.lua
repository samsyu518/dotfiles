return {
  "michaelb/sniprun",
  branch = "master",
  build = "sh install.sh",
  opts = {
    -- for Rust: Rust_original uses rustc directly (no cargo deps)
    -- remove this line to use auto-detection
    selected_interpreters = {},
    display = { "TerminalWithCode" },
    live_mode_toggle = "off",
  },
  keys = {
    { "<leader>rn", "<Plug>SnipRun", mode = { "n", "v" }, desc = "SnipRun run" },
    { "<leader>rq", "<Plug>SnipClose", desc = "SnipRun close" },
    { "<leader>rx", "<cmd>SnipReset<cr>", desc = "SnipRun reset" },
  },
}
