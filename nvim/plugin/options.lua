-- [[ Setting options ]]
-- See `:help opt.
local opt = vim.opt
opt.inccommand = "split"

opt.guicursor = ""

-- Make line numbers default
opt.nu = true
opt.relativenumber = true

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.smartindent = true

-- Enable mouse mode
opt.mouse = "a"

opt.swapfile = false
opt.backup = false
-- Save undo history
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true
opt.undolevels = 10000
opt.wildmode = "longest:full,full" -- Command-line completion mode
opt.fillchars = {
  foldopen = "",
  foldclose = "",
  -- fold = "⸱",
  fold = " ",
  foldsep = " ",
  diff = "╱",
  eob = " ",
}

if os.getenv("SSH_CLIENT") and not os.getenv("TMUX") then
  vim.g.clipboard = {
    name = "LemonadeClipboard",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },

    paste = {
      ["+"] = { "lemonade", "paste" },
      ["*"] = { "lemonade", "paste" },
    },
    cache_enabled = true,
  }
end

vim.o.clipboard = "unnamedplus"

-- Enable break indent
opt.breakindent = true

-- Set highlight on search
opt.hlsearch = true
opt.incsearch = true
-- Case-insensitive searching UNLESS \C or capital in search
opt.ignorecase = true
opt.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Decrease update time
opt.updatetime = 250
opt.timeoutlen = 300

-- Set completeopt to have a better completion experience
-- setup in lsp.lua
-- opt.completeopt = 'menu,menuone,noinsert'

-- NOTE: You should make sure your terminal supports this
opt.termguicolors = true

opt.scrolloff = 8
opt.colorcolumn = "80"
-- Don't have `o` add a comment
opt.formatoptions:remove("o")

-- for vnew new
opt.splitbelow = true
opt.splitright = true

vim.g.python3_host_prog = "~/.venv/bin/python"
-- opt.foldmethod = 'expr'
-- opt.foldexpr = 'nvim_treesitter#foldexpr()'

vim.cmd.colorscheme("catppuccin")
-- vim.cmd.colorscheme 'onedark'
