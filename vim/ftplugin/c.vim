let &colorcolumn="80,".join(range(121, 999),",")

" Format the current buffer using `clang-format`.
nnoremap <silent> <Leader>cf :call clangformat#FixBuffer()<CR>
vnoremap <silent> <Leader>cf :call clangformat#FixBuffer()<CR>
