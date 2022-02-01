local function map(mode, bind, exec, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend('force', options, opts)
	end
	vim.api.nvim_set_keymap(mode, bind, exec, options)
end

-- {{{ Panes creation
map('n', 'ne', '<Cmd>vsplit<CR>') -- Split current window vertically.
map('n', 'no', '<Cmd>split<CR>') -- Split current window horizontally.
map('n', 'nt', '<Cmd>tabnew<CR>') -- Open new tab.
-- }}}
--
-- {{{ Panes navigation.
map('n', '<C-J>', '<C-W><C-J>')
map('n', '<C-K>', '<C-W><C-K>')
map('n', '<C-L>', '<C-W><C-L>')
map('n', '<C-H>', '<C-W><C-H>')
-- }}}

-- {{{ Tags.
map('n', '<Leader>]n', '<Cmd>tnext<CR>')
map('n', '<Leader>]p', '<Cmd>tprevious<CR>')
-- }}}

-- {{{ QuickFix.
map('n', '<Leader>oq', '<Cmd>copen<CR>')
map('n', '<Leader>nq', '<Cmd>cnext<CR>')
map('n', '<Leader>pq', '<Cmd>cprevious<CR>')
-- }}}

-- {{{ LocationList.
map('n', '<Leader>ol', '<Cmd>lopen<CR>')
map('n', '<Leader>nl', '<Cmd>lnext<CR>')
map('n', '<Leader>pl', '<Cmd>lprevious<CR>')
-- }}}

-- {{{ LSP
-- s - show.
map('n', '<Leader>sh', '<Cmd>lua vim.lsp.buf.hover()<CR>')
map('n', '<Leader>si', '<Cmd>lua vim.lsp.buf.signature_help()<CR>')

-- g - go.
map('n', '<Leader>ge', '<Cmd>lua vim.lsp.buf.declaration()<CR>')
map('n', '<Leader>gt', '<Cmd>lua vim.lsp.buf.type_definition()<CR>')
map('n', '<Leader>gI', '<Cmd>lua vim.lsp.buf.implementation()<CR>')
map('n', '<Leader>gn', '<Cmd>lua vim.diagnostic.goto_next()<CR>')
map('n', '<Leader>gp', '<Cmd>lua vim.diagnostic.goto_prev()<CR>')
map('n', '<Leader>gs', '<Cmd>ClangdSwitchSourceHeader<CR>')

-- d - do
map('n', '<Leader>di', '<Cmd>lua vim.lsp.buf.code_action()<CR>')
map('n', '<Leader>dr', '<Cmd>lua vim.lsp.buf.rename()<CR>')
map('n', '<Leader>df', '<Cmd>lua vim.lsp.buf.formatting()<CR>')
map('v', '<Leader>df', '<Cmd>lua vim.lsp.buf.range_formatting()<CR>')

-- }}}

-- {{{ ALE plugin
map('n', '<Leader>ll', '<Cmd>ALELint<CR>')
map('n', '<Leader>lj', '<Cmd>ALENext<CR>')
map('n', '<Leader>lk', '<Cmd>ALEPrevious<CR>')
map('n', '<Leader>lf', '<Cmd>ALEFix<CR>')
-- }}}

-- {{{ Hop plugin
map('n', '<Leader><Leader>w', '<Cmd>HopWord<CR>')
map('n', '<Leader><Leader>f', '<Cmd>HopWordAC<CR>')
map('n', '<Leader><Leader>b', '<Cmd>HopWordBC<CR>')
map('n', '<Leader><Leader>c', '<Cmd>HopChar1<CR>')
-- }}}

-- {{{ nvim-tree
map('n', '<F6>', '<Cmd>NvimTreeToggle<CR>')
map('n', '<Leader><F6>', '<Cmd>NvimTreeFindFile<CR>')
-- }}}

-- {{{ SymbolsOutline
map('n', '<F5>', '<Cmd>SymbolsOutline<CR>')
-- }}}

-- {{{ Tabular
map('n', '<Leader>aa', '<Cmd>Tabularize / /l0<CR>')
map('n', '<Leader>a=', '<Cmd>Tabularize /=/l1<CR>')
map('v', '<Leader>a=', '<Cmd>Tabularize /=/l1<CR>')
map('n', '<Leader>a:', '<Cmd>Tabularize /:/l1<CR>')
map('v', '<Leader>a:', '<Cmd>Tabularize /:/l1<CR>')
map('n', '<Leader>a,', '<Cmd>Tabularize /,/l1<CR>')
map('v', '<Leader>a,', '<Cmd>Tabularize /,/l1<CR>')
map('n', '<Leader>a(', '<Cmd>Tabularize /(/l0<CR>')
map('v', '<Leader>a(', '<Cmd>Tabularize /(/l0<CR>')
map('n', '<Leader>a{', '<Cmd>Tabularize /{/l0<CR>')
map('v', '<Leader>a{', '<Cmd>Tabularize /{/l0<CR>')
map('n', '<Leader>a*', '<Cmd>Tabularize /*/l1l0<CR>')
map('v', '<Leader>a*', '<Cmd>Tabularize /*/l1l0<CR>')
-- }}}

-- {{{ Tagbar
map('n', '<F4>', '<Cmd>TagbarToggle<CR>')
-- }}}

-- {{{ Telescope
map('n', '<Leader>t', '<Cmd>lua require("telescope.builtin").find_files()<CR>')
map('n', '<Leader>r', '<Cmd>lua require("telescope.builtin").tags()<CR>')
map('n', '<Leader>b', '<Cmd>lua require("telescope.builtin").buffers()<CR>')

map('n', '<Leader>gr', '<Cmd>lua require("telescope.builtin").lsp_references()<CR>')
map('n', '<Leader>gd', '<Cmd>lua require("telescope.builtin").lsp_definitions()<CR>')
map('n', '<Leader>gi', '<Cmd>lua require("telescope.builtin").lsp_implementations()<CR>')
map('n', '<Leader>gg', '<Cmd>lua require("telescope.builtin").live_grep()<CR>')

map('n', '<Leader>sd', '<Cmd>lua require("telescope.builtin").diagnostics()<CR>')
map('n', '<Leader>so', '<Cmd>lua require("telescope.builtin").lsp_document_symbols()<CR>')
map('n', '<Leader>ss', '<Cmd>lua require("telescope.builtin").lsp_dynamic_workspace_symbols()<CR>')
-- }}}

