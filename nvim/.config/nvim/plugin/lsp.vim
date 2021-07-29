lua require'lspconfig'.clangd.setup{}
lua require'lspconfig'.rust_analyzer.setup{}

" g - go.
nnoremap <silent><leader>ge :lua vim.lsp.buf.declaration()<CR>
nnoremap <silent><leader>gd :lua vim.lsp.buf.definition()<CR>
nnoremap <silent><leader>gi :lua vim.lsp.buf.implementation()<CR>
nnoremap <silent><leader>gr :lua vim.lsp.buf.references()<CR>
nnoremap <silent><leader>gn :lua vim.lsp.diagnostic.goto_next()<CR>
nnoremap <silent><leader>gp :lua vim.lsp.diatnostic.goto_prev()<CR>

" s- show
nnoremap <silent><leader>sh :lua vim.lsp.buf.hover()<CR>
nnoremap <silent><leader>si :lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent><leader>so :lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent><leader>ss :lua vim.lsp.buf.workspace_symbol()<CR>

" d - do
nnoremap <silent><leader>dr :lua vim.lsp.buf.rename()<CR>
nnoremap <silent><leader>df :lua vim.lsp.buf.formatting()<CR>
vnoremap <silent><leader>df :lua vim.lsp.buf.range_formatting()<CR>
nnoremap <silent><leader>di :lua vim.lsp.buf.code_action()<CR>

sign define LspDiagnosticsSignError text=✘ texthl=LspDiagnosticsSignError linehl= numhl=
sign define LspDiagnosticsSignWarning text= texthl=LspDiagnosticsSignWarning linehl= numhl=
sign define LspDiagnosticsSignInformation text=  texthl=LspDiagnosticsSignInformation linehl= numhl=
sign define LspDiagnosticsSignHint text=💡 texthl=LspDiagnosticsSignHint linehl= numhl=
