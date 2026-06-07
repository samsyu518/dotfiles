-- Conjure: interactive, REPL-driven evaluation for Lisps.
-- For SICP we use it with Racket (`#lang sicp`) and Scheme files.
--
-- Workflow: open a .rkt buffer, Conjure auto-starts a `racket` REPL, then
-- evaluate forms in place:
--   <localleader>ee  eval form under cursor
--   <localleader>er  eval current top-level form (root)
--   <localleader>ef  eval whole file
--   <localleader>ec  eval form and write result to a comment
--   <localleader>lv  open the Conjure log in a vertical split
-- See `:help conjure` and sicp-learn/setup.md for the full keymap table.
return {
  "Olical/conjure",
  ft = { "racket", "scheme" },
  init = function()
    -- Only enable Conjure's mappings for the filetypes we care about.
    vim.g["conjure#filetypes"] = { "racket", "scheme" }
    -- Use the system `racket` for the stdio REPL client.
    vim.g["conjure#client#racket#stdio#command"] = "racket"
    -- Don't shadow LSP hover (K) with Conjure's doc lookup.
    vim.g["conjure#mapping#doc_word"] = false
    -- Keep the HUD (floating log preview) unobtrusive.
    vim.g["conjure#log#hud#width"] = 0.42
  end,
}
