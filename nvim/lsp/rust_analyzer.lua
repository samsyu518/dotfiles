return {
  settings = {
    ["rust-analyzer"] = {
      checkOnSave = { command = "clippy" },
      inlayHints = {
        bindingModeHints = { enable = true },
        closureReturnTypeHints = { enable = "with_block" },
      },
    },
  },
}
