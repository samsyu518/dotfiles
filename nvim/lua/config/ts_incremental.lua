-- A small standalone replacement for the `incremental_selection` module that the
-- nvim-treesitter `main` branch removed. Uses only Neovim's built-in treesitter.
--
-- Enable it by calling `require("config.ts_incremental").setup()` (see the
-- commented line at the bottom of lua/core/keymaps.lua).
--
-- Keymaps (matching the old defaults):
--   <C-space>  start selection (normal) / grow to parent node (visual)
--   <C-s>      grow to the enclosing multi-line scope
--   <C-x>      shrink back to the previous selection

local M = {}

-- per-buffer stack of selected nodes
local stack = {}

local function buf()
  return vim.api.nvim_get_current_buf()
end

local function ranges_equal(a, b)
  local a1, a2, a3, a4 = a:range()
  local b1, b2, b3, b4 = b:range()
  return a1 == b1 and a2 == b2 and a3 == b3 and a4 == b4
end

local function select_node(node)
  local srow, scol, erow, ecol = node:range()
  -- treesitter ranges are 0-based with an exclusive end column; convert the end
  -- to the last *included* 0-based column for nvim_win_set_cursor.
  if ecol == 0 then
    erow = erow - 1
    ecol = math.max(#vim.fn.getline(erow + 1), 1)
  end
  -- Leave any current visual selection, then reselect from start to end. This is
  -- deterministic, unlike setting '< '> marks and running `gv`.
  if vim.fn.mode():match("[vV\22]") then
    vim.cmd("normal! \27")
  end
  vim.api.nvim_win_set_cursor(0, { srow + 1, scol })
  vim.cmd("normal! v")
  vim.api.nvim_win_set_cursor(0, { erow + 1, math.max(ecol - 1, 0) })
end

function M.init_selection()
  local node = vim.treesitter.get_node()
  if not node then
    return
  end
  stack[buf()] = { node }
  select_node(node)
end

function M.node_incremental()
  local s = stack[buf()]
  if not s or #s == 0 then
    return M.init_selection()
  end
  local node = s[#s]
  local parent = node:parent()
  while parent and ranges_equal(parent, node) do
    parent = parent:parent()
  end
  if parent then
    table.insert(s, parent)
    select_node(parent)
  end
end

function M.scope_incremental()
  local s = stack[buf()]
  if not s or #s == 0 then
    return M.init_selection()
  end
  local node = s[#s]
  local srow, _, erow = node:range()
  local parent = node:parent()
  -- climb until the parent spans strictly more lines (a larger "scope")
  while parent do
    local prow, _, perow = parent:range()
    if prow < srow or perow > erow then
      break
    end
    parent = parent:parent()
  end
  if parent then
    table.insert(s, parent)
    select_node(parent)
  end
end

function M.node_decremental()
  local s = stack[buf()]
  if not s or #s <= 1 then
    return
  end
  table.remove(s)
  select_node(s[#s])
end

function M.setup()
  local map = vim.keymap.set
  map("n", "<C-space>", M.init_selection, { desc = "TS: init selection" })
  map("x", "<C-space>", M.node_incremental, { desc = "TS: grow node" })
  map("x", "<C-s>", M.scope_incremental, { desc = "TS: grow scope" })
  map("x", "<C-x>", M.node_decremental, { desc = "TS: shrink node" })
end

return M
