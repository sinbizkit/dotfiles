let &colorcolumn="80,".join(range(121, 999),",")

setlocal noexpandtab
setlocal tabstop=8
setlocal softtabstop=4
setlocal shiftwidth=4

let b:ale_linters              = [ 'clazy', 'clangtidy' ]
let b:ale_fixers               = [ 'clang-format' ]


function! g:CallClangFormat()
  if !exists('s:clang_format_py_path')
    let l:prefixes = ['/usr', 'usr/local', $HOME.'/.local']
    let l:postfix = '/share/clang/clang-format.py'
    for prefix in l:prefixes
      if executable(l:prefix.l:postfix)
        let s:clang_format_py_path = l:prefix.l:postfix
        break
      endif
    endfor

    if !exists('s:clang_format_py_path')
      echom '[Warning] `clang-format.py` not found.'
      return
    endif
  endif

  let l:lines = 'all'
  execute 'pyf' s:clang_format_py_path
endfunction

nnoremap <silent> <Leader>cf :call g:CallClangFormat()<CR>
vnoremap <silent> <Leader>cf :call g:CallClangFormat()<CR>

