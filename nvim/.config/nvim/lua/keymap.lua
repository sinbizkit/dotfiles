-- A handy shorthand for vim.api.nvim_set_keymap with reasonable default opts.
local function map(modes, bind, exec, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(modes, bind, exec, options)
end

-- A handy shorthand for vim.api.nvim_buf_set_keymap with reasonable default opts.
local function buf_map(mode, bind, exec, opts)
  local options = { noremap = true, silent = true, buffer = true }
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.keymap.set(mode, bind, exec, options)
end

-- {{{ Motions
map({ "n", "v" }, "<", ",")
map({ "n", "v" }, ">", ";")
-- }}}

-- {{{ Buffer modification
map("n", "J", ":m .+1<CR>==") -- Move current line down
map("n", "K", ":m .-2<CR>==") -- Move current line up
map("v", "J", ":m '>+1<CR>gv=gv") -- Move selected block down
map("v", "K", ":m '<-2<CR>gv=gv") -- Move selected block up
-- }}}

-- {{{ Tabs moving
map("n", "<M-H>", "<Cmd>-tabmove<CR>") -- Move current tab page to the left.
map("n", "<M-L>", "<Cmd>+tabmove<CR>") -- Move current tab page to the right.
-- }}}

-- {{{ Tabs navigation
map("n", "<M-h>", "<Cmd>tabprevious<CR>") -- Move current tab page to the left.
map("n", "<M-l>", "<Cmd>tabnext<CR>") -- Move current tab page to the right.
-- }}}

-- {{{ Panes creation
map("n", "<Space>e", "<Cmd>vsplit<CR>") -- Split current window vertically.
map("n", "<Space>o", "<Cmd>split<CR>") -- Split current window horizontally.
map("n", "<Space>t", "<Cmd>tabnew<CR>") -- Open new tab.
-- }}}
--
-- {{{ Panes navigation.
map("n", "<C-J>", "<C-W><C-J>")
map("n", "<C-K>", "<C-W><C-K>")
map("n", "<C-L>", "<C-W><C-L>")
map("n", "<C-H>", "<C-W><C-H>")
-- }}}

-- {{{ Tags.
map("n", "<Leader>]n", "<Cmd>tnext<CR>")
map("n", "<Leader>]p", "<Cmd>tprevious<CR>")
-- }}}

-- {{{ QuickFix.
map("n", "<Leader>oq", "<Cmd>copen<CR>")
map("n", "<Leader>nq", "<Cmd>cnext<CR>")
map("n", "<Leader>pq", "<Cmd>cprevious<CR>")
-- }}}

-- {{{ LocationList.
map("n", "<Leader>ol", "<Cmd>lopen<CR>")
map("n", "<Leader>nl", "<Cmd>lnext<CR>")
map("n", "<Leader>pl", "<Cmd>lprevious<CR>")
-- }}}

-- {{{ Hop plugin
map("n", "<Leader><Leader>w", "<Cmd>HopWord<CR>")
map("n", "<Leader><Leader>f", "<Cmd>HopWordAC<CR>")
map("n", "<Leader><Leader>b", "<Cmd>HopWordBC<CR>")
map("n", "<Leader><Leader>c", "<Cmd>HopChar1<CR>")
-- }}}

-- {{{ nvim-tree
map("n", "<F6>", "<Cmd>NvimTreeToggle<CR>")
map("n", "<Leader><F6>", "<Cmd>NvimTreeFindFile<CR>")
-- }}}

-- {{{ SymbolsOutline
map("n", "<F5>", "<Cmd>SymbolsOutline<CR>")
-- }}}

-- {{{ Telescope
local builtin = require "telescope.builtin"
-- s - show
map("n", "<Leader>st", builtin.tags)
map("n", "<Leader>sb", builtin.buffers)
map("n", "<Leader>sr", builtin.registers)
map("n", "<Leader>sj", builtin.jumplist)
map("n", "<Leader>sd", function()
  builtin.diagnostics { bufnr = 0 }
end)
-- f- find
map("n", "<Leader>t", builtin.find_files)
map("n", "<Leader>fg", builtin.live_grep)
map("v", "<Leader>fg", function()
  local _, ls, cs = unpack(vim.fn.getpos "v") -- visual selection start
  local _, le, ce = unpack(vim.fn.getpos ".") -- visual selection end
  local st = table.concat(vim.api.nvim_buf_get_text(0, ls - 1, cs - 1, le - 1, ce, {}))
  builtin.grep_string { search = st, word_match = "-w" }
end)
map("n", "<Leader>fk", builtin.keymaps)
map("n", "<Leader>fh", builtin.help_tags)

map("n", "<Leader>v", require("sinbizkit.telescope").find_vimconf)
-- }}}

local ls = require "luasnip"
-- {{{ LuaSnips
map("i", "<C-j>", function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end)

map("i", "<C-k>", function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end)

map("i", "<C-l>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)

-- Snippets reload.
map("n", "<Leader>rs", function()
  local path = vim.api.nvim_get_runtime_file("lua/config/plugin/luasnip.lua", false)
  if #path ~= 1 then
    error "Snippet file not found."
    return
  end
  vim.cmd("source " .. path[1])
  print "Snippets are reloaded."
end)
-- }}}

-- {{{ Gitsigns
local gitsigns = require "gitsigns"
local line = vim.fn.line
-- Stage
map("n", "<Leader>hs", gitsigns.stage_hunk)
map("v", "<Leader>hs", function()
  gitsigns.stage_hunk { line ".", line "v" }
end)
map("n", "<leader>hS", gitsigns.stage_buffer)
-- Reset
map("n", "<Leader>hr", gitsigns.reset_hunk)
map("v", "<Leader>hh", function()
  gitsigns.reset_hunk { line ".", line "v" }
end)
map("n", "<Leader>hR", gitsigns.reset_buffer)
-- Misc
map("n", "<Leader>hu", gitsigns.undo_stage_hunk)
map("n", "<Leader>hp", gitsigns.preview_hunk)
map("n", "<Leader>hd", gitsigns.diffthis)
map("n", "<Leader>hD", function()
  gitsigns.diffthis "~"
end)
map("n", "<Leader>hb", function()
  gitsigns.blame_line { full = true }
end)
-- }}}

local M = {
  map = map,
  buf_map = buf_map,
}

-- Sets keybindings for interaction with LSP servers.
M.map_lsp_keys = function()
  -- s - show.
  buf_map("n", "<Leader>sh", vim.lsp.buf.hover)
  buf_map("n", "<Leader>si", vim.lsp.buf.signature_help)

  -- g - go.
  buf_map("n", "<Leader>ge", vim.lsp.buf.declaration)
  buf_map("n", "<Leader>gt", vim.lsp.buf.type_definition)
  buf_map("n", "<Leader>gI", vim.lsp.buf.implementation)
  buf_map("n", "<Leader>gn", vim.diagnostic.goto_next)
  buf_map("n", "<Leader>gp", vim.diagnostic.goto_prev)

  -- d - do
  buf_map("n", "<Leader>di", vim.lsp.buf.code_action)
  buf_map("n", "<Leader>dr", vim.lsp.buf.rename)
  buf_map({ "n", "v" }, "<Leader>df", vim.lsp.buf.format)

  -- Telescope
  buf_map("n", "<Leader>gr", builtin.lsp_references)
  buf_map("n", "<Leader>gd", builtin.lsp_definitions)
  buf_map("n", "<Leader>gi", builtin.lsp_implementations)
  buf_map("n", "<Leader>so", builtin.lsp_document_symbols)
  buf_map("n", "<Leader>ss", builtin.lsp_dynamic_workspace_symbols)
end

return M
