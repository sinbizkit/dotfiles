"
"  File: functions.vim
" Created by Ivan Berdnikov on 21/02/20
"

function! Filename()
  return expand('%:t:r')
endfunction

function! Pathname()
  return expand('%:p:h')
endfunction

" Function to create the custom floating window
function! FloatingFZF()
  " creates a scratch, unlisted, new, empty, unnamed buffer
  " to be used in the floating window
  let buf = nvim_create_buf(v:false, v:true)
  " 90% of the height
  let height = float2nr(&lines * 0.9)
  " 60% of the height
  let width = float2nr(&columns * 0.6)
  " horizontal position (centralized)
  let horizontal = float2nr((&columns - width) / 2)
  " vertical position (one line down of the top)
  let vertical = 1
  let opts = {
    \ 'relative': 'editor',
    \ 'row': vertical,
    \ 'col': horizontal,
    \ 'width': width,
    \ 'height': height
    \ }
    " open the new window, floating, and enter to it
  call nvim_open_win(buf, v:true, opts)
endfunction

" Fix current buffer with the`clang-format`.
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

