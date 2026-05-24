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

-- vim.g.clipboard = "osc52"
-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  opt.clipboard = "unnamedplus"
  -- test osc52 printf "\e]52;c;$(echo "Hello World" | base64)\a"
  local function is_ssh()
    return vim.env.SSH_CONNECTION ~= nil or vim.env.SSH_CLIENT ~= nil or vim.env.SSH_TTY ~= nil
  end

  local function has(cmd)
    return vim.fn.executable(cmd) == 1
  end

  local function paste_from_register()
    return {
      vim.fn.split(vim.fn.getreg(""), "\n"),
      vim.fn.getregtype(""),
    }
  end

  local function paste_from_cmd(cmd)
    local output = vim.fn.systemlist(cmd)
    return { output, "V" }
    -- https://neovim.io/doc/user/vimfn.html#getregtype()
  end

  local function system_paste()
    -- 1. SSH：Neovim register
    if is_ssh() then
      return paste_from_register()
    end

    -- 2. Wayland
    if vim.env.WAYLAND_DISPLAY and has("wl-paste") then
      return paste_from_cmd("wl-paste")
    end

    -- 3. WSL
    if vim.fn.has("wsl") == 1 and has("nvim_paste") then
      return paste_from_cmd("nvim_paste")
    end

    -- 4. X11
    if vim.env.DISPLAY and has("xclip") then
      return paste_from_cmd("xclip -selection clipboard -o")
    end

    -- 5. macOS
    if vim.fn.has("mac") == 1 and has("pbpaste") then
      return paste_from_cmd("pbpaste")
    end

    -- fallback
    return paste_from_register()
  end

  -- if os.getenv("SSH_CLIENT") and not os.getenv("TMUX") then
  vim.g.clipboard = {
    name = "OSC52",
    copy = {

      ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
      ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
    },

    paste = {
      ["+"] = system_paste,
      ["*"] = system_paste,
    },
    cache_enabled = true,
  }
  -- end
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

opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
opt.confirm = true
