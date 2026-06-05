-- [[ Basic Keymaps ]]
--*set-table*
--          Mode  | Norm | Ins | Cmd | Vis | Sel | Opr | Term | Lang | ~
-- Command        +------+-----+-----+-----+-----+-----+------+------+ ~
-- [nore]set      | yes  |  -  |  -  | yes | yes | yes |  -   |  -   |
-- n[nore]set     | yes  |  -  |  -  |  -  |  -  |  -  |  -   |  -   |
-- [nore]set!     |  -   | yes | yes |  -  |  -  |  -  |  -   |  -   |
-- i[nore]set     |  -   | yes |  -  |  -  |  -  |  -  |  -   |  -   |
-- c[nore]set     |  -   |  -  | yes |  -  |  -  |  -  |  -   |  -   |
-- v[nore]set     |  -   |  -  |  -  | yes | yes |  -  |  -   |  -   |
-- x[nore]set     |  -   |  -  |  -  | yes |  -  |  -  |  -   |  -   |
-- s[nore]set     |  -   |  -  |  -  |  -  | yes |  -  |  -   |  -   |
-- o[nore]set     |  -   |  -  |  -  |  -  |  -  | yes |  -   |  -   |
-- t[nore]set     |  -   |  -  |  -  |  -  |  -  |  -  | yes  |  -   |
-- l[nore]set     |  -   | yes | yes |  -  |  -  |  -  |  -   | yes  |
--

--  See `:help vim.keymap.set()`
local set = vim.keymap.set

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Basic movement keybinds, these make navigating splits easy for me
set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
-- quick move select text
set("v", "<A-j>", ":m '>+1<CR>gv=gv")
set("v", "<A-k>", ":m '<-2<CR>gv=gv")
set("v", "J", ":m '>+1<CR>gv=gv")
set("v", "K", ":m '<-2<CR>gv=gv")
set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })

