local function map(mode, bind, exec, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend('force', options, opts)
	end
	vim.api.nvim_set_keymap(mode, bind, exec, options)
end

-- {{{ Panes creation
map('n', 'ne', ':vsplit<CR>') -- Split current window vertically.
map('n', 'no', ':split<CR>') -- Split current window horizontally.
map('n', 'nt', ':tabnew<CR>') -- Open new tab.
map('n', '<Leader>ww', ':%s/s+$//<CR>') -- Remove trailing whitespaces
-- }}}
--
-- {{{ Panes navigation.
map('n', '<C-J>', '<C-W><C-J>')
map('n', '<C-K>', '<C-W><C-K>')
map('n', '<C-L>', '<C-W><C-L>')
map('n', '<C-H>', '<C-W><C-H>')
-- }}}

-- {{{ Tags.
map('n', '<Leader>]n', ':tnext<CR>')
map('n', '<Leader>]p', ':tprevious<CR>')
-- }}}

-- {{{ QuickFix.
map('n', '<Leader>oq', ':copen<CR>')
map('n', '<Leader>nq', ':cnext<CR>')
map('n', '<Leader>pq', ':cprevious<CR>')
-- }}}

-- {{{ LocationList.
map('n', '<Leader>ol', ':lopen<CR>')
map('n', '<Leader>nl', ':lnext<CR>')
map('n', '<Leader>pl', ':lprevious<CR>')
-- }}}

-- {{{ LSP
-- s - show.
map('n', '<Leader>sh', ':lua vim.lsp.buf.hover()<CR>')
map('n', '<Leader>si', ':lua vim.lsp.buf.signature_help()<CR>')

-- g - go.
map('n', '<Leader>ge', ':lua vim.lsp.buf.declaration()<CR>')
map('n', '<Leader>gt', ':lua vim.lsp.buf.type_definition()<CR>')
map('n', '<Leader>gI', ':lua vim.lsp.buf.implementation()<CR>')
map('n', '<Leader>gn', ':lua vim.diagnostic.goto_next()<CR>')
map('n', '<Leader>gp', ':lua vim.diagnostic.goto_prev()<CR>')
map('n', '<Leader>gs', ':ClangdSwitchSourceHeader<CR>')

-- d - do
map('n', '<Leader>di', ':lua vim.lsp.buf.code_action()<CR>')
map('n', '<Leader>dr', ':lua vim.lsp.buf.rename()<CR>')
map('n', '<Leader>df', ':lua vim.lsp.buf.formatting()<CR>')
map('v', '<Leader>df', ':lua vim.lsp.buf.range_formatting()<CR>')

-- }}}

-- {{{ ALE plugin
map('n', '<Leader>ll', ':ALELint<CR>')
map('n', '<Leader>lj', ':ALENext<CR>')
map('n', '<Leader>lk', ':ALEPrevious<CR>')
map('n', '<Leader>lf', ':ALEFix<CR>')
-- }}}

-- {{{ Hop plugin
map('n', '<Leader><Leader>w', ':HopWord<CR>')
map('n', '<Leader><Leader>f', ':HopWordAC<CR>')
map('n', '<Leader><Leader>b', ':HopWordBC<CR>')
map('n', '<Leader><Leader>c', ':HopChar1<CR>')
-- }}}

-- {{{ nvim-tree
map('n', '<F6>', ':NvimTreeToggle<CR>')
map('n', '<Leader><F6>', ':NvimTreeFindFile<CR>')
-- }}}

-- {{{ SymbolsOutline
map('n', '<F5>', ':SymbolsOutline<CR>')
-- }}}

-- {{{ Tabular
map('n', '<Leader>aa', ':Tabularize / /l0<CR>')
map('n', '<Leader>a=', ':Tabularize /=/l1<CR>')
map('v', '<Leader>a=', ':Tabularize /=/l1<CR>')
map('n', '<Leader>a:', ':Tabularize /:/l1<CR>')
map('v', '<Leader>a:', ':Tabularize /:/l1<CR>')
map('n', '<Leader>a,', ':Tabularize /,/l1<CR>')
map('v', '<Leader>a,', ':Tabularize /,/l1<CR>')
map('n', '<Leader>a(', ':Tabularize /(/l0<CR>')
map('v', '<Leader>a(', ':Tabularize /(/l0<CR>')
map('n', '<Leader>a{', ':Tabularize /{/l0<CR>')
map('v', '<Leader>a{', ':Tabularize /{/l0<CR>')
map('n', '<Leader>a*', ':Tabularize /*/l1l0<CR>')
map('v', '<Leader>a*', ':Tabularize /*/l1l0<CR>')
-- }}}

-- {{{ Tagbar
map('n', '<F4>', ':TagbarToggle<CR>')
-- }}}

-- {{{ Telescope
map('n', '<Leader>t', ':lua require("telescope.builtin").find_files()<CR>')
map('n', '<Leader>r', ':lua require("telescope.builtin").tags()<CR>')
map('n', '<Leader>b', ':lua require("telescope.builtin").buffers()<CR>')

map('n', '<Leader>gr', ':lua require("telescope.builtin").lsp_references()<CR>')
map('n', '<Leader>gd', ':lua require("telescope.builtin").lsp_definitions()<CR>')
map('n', '<Leader>gi', ':lua require("telescope.builtin").lsp_implementations()<CR>')
map('n', '<Leader>gg', ':lua require("telescope.builtin").live_grep()<CR>')

map('n', '<Leader>so', ':lua require("telescope.builtin").lsp_document_symbols()<CR>')
map('n', '<Leader>ss', ':lua require("telescope.builtin").lsp_dynamic_workspace_symbols()<CR>')
-- }}}

-- {{{ Trouble
map('n', '<Leader>sd', ':TroubleToggle<CR>')
-- }}}
