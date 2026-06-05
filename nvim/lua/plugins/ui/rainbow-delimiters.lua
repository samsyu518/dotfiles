-- Rainbow-colored matching brackets/delimiters, powered by built-in treesitter.
-- No dependency on nvim-treesitter's config layer, so it is unaffected by the
-- `main` branch rewrite.
return {
  "HiPhish/rainbow-delimiters.nvim",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("rainbow-delimiters.setup").setup({})
  end,
}
