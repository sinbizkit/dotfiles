local opt = vim.opt
local g = vim.g

opt.exrc = true
opt.secure = true

opt.errorbells = false
opt.mouse = "a"

-- Disable data-loss-safety stuff. In any case an vcs will help.
opt.swapfile = false
opt.writebackup = false
opt.backup = false

opt.autoread = true

g.loaded_ruby_provider = 0
g.loaded_perl_provider = 0

opt.clipboard = "unnamedplus"

-- {{{ Appearance
opt.termguicolors = true
opt.encoding = "utf-8" -- Default encoding.

opt.list = true
opt.listchars = { tab = "•·", space = "·", eol = "↲", extends = "❯", precedes = "❮", trail = "~", nbsp = "⦸" }
opt.cursorline = true -- Highlighting that moves with the cursor.
opt.showmode = false -- Turn off the native mode indicator.

opt.foldmethod = "expr" -- Use treesitter.
opt.foldexpr = "nvim_treesitter#foldexpr()" -- Use treesitter.
opt.foldlevel = 3 -- Close folds with the higher level.

opt.showtabline = 2 -- Always show the line with tab page labels.
opt.shortmess = "atIc" -- Remove all useless messages.
opt.pumheight = 15 -- Maximum number of items showed in a popup menu.
opt.signcolumn = "yes" -- Always show the sign column.

opt.splitbelow = true -- Splitting will put the new window below the current one.
opt.splitright = true -- Splitting will put the new window right of the current one.

opt.number = true -- Print the linenumber in front of each line.
opt.relativenumber = true -- Show the line number relative to the line.

opt.wrap = true -- Enable line wrapping.

-- Search settings.
opt.incsearch = true
opt.hlsearch = true
opt.inccommand = "split" -- Show search preview.
-- Enable ignorecase + smartcase for better searching
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- This will show the popup menu even if there's only one match (menuone),
-- prevent automatic selection (noselect) and prevent automatic text injection
-- into the current line (noinsert).
opt.completeopt = { "noinsert", "menuone", "noselect" }
opt.laststatus = 2 -- The last window will always have a status line.

local signs = { Error = "", Warn = "", Hint = "", Info = "" }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
-- }}}
