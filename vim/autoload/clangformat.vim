" Formats the current buffer with help of `ClangFormat` tool.
" It searches for the `clang-format.py` python script, which is provided by
" LLVM team and invokes it, setting the `l:lines` to `all` first.
function! clangformat#FixBuffer()
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

