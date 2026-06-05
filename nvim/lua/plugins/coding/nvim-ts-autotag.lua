-- Auto close and auto rename HTML/JSX/Vue/heex tags using treesitter.
return {
  "windwp/nvim-ts-autotag",
  ft = {
    "html",
    "xml",
    "javascript",
    "javascriptreact",
    "typescript",
    "typescriptreact",
    "svelte",
    "vue",
    "tsx",
    "markdown",
    "heex",
    "elixir",
    "eelixir",
    "php",
  },
  opts = {},
}
