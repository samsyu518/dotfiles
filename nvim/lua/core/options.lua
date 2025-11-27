-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt.
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

local opt = vim.opt
-- Make line numbers default
opt.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
opt.relativenumber = true

opt.tabstop = 4
opt.softtabstop = 4
opt.shiftwidth = 4
opt.expandtab = true

opt.smartindent = true

-- Enable mouse mode, can be useful for resizing splits for example!
opt.mouse = "a"

-- Don't show the mode, since it's already in the status line
opt.showmode = false

-- split Like "nosplit", but also shows partial off-screen results in a preview window.
opt.inccommand = "split"

-- make cursor to block fix some issue on terminal and tmux
opt.guicursor = ""

opt.swapfile = false
opt.backup = false
-- Save undo history
opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
opt.undofile = true
opt.undolevels = 10000

opt.wildmode = "list:longest,list:full" -- Command-line completion mode

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  -- test osc52 printf "\e]52;c;$(echo "Hello World" | base64)\a"
  opt.clipboard = "unnamedplus"

  local function paste()
    return {
      vim.fn.split(vim.fn.getreg(""), "\n"),
      vim.fn.getregtype(""),
    }
  end

  if os.getenv("SSH_CLIENT") and not os.getenv("TMUX") then
    vim.g.clipboard = {
      name = "OSC52",
      copy = {
        ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
        ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
      },

      paste = {
        ["+"] = paste,
        ["*"] = paste,
      },
      cache_enabled = true,
    }
  end
end)

-- Enable break indent
opt.breakindent = true

-- Save undo history
opt.undofile = true

-- Set highlight on search
opt.hlsearch = true
opt.incsearch = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
opt.ignorecase = true
opt.smartcase = true

-- Keep signcolumn on by default
opt.signcolumn = "yes"

-- Decrease update time
opt.updatetime = 250

-- Decrease mapped sequence wait time
opt.timeoutlen = 300

-- Configure how new splits should be opened
opt.splitright = true
opt.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Don't have `o` add a comment
opt.formatoptions:remove("o")

-- Preview substitutions live, as you type!
opt.inccommand = "split"

-- Show which line your cursor is on
opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
opt.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
opt.confirm = true
