-- Scheme buffers (.scm). Same conventions as Racket.
vim.bo.commentstring = ";; %s"
vim.bo.expandtab = true
vim.bo.shiftwidth = 2
vim.bo.tabstop = 2
vim.bo.softtabstop = 2

vim.opt_local.iskeyword:append({ "-", "!", "?", "*", "+", "<", ">", "=", "/", ":" })
