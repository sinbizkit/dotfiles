let &colorcolumn="80,".join(range(121, 999),",")

setlocal noexpandtab
setlocal tabstop=4
setlocal softtabstop=4
setlocal shiftwidth=4


let b:ale_linters = [ 'clazy', 'clangtidy' ]
let b:ale_fixers  = [ 'clang-format' ]


nnoremap <silent> <Leader>cf :call g:CallClangFormat()<CR>
vnoremap <silent> <Leader>cf :call g:CallClangFormat()<CR>