-- greatest remap event_args
--[[ " Greatest remap EVER!!
 Let me explain, this remap while in visiual mode
 will delete what is currently highlighted and replace it
 with what is in the register BUT it will YANK (delete) it
 to a VOID register. Meaning I still have what I originally had
 when I pasted. I don't loose the previous thing I YANKED! ]]
set("x", "p", [["_dP]])
-- yank to black hole
set({ "n", "v" }, "c", [["_c]])
set({ "n", "v" }, "d", [["_d]])
-- normal yank
set({ "n", "v" }, "C", "c")
set({ "n", "v" }, "D", "d")

-- quick file replace
set("n", "<leader>fs", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
--[[
for test replace vf\;<Space>fs
c:\program files\vim
c:\program files\neovim

escape(@z, ' \/') escapes the contents of register z .
<C-r>= is used to evaluate the expression inside escape(@z, ' \/').
<CR> is used to close the expression evaluation ]]
-- set('v', '<leader>fs', [["zy:%s/\<<C-r>z\>/<C-r>z/gc<left><left><left>]])
set("v", "<leader>fs", [["zy:%s/<C-r>=escape(@z, ' \/')<CR>/<C-r>=escape(@z, ' \/')<CR>/gc<left><left><left>]])

-- quick make file execute
set("n", "<leader>fx", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })
-- Keymaps for better default experience disable origin leader key space behavior
set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
-- better up/down
set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "down", expr = true, silent = true })
set({ "n", "x" }, "<down>", "v:count == 0 ? 'gj' : 'j'", { desc = "down", expr = true, silent = true })
set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "up", expr = true, silent = true })
set({ "n", "x" }, "<up>", "v:count == 0 ? 'gk' : 'k'", { desc = "up", expr = true, silent = true })

-- Remap down up for select complete
set("c", "<down>", function()
  if vim.fn.pumvisible() == 1 then
    return "<c-n>"
  end
  return "<down>"
end, { expr = true })

set("c", "<up>", function()
  if vim.fn.pumvisible() == 1 then
    return "<c-p>"
  end
  return "<up>"
end, { expr = true })

-- cmd list
set("n", "<leader>cS", "<cmd>.lua <cr>", { desc = "run the current line lua" })
set("n", "<leader>cs", "<cmd>w<cr><cmd>source %<cr>", { desc = "source current file" })
set("n", "<leader>cM", "<cmd>Mason<cr>", { desc = "Mason" })
set("n", "<leader>cL", "<cmd>Lazy<cr>", { desc = "Lazy" })
set("n", "<leader>cli", "<cmd>checkhealth vim.lsp<cr>", { desc = "LspInfo" })
set("n", "<leader>cll", "<cmd>lua vim.cmd('tabnew ' .. vim.lsp.log.get_filename())<cr>", { desc = "LspLog" })
set("n", "<leader>ci", "<cmd>InspectTree<cr>", { desc = "InspectTree" })
set("n", "<leader>cc", "<cmd>checkhealth<cr>", { desc = "checkhealth" })
set("n", "<leader>cn", "<cmd>vnew<cr>", { desc = "vnew" })
set("n", "<leader>cN", "<cmd>new<cr>", { desc = "new" })
set("n", "<leader>cf", ":set filetype=", { desc = "quick set filetype" })

-- Quit all
set("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })
vim.keymap.set("n", "<leader>qr", function()
  local session_file = vim.fn.stdpath("state") .. "/Session.vim"
  vim.cmd("mks! " .. vim.fn.fnameescape(session_file))
  vim.cmd("restart source " .. vim.fn.fnameescape(session_file))
end, { desc = "Save session and restart with it" })

-- These mappings control the size of splits (height/width)
set("n", "<M-,>", "<c-w>5<")
set("n", "<C-Left>", "<c-w>5<")
set("n", "<M-.>", "<c-w>5>")
set("n", "<C-Right>", "<c-w>5>")
set("n", "<M-=>", "<C-W>2+")
set("n", "<C-Up>", "<C-W>2+")
set("n", "<M-->", "<C-W>2-")
set("n", "<C-Down>", "<C-W>2-")

-- Diagnostic keymaps
set("n", "<leader>ds", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
set("n", "<leader>df", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })

-- buffer action
-- set("n", "gn", vim.cmd.bn, { desc = "buffer next" })
-- set("n", "gp", vim.cmd.bp, { desc = "buffer previous" })
set("n", "<S-l>", vim.cmd.bn, { desc = "buffer next" })
set("n", "<S-h>", vim.cmd.bp, { desc = "buffer previous" })
-- set("n", "<M-n>", vim.cmd.bn, { desc = "buffer next" })
-- set("n", "<M-p>", vim.cmd.bp, { desc = "buffer previous" })

-- set("n", "<leader>bo", "<cmd>%bd|e#<cr>", { desc = "Delete Other Buffers" })
set("n", "<leader>bo", function()
  Snacks.bufdelete.other()
end, { desc = "Delete Other Buffers" })
set("n", "<S-w>", vim.cmd.bd, { desc = "buffer delete" })
set("n", "<leader>bn", vim.cmd.new, { desc = "buffer new" })
set("n", "<leader>bss", function()
  -- vim.cmd("new")
  -- vim.bo.filetype = "sql"
  Snacks.scratch({ ft = "sql" })
end, { desc = "[S]cratchpad [S]QL" })
set("n", "<leader>bsm", function()
  Snacks.scratch({ ft = "markdown" })
end, { desc = "[S]cratchpad [N]ew" })

set("n", "<leader>bsl", function()
  Snacks.scratch({ ft = "lua" })
end, { desc = "[S]cratchpad [l]ua" })

set("n", "<leader>bsS", function()
  Snacks.scratch.select()
end, { desc = "[S]cratchpad [S]elect" })

set("n", "<leader>bka", "<cmd>%bd|e<cr>", { desc = "buffer kill all" })

-- save file
set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- better indenting in visual select
set("x", "<", "<gv")
set("x", ">", ">gv")

-- commenting
set("n", "gco", "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
set("n", "gcO", "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

-- noice nvim
set("n", "<leader>nl", function()
  require("noice").cmd("last")
end, { desc = "noice last" })

set("n", "<leader>nh", function()
  require("noice").cmd("history")
end, { desc = "noice history" })

set("n", "<leader>nt", function()
  require("noice").cmd("telescope")
end, { desc = "noice telescope" })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- NOTE: Some terminals have colliding keymaps or are not able to send distinct keycodes
-- set("n", "<C-S-h>", "<C-w>H", { desc = "Move window to the left" })
-- set("n", "<C-S-l>", "<C-w>L", { desc = "Move window to the right" })
-- set("n", "<C-S-j>", "<C-w>J", { desc = "Move window to the lower" })
-- set("n", "<C-S-k>", "<C-w>K", { desc = "Move window to the upper" })

require("config.ts_incremental").setup()
