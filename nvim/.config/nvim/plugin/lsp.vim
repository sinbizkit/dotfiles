lua require'lspconfig'.clangd.setup{}
lua require'lspconfig'.rust_analyzer.setup{}
lua require'lspconfig'.gopls.setup{}
lua require'lspconfig'.cmake.setup{}

" s - show.
nnoremap <silent><leader>sh :lua vim.lsp.buf.hover()<CR>
nnoremap <silent><leader>si :lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent><leader>sf :Lspsaga lsp_finder<CR>
nnoremap <silent><leader>sp :Lspsaga preview_definition<CR>

" g - go.
nnoremap <silent><leader>ge :lua vim.lsp.buf.declaration()<CR>
nnoremap <silent><leader>gn :lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <silent><leader>gp :lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <silent><leader>gs :ClangdSwitchSourceHeader<Cr>

" d - do
nnoremap <silent><leader>df :lua vim.lsp.buf.formatting()<CR>
vnoremap <silent><leader>df :lua vim.lsp.buf.range_formatting()<CR>

sign define LspDiagnosticsSignError text=✘ texthl=LspDiagnosticsSignError linehl= numhl=
sign define LspDiagnosticsSignWarning text= texthl=LspDiagnosticsSignWarning linehl= numhl=
sign define LspDiagnosticsSignInformation text=  texthl=LspDiagnosticsSignInformation linehl= numhl=
sign define LspDiagnosticsSignHint text=💡 texthl=LspDiagnosticsSignHint linehl= numhl=
