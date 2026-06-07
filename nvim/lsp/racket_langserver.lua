-- racket-langserver: completion, hover, go-to-definition for Racket/Scheme.
-- Backend is installed separately with `raco pkg install racket-langserver`
-- (NOT via mason). lspconfig already ships the default config, including
-- `cmd = { "racket", "-l", "racket-langserver" }`, so this override can stay
-- empty. Enabled from lua/config/lsp.lua via `vim.lsp.enable("racket_langserver")`.
return {}
