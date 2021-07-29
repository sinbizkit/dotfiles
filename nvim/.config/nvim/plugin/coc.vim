let g:coc_global_extensions = [
  \ 'coc-highlight'
  \ , 'coc-clangd'
  \ , 'coc-ultisnips'
  \ , 'coc-rust-analyzer'
  \ , 'coc-pyright'
  \ , 'coc-json'
  \ ]

" Enable highlight on CursorHold.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Trigger autocompletion.
imap <silent><expr> <c-space> coc#refresh()
" Go to definition.
nmap <silent> <Leader>gd <Plug>(coc-definition)
" Go to declaration.
nmap <silent> <Leader>ge <Plug>(coc-declaration)
" Go to implementation.
nmap <silent> <Leader>gi <Plug>(coc-implementation)
" Go to references.
nmap <silent> <Leader>gr <Plug>(coc-references)
" Go to next diagnostic error position.
nmap <silent> <Leader>gn <Plug>(coc-diagnostic-next-error)
" Go to prev diagnostic error position.
nmap <silent> <Leader>gp <Plug>(coc-diagnostic-prev-error)

" Show hover (documentation of the current word).
nmap <silent> <Leader>sh :call CocActionAsync('doHover')<CR>
" Show diagnostic.
nmap <silent> <Leader>sd :CocList diagnostics<CR>
" Show outline (Symbols in the current document).
nmap <silent> <Leader>so :CocList outline<CR>
" Show all symbols.
nmap <silent> <Leader>ss :CocList symbols<CR>

" Do rename symbol.
nmap <silent> <Leader>dr <Plug>(coc-rename)
" Do refactor.
nmap <silent> <Leader>de <Plug>(coc-refactor)
" Do fix
nmap <silent> <Leader>di <Plug>(coc-fix-current)

" Do format
nmap <silent> <Leader>df <Plug>(coc-format)
vmap <silent> <Leader>df <Plug>(coc-format-selected)

