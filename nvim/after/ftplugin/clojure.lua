-- Clojure buffers.
vim.bo.commentstring = ";; %s"
vim.bo.expandtab = true
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2

-- Treat Lisp identifier punctuation as part of a "word" so w/b/* motions, LSP
-- symbol lookup and completion grab the whole name (e.g. `swap!`, `even?`, `->>`).
vim.opt_local.iskeyword:append({ "-", "!", "?", "*", "+", "<", ">", "=", "/", ":" })
