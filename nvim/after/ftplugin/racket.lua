-- Racket buffers (SICP exercises use `#lang sicp` in .rkt files).
vim.bo.commentstring = ";; %s"
vim.bo.expandtab = true
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2

-- Treat Lisp identifier punctuation as part of a "word" so w/b/* motions, LSP
-- symbol lookup and completion grab the whole name (e.g. `set!`, `null?`, `<=`).
vim.opt_local.iskeyword:append({ "-", "!", "?", "*", "+", "<", ">", "=", "/", ":" })
