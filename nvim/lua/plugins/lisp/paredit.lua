-- nvim-paredit: treesitter-powered structural editing for Lisps.
-- Depends on the scheme/racket treesitter parsers installed in
-- lua/plugins/treesitter.lua. Provides slurp/barf/raise plus sexp text
-- objects so you manipulate parens by structure, not by character.
return {
  "julienvincent/nvim-paredit",
  ft = { "racket", "scheme", "lisp", "clojure", "fennel" },
  opts = {
    filetypes = { "racket", "scheme", "lisp", "clojure", "fennel" },
    -- stylua: ignore
    keys = {
      [">)"] = { "slurp_forwards", "Slurp forwards" },
      ["<)"] = { "barf_forwards", "Barf forwards" },
      [">("] = { "slurp_backwards", "Slurp backwards" },
      ["<("] = { "barf_backwards", "Barf backwards" },
      ["<localleader>o"] = { "raise_form", "Raise form" },
      ["<localleader>O"] = { "raise_element", "Raise element" },
      ["<localleader>@"] = { "splice", "Splice (remove surrounding parens)" },
    },
  },
}
