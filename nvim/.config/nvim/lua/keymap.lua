local function map(mode, bind, exec, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend('force', options, opts)
	end
	vim.api.nvim_set_keymap(mode, bind, exec, options)
end

-- {{{ Panes creation
map('n', 'ne', '<cmd>vsplit<CR>') -- Split current window vertically.
map('n', 'no', '<cmd>split<CR>') -- Split current window horizontally.
map('n', 'nt', '<cmd>tabnew<CR>') -- Open new tab.
-- }}}
--
-- {{{ Panes navigation.
map('n', '<C-J>', '<C-W><C-J>')
map('n', '<C-K>', '<C-W><C-K>')
map('n', '<C-L>', '<C-W><C-L>')
map('n', '<C-H>', '<C-W><C-H>')
-- }}}

-- {{{ Tags.
map('n', '<Leader>]n', '<cmd>tnext<CR>')
map('n', '<Leader>]p', '<cmd>tprevious<CR>')
-- }}}

-- {{{ QuickFix.
map('n', '<Leader>oq', '<cmd>copen<CR>')
map('n', '<Leader>nq', '<cmd>cnext<CR>')
map('n', '<Leader>pq', '<cmd>cprevious<CR>')
-- }}}

-- {{{ LocationList.
map('n', '<Leader>ol', '<cmd>lopen<CR>')
map('n', '<Leader>nl', '<cmd>lnext<CR>')
map('n', '<Leader>pl', '<cmd>lprevious<CR>')
-- }}}

-- {{{ LSP
-- s - show.
map('n', '<Leader>sh', '<cmd>lua vim.lsp.buf.hover()<CR>')
map('n', '<Leader>si', '<cmd>lua vim.lsp.buf.signature_help()<CR>')

-- g - go.
map('n', '<Leader>ge', '<cmd>lua vim.lsp.buf.declaration()<CR>')
map('n', '<Leader>gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
map('n', '<Leader>gI', '<cmd>lua vim.lsp.buf.implementation()<CR>')
map('n', '<Leader>gn', '<cmd>lua vim.diagnostic.goto_next()<CR>')
map('n', '<Leader>gp', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
map('n', '<Leader>gs', '<cmd>ClangdSwitchSourceHeader<CR>')

-- d - do
map('n', '<Leader>di', '<cmd>lua vim.lsp.buf.code_action()<CR>')
map('n', '<Leader>dr', '<cmd>lua vim.lsp.buf.rename()<CR>')
map('n', '<Leader>df', '<cmd>lua vim.lsp.buf.formatting()<CR>')
map('v', '<Leader>df', '<cmd>lua vim.lsp.buf.range_formatting()<CR>')

-- }}}

-- {{{ ALE plugin
map('n', '<Leader>ll', '<cmd>ALELint<CR>')
map('n', '<Leader>lj', '<cmd>ALENext<CR>')
map('n', '<Leader>lk', '<cmd>ALEPrevious<CR>')
map('n', '<Leader>lf', '<cmd>ALEFix<CR>')
-- }}}

-- {{{ Hop plugin
map('n', '<Leader><Leader>w', '<cmd>HopWord<CR>')
map('n', '<Leader><Leader>f', '<cmd>HopWordAC<CR>')
map('n', '<Leader><Leader>b', '<cmd>HopWordBC<CR>')
map('n', '<Leader><Leader>c', '<cmd>HopChar1<CR>')
-- }}}

-- {{{ nvim-tree
map('n', '<F6>', '<cmd>NvimTreeToggle<CR>')
map('n', '<Leader><F6>', '<cmd>NvimTreeFindFile<CR>')
-- }}}

-- {{{ SymbolsOutline
map('n', '<F5>', '<cmd>SymbolsOutline<CR>')
-- }}}

-- {{{ Tabular
map('n', '<Leader>aa', '<cmd>Tabularize / /l0<CR>')
map('n', '<Leader>a=', '<cmd>Tabularize /=/l1<CR>')
map('v', '<Leader>a=', '<cmd>Tabularize /=/l1<CR>')
map('n', '<Leader>a:', '<cmd>Tabularize /:/l1<CR>')
map('v', '<Leader>a:', '<cmd>Tabularize /:/l1<CR>')
map('n', '<Leader>a,', '<cmd>Tabularize /,/l1<CR>')
map('v', '<Leader>a,', '<cmd>Tabularize /,/l1<CR>')
map('n', '<Leader>a(', '<cmd>Tabularize /(/l0<CR>')
map('v', '<Leader>a(', '<cmd>Tabularize /(/l0<CR>')
map('n', '<Leader>a{', '<cmd>Tabularize /{/l0<CR>')
map('v', '<Leader>a{', '<cmd>Tabularize /{/l0<CR>')
map('n', '<Leader>a*', '<cmd>Tabularize /*/l1l0<CR>')
map('v', '<Leader>a*', '<cmd>Tabularize /*/l1l0<CR>')
-- }}}

-- {{{ Tagbar
map('n', '<F4>', '<cmd>TagbarToggle<CR>')
-- }}}

-- {{{ Telescope
map('n', '<Leader>t', '<cmd>lua require("telescope.builtin").find_files()<CR>')
map('n', '<Leader>r', '<cmd>lua require("telescope.builtin").tags()<CR>')
map('n', '<Leader>b', '<cmd>lua require("telescope.builtin").buffers()<CR>')

map('n', '<Leader>gr', '<cmd>lua require("telescope.builtin").lsp_references()<CR>')
map('n', '<Leader>gd', '<cmd>lua require("telescope.builtin").lsp_definitions()<CR>')
map('n', '<Leader>gi', '<cmd>lua require("telescope.builtin").lsp_implementations()<CR>')
map('n', '<Leader>gg', '<cmd>lua require("telescope.builtin").live_grep()<CR>')

map('n', '<Leader>sd', '<cmd>lua require("telescope.builtin").diagnostics()<CR>')
map('n', '<Leader>so', '<cmd>lua require("telescope.builtin").lsp_document_symbols()<CR>')
map('n', '<Leader>ss', '<cmd>lua require("telescope.builtin").lsp_dynamic_workspace_symbols()<CR>')
-- }}}

