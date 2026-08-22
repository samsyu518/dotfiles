-- nvim-paredit: treesitter-powered structural editing for Lisps.
-- Needs the treesitter parser for each filetype below (see
-- lua/plugins/treesitter.lua). Provides slurp/barf/raise plus sexp text
-- objects so you manipulate parens by structure, not by character.
--
-- `keys` values must be {function, description}. Passing the action name as a
-- string silently produces keymaps that throw "attempt to call a string value"
-- when pressed, so `opts` is a function: the api module can only be required
-- once lazy.nvim has loaded the plugin.
return {
  "julienvincent/nvim-paredit",
  ft = { "racket", "scheme", "lisp", "clojure", "fennel" },
  opts = function()
    local api = require("nvim-paredit.api")
    local unwrap = require("nvim-paredit.api.unwrap")
    return {
      filetypes = { "racket", "scheme", "lisp", "clojure", "fennel" },
      -- `>` grows the form, `<` shrinks it; `)` acts forwards, `(` backwards.
      -- This is deliberately more regular than the plugin's own defaults,
      -- which swap the meaning of `>(` and `<(`.
      -- stylua: ignore
      keys = {
        [">)"]              = { api.slurp_forwards,            "Slurp forwards" },
        ["<)"]              = { api.barf_forwards,             "Barf forwards" },
        [">("]              = { api.slurp_backwards,           "Slurp backwards" },
        ["<("]              = { api.barf_backwards,            "Barf backwards" },
        ["<localleader>o"]  = { api.raise_form,                "Raise form" },
        ["<localleader>O"]  = { api.raise_element,             "Raise element" },
        ["<localleader>@"]  = { unwrap.unwrap_form_under_cursor, "Splice (remove surrounding parens)" },
      },
    }
  end,
}
