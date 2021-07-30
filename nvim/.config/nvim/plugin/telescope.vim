nnoremap <silent><leader>t :lua require('telescope.builtin').find_files()<CR>
nnoremap <silent><leader>r :lua require('telescope.builtin').tags()<CR>
nnoremap <silent><leader>b :lua require('telescope.builtin').buffers()<CR>

nnoremap <silent><leader>gr :lua require('telescope.builtin').lsp_references()<CR>
nnoremap <silent><leader>so :lua require('telescope.builtin').lsp_document_symbols()<CR>
nnoremap <silent><leader>ss :lua require('telescope.builtin').lsp_workspace_symbols()<CR>
