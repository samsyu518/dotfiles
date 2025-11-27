return {
  flags = {
    debounce_text_changes = 150,
  },
  settings = {
    elixirLS = {
      dialyzerEnabled = true,
      -- fetchDeps = false,
      -- .local/share/mise/installs/elixir/1.16.3-otp-26
      stdlibSrcDir = vim.fn.expand("$HOME/.local/share/mise/installs/elixir/1.16.3-otp-26"),
    },
  },
}
